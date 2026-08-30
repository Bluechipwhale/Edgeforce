// ==============================================================================
// EDGEWFORCE - AUTHENTICATION SERVICE
// ==============================================================================

import bcrypt from 'bcryptjs';
import { db } from '../config/database.js';
import { signUserToken } from '../middleware/auth.js';
import { recordAudit } from '../middleware/auditLogger.js';
import { emailService } from './emailService.js';
import { normalizePhone, isEmail, normalizeEmail } from '../utils/phoneNormalizer.js';

export const authService = {
  /**
   * Logs in an enterprise user via Email or Phone number.
   */
  async login(identifier, password, req = null) {
    if (!identifier || !password) {
      throw new Error('Please enter your email address or phone number, and your password.');
    }

    const trimmedInput = String(identifier).trim();
    let user = null;

    if (isEmail(trimmedInput)) {
      const normalizedEmail = normalizeEmail(trimmedInput);
      user = await db.findOne('users', { email: normalizedEmail });
      if (!user) {
        const employees = await db.find('employees');
        const emp = employees.find(e => 
          (e.work_email && normalizeEmail(e.work_email) === normalizedEmail) ||
          (e.personal_email && normalizeEmail(e.personal_email) === normalizedEmail)
        );
        if (emp?.user_id) {
          user = await db.findById('users', emp.user_id);
        }
      }
    } else {
      const normalizedPhone = normalizePhone(trimmedInput);
      if (normalizedPhone) {
        user = await db.findOne('users', { phone: normalizedPhone });
        if (!user) {
          const employees = await db.find('employees');
          const emp = employees.find(e => normalizePhone(e.phone) === normalizedPhone);
          if (emp?.user_id) {
            user = await db.findById('users', emp.user_id);
          }
        }
      }
    }

    // Fallback: Support login via Staff ID / Employee Code (e.g. EMP-1001, EMP-003, 003)
    if (!user) {
      const employees = await db.find('employees');
      const cleanInput = trimmedInput.toUpperCase();
      const numOnly = cleanInput.replace(/[^0-9]/g, '');
      const emp = employees.find(e => {
        const empCode = (e.employee_code || '').toUpperCase();
        const staffId = String(e.staff_id || '').toUpperCase();
        const empNum = empCode.replace(/[^0-9]/g, '');
        return (
          empCode === cleanInput ||
          staffId === cleanInput ||
          (numOnly && empNum === numOnly) ||
          (numOnly && staffId === numOnly)
        );
      });
      if (emp?.user_id) {
        user = await db.findById('users', emp.user_id);
      }
    }

    if (!user) {
      throw new Error('Invalid login credentials.');
    }

    if (user.status !== 'active') {
      throw new Error('This account has been deactivated. Please contact your HR administrator.');
    }

    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      throw new Error('Invalid login credentials.');
    }

    // Update last login asynchronously without blocking response
    db.update('users', user.id, { last_login_at: new Date().toISOString() }).catch(() => {});
    recordAudit(user, 'LOGIN', 'users', user.id, { email: user.email, phone: user.phone }, req).catch(() => {});

    const token = signUserToken(user);
    const employee = await db.findOne('employees', { user_id: user.id });
    
    const [rank, department] = await Promise.all([
      employee?.rank_code ? db.findOne('ranks', { code: employee.rank_code }) : null,
      employee?.department_id ? db.findById('departments', employee.department_id) : (employee?.department ? { name: employee.department } : null)
    ]);

    const userProfile = {
      id: user.id,
      email: user.email,
      full_name: user.full_name,
      phone: user.phone,
      role_code: user.role_code,
      status: user.status,
      requires_password_change: Boolean(user.requires_password_change),
      onboarding_status: user.onboarding_status || 'Active',
      employee,
      rank,
      department
    };

    return {
      token,
      user: userProfile
    };
  },

  /**
   * Gets current user session profile.
   */
  async me(userId) {
    const user = await db.findById('users', userId);
    if (!user) throw new Error('User not found');

    const employee = await db.findOne('employees', { user_id: user.id });
    const [rank, department] = await Promise.all([
      employee?.rank_code ? db.findOne('ranks', { code: employee.rank_code }) : null,
      employee?.department_id ? db.findById('departments', employee.department_id) : (employee?.department ? { name: employee.department } : null)
    ]);

    return {
      id: user.id,
      email: user.email,
      full_name: user.full_name,
      phone: user.phone,
      role_code: user.role_code,
      status: user.status,
      requires_password_change: Boolean(user.requires_password_change),
      onboarding_status: user.onboarding_status || 'Active',
      employee,
      rank,
      department
    };
  },

  /**
   * Changes user password.
   */
  async changePassword(userId, currentPassword, newPassword, req = null) {
    if (!newPassword || newPassword.length < 8) {
      throw new Error('New password must be at least 8 characters long.');
    }

    const user = await db.findById('users', userId);
    if (!user) throw new Error('User not found');

    const isMatch = await bcrypt.compare(currentPassword, user.password_hash);
    if (!isMatch) {
      throw new Error('Current password is incorrect.');
    }

    const newHash = await bcrypt.hash(newPassword, 10);
    await db.update('users', user.id, {
      password_hash: newHash,
      requires_password_change: false
    });

    await recordAudit(user, 'PASSWORD_CHANGED', 'users', user.id, {}, req);

    return { message: 'Password updated successfully.' };
  },

  /**
   * Registers a new staff member with rank & department.
   * Supports Email Only, Phone Only, or Email + Phone.
   */
  async registerEmployee(data, actor = null, req = null) {
    const { full_name, email, password, phone, role_code, rank_code, department, position, base_salary } = data;

    if (!full_name || !password) {
      throw new Error('Full name and password are required.');
    }

    if (!email && !phone) {
      throw new Error('Please provide an email address or phone number.');
    }

    let normalizedEmail = null;
    if (email && email.trim()) {
      normalizedEmail = normalizeEmail(email);
      const existing = await db.findOne('users', { email: normalizedEmail });
      if (existing) {
        throw new Error('Email already registered.');
      }
    }

    let normalizedPhone = null;
    if (phone && String(phone).trim()) {
      normalizedPhone = normalizePhone(phone);
      const existingPhone = await db.findOne('users', { phone: normalizedPhone }) || await db.findOne('employees', { phone: normalizedPhone });
      if (existingPhone) {
        throw new Error('Phone number already registered.');
      }
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const user = await db.insert('users', {
      full_name,
      email: normalizedEmail,
      phone: normalizedPhone,
      password_hash: passwordHash,
      role_code: role_code || 'EMPLOYEE',
      status: 'active'
    });

    const empCode = `EMP-${1000 + Number(user.id)}`;
    const [firstName, ...rest] = full_name.split(' ');
    const lastName = rest.join(' ') || firstName;

    const employee = await db.insert('employees', {
      user_id: user.id,
      employee_code: empCode,
      first_name: firstName,
      last_name: lastName,
      email: normalizedEmail,
      phone: normalizedPhone,
      department: department || 'Operations',
      position: position || 'Staff Member',
      rank_code: rank_code || 'STAFF',
      base_salary: Number(base_salary || 350000)
    });

    // Initialize leave balance
    await db.insert('leave_balances', {
      employee_id: employee.id,
      year: new Date().getFullYear(),
      annual: 20,
      sick: 12,
      casual: 5
    });

    await recordAudit(actor || user, 'EMPLOYEE_CREATED', 'employees', employee.id, { employee_code: empCode, email: normalizedEmail, phone: normalizedPhone }, req);

    return { user, employee };
  },

  /**
   * Generates a password reset PIN/token for an employee using Email or Phone.
   */
  async forgotPassword(identifier, req = null) {
    if (!identifier) throw new Error('Please provide your registered email address or phone number.');
    const trimmed = String(identifier).trim();
    let user = null;

    if (isEmail(trimmed)) {
      const normalizedEmail = normalizeEmail(trimmed);
      user = await db.findOne('users', { email: normalizedEmail });
    } else {
      const normalizedPhone = normalizePhone(trimmed);
      if (normalizedPhone) {
        user = await db.findOne('users', { phone: normalizedPhone });
        if (!user) {
          const emp = await db.findOne('employees', { phone: normalizedPhone });
          if (emp?.user_id) user = await db.findById('users', emp.user_id);
        }
      }
    }

    if (!user) {
      // Avoid enumeration while providing standard response
      return {
        success: true,
        message: `If an account with ${identifier} exists, password reset instructions and security token have been generated.`
      };
    }

    // Generate 6-digit secure numeric reset token
    const resetToken = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000).toISOString(); // 1 hour validity

    await db.update('users', user.id, {
      reset_token: resetToken,
      reset_token_expires_at: expiresAt
    });

    await recordAudit(user, 'PASSWORD_RESET_REQUESTED', 'users', user.id, { identifier }, req);

    let emailDelivered = false;
    if (user.email) {
      const emailResult = await emailService.sendPasswordResetEmail(user.email, resetToken, user.full_name || 'Staff Member');
      emailDelivered = emailResult.delivered;
    }

    const msg = emailDelivered
      ? `A 6-digit password reset code has been sent to ${user.email}. Please check your inbox.`
      : `Password reset verification code generated: ${resetToken}`;

    return {
      success: true,
      message: msg,
      reset_token: resetToken,
      identifier: user.email || user.phone,
      email_sent: emailDelivered
    };
  },

  /**
   * Resets password using verification token and Email/Phone identifier.
   */
  async resetPassword(identifier, token, newPassword, req = null) {
    if (!identifier || !token || !newPassword) {
      throw new Error('Identifier (email or phone), verification code, and new password are required.');
    }
    if (newPassword.length < 8) {
      throw new Error('New password must be at least 8 characters long.');
    }

    const trimmed = String(identifier).trim();
    let user = null;

    if (isEmail(trimmed)) {
      const normalizedEmail = normalizeEmail(trimmed);
      user = await db.findOne('users', { email: normalizedEmail });
    } else {
      const normalizedPhone = normalizePhone(trimmed);
      if (normalizedPhone) {
        user = await db.findOne('users', { phone: normalizedPhone });
        if (!user) {
          const emp = await db.findOne('employees', { phone: normalizedPhone });
          if (emp?.user_id) user = await db.findById('users', emp.user_id);
        }
      }
    }

    if (!user) {
      throw new Error('Invalid email, phone number, or verification code.');
    }

    if (!user.reset_token || user.reset_token !== token.trim()) {
      throw new Error('Invalid verification code. Please check and try again.');
    }

    if (user.reset_token_expires_at && new Date(user.reset_token_expires_at) < new Date()) {
      throw new Error('Verification code has expired. Please request a new code.');
    }

    const newHash = await bcrypt.hash(newPassword, 10);
    await db.update('users', user.id, {
      password_hash: newHash,
      reset_token: null,
      reset_token_expires_at: null,
      requires_password_change: false
    });

    await recordAudit(user, 'PASSWORD_RESET_COMPLETED', 'users', user.id, { identifier }, req);

    return {
      success: true,
      message: 'Password reset successfully! You can now sign in with your new password.'
    };
  }
};

