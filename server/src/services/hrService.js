// ==============================================================================
// EDGEWFORCE - HUMAN RESOURCES COMMAND CENTER SERVICE
// Workforce Analytics, Idle Monitoring, Hierarchy Enforcement & Organization Chart
// ==============================================================================

import bcrypt from 'bcryptjs';
import { db } from '../config/database.js';
import { validateHierarchyAssignment } from '../middleware/rbac.js';
import { recordAudit } from '../middleware/auditLogger.js';
import { normalizePhone, normalizeEmail } from '../utils/phoneNormalizer.js';
import { locationService } from './locationService.js';


export const hrService = {
  /**
   * Retrieves high-level workforce metrics for HR Command Center.
   */
  async getDashboardStats() {
    const todayStr = new Date().toISOString().slice(0, 10);
    const employees = await db.find('employees', { status: 'active' });
    const attendance = await db.find('attendance', { date: todayStr });
    const idleRecords = await db.find('idle_alerts', { resolved: false });
    const openSOS = await db.find('sos', { status: 'active' });
    const leaveRequests = await db.find('leave_requests', { status: 'pending' });
    const tasks = await db.find('tasks');
    const activeTasks = tasks.filter(t => t.status !== 'completed' && t.status !== 'Cancelled');

    const presentCount = attendance.filter(a => a.status === 'Present' || a.status === 'Late').length;
    const lateCount = attendance.filter(a => a.status === 'Late').length;
    const onLeaveCount = attendance.filter(a => a.status === 'On Leave').length;
    const absentCount = Math.max(0, employees.length - presentCount - onLeaveCount);

    const fullIdleRecords = await Promise.all(
      idleRecords.map(async (rec) => {
        const emp = employees.find(e => Number(e.id) === Number(rec.employee_id));
        return { ...rec, employee: emp };
      })
    );

    const fullPendingLeaves = await Promise.all(
      leaveRequests.map(async (req) => {
        const emp = employees.find(e => Number(e.id) === Number(req.employee_id));
        return { ...req, employee: emp };
      })
    );

    return {
      total_staff: employees.length,
      present_today: presentCount,
      late_today: lateCount,
      absent_today: absentCount,
      on_leave_today: onLeaveCount,
      currently_idle: idleRecords.length,
      idle_alerts: idleRecords.length,
      open_sos: openSOS.length,
      pending_leave: leaveRequests.length,
      active_tasks: activeTasks.length,
      idle_records: fullIdleRecords,
      pending_leaves: fullPendingLeaves,
      sos: openSOS
    };
  },

  /**
   * Retrieves employee directory with rank and department relational data.
   * Redacts base_salary and allowance figures for any non-HR / non-CEO users.
   */
  async getEmployees(actor = null) {
    const isHrOrCeo = actor && (
      actor.role_code === 'HR' ||
      actor.role_code === 'HR_MANAGER' ||
      actor.role_code === 'CEO' ||
      actor.rank?.code === 'CEO' ||
      actor.rank?.code === 'HR' ||
      actor.email === 'ceo@edgewforce.com' ||
      actor.email === 'hr@edgewforce.com'
    );

    const employees = await db.find('employees');
    const ranks = await db.find('ranks');
    const departments = await db.find('departments');
    const users = await db.find('users');

    return employees.map(e => {
      const rank = ranks.find(r => r.code === e.rank_code);
      const department = departments.find(d => Number(d.id) === Number(e.department_id)) || { name: e.department };
      const user = users.find(u => Number(u.id) === Number(e.user_id));

      const sanitizedEmp = { ...e };
      if (!isHrOrCeo) {
        delete sanitizedEmp.base_salary;
        delete sanitizedEmp.housing_allowance;
        delete sanitizedEmp.transport_allowance;
        delete sanitizedEmp.other_allowance;
      }

      return {
        ...sanitizedEmp,
        rank,
        department_info: department,
        user_status: user?.status || 'active',
        email: user?.email || ''
      };
    });
  },

  /**
   * Updates an employee profile and rank.
   */
  async updateEmployee(employeeId, data, actor = null, req = null) {
    const employee = await db.findById('employees', employeeId);
    if (!employee) throw new Error('Employee not found');

    const updated = await db.update('employees', employee.id, {
      first_name: data.first_name || employee.first_name,
      last_name: data.last_name || employee.last_name,
      phone: data.phone || employee.phone,
      department: data.department || employee.department,
      position: data.position || employee.position,
      rank_code: data.rank_code || employee.rank_code,
      base_salary: data.base_salary ? Number(data.base_salary) : employee.base_salary,
      housing_allowance: data.housing_allowance ? Number(data.housing_allowance) : employee.housing_allowance,
      transport_allowance: data.transport_allowance ? Number(data.transport_allowance) : employee.transport_allowance,
      reporting_manager_id: data.reporting_manager_id ? Number(data.reporting_manager_id) : employee.reporting_manager_id
    });

    await recordAudit(actor, 'EMPLOYEE_UPDATED', 'employees', employee.id, { changes: data }, req);
    return updated;
  },

  /**
   * Reviews and approves a leave application, deducting days from the leave balance.
   */
  async approveLeave(requestId, actor = null, req = null) {
    const request = await db.findById('leave_requests', requestId);
    if (!request) throw new Error('Leave request not found');

    const year = new Date(request.start_date).getFullYear();
    const balance = await db.findOne('leave_balances', { employee_id: Number(request.employee_id), year });
    const balanceKey = request.leave_type.toLowerCase();

    if (balance && balance[balanceKey] !== undefined) {
      const newBal = Math.max(0, balance[balanceKey] - request.days);
      await db.update('leave_balances', balance.id, { [balanceKey]: newBal });
    }

    const updated = await db.update('leave_requests', request.id, {
      status: 'approved',
      reviewed_by: actor?.employee?.id || actor?.id,
      reviewed_at: new Date().toISOString()
    });

    // Notify employee
    await db.insert('notifications', {
      employee_id: request.employee_id,
      type: 'Leave',
      title: 'Leave Approved',
      body: `Your ${request.leave_type} leave for ${request.days} day(s) starting ${request.start_date} has been approved.`
    });

    await recordAudit(actor, 'LEAVE_APPROVED', 'leave_requests', request.id, { days: request.days }, req);
    return updated;
  },

  /**
   * Rejects a leave application with notes.
   */
  async rejectLeave(requestId, reason = 'Operational requirements', actor = null, req = null) {
    const request = await db.findById('leave_requests', requestId);
    if (!request) throw new Error('Leave request not found');

    const updated = await db.update('leave_requests', request.id, {
      status: 'rejected',
      reviewed_by: actor?.employee?.id || actor?.id,
      reviewed_at: new Date().toISOString(),
      review_notes: reason
    });

    // Notify employee
    await db.insert('notifications', {
      employee_id: request.employee_id,
      type: 'Leave',
      title: 'Leave Request Update',
      body: `Your ${request.leave_type} leave request was not approved: ${reason}`
    });

    await recordAudit(actor, 'LEAVE_REJECTED', 'leave_requests', request.id, { reason }, req);
    return updated;
  },

  /**
   * Assigns a task enforcing hierarchy validation (superiors assign down, never upward).
   */
  async assignTask(taskData, assignerUser, req = null) {
    const { title, description, assigned_to, priority, due_date, department } = taskData;

    if (!title || !assigned_to) {
      throw new Error('Task title and assignee are required.');
    }

    const targetEmployee = await db.findById('employees', assigned_to);
    if (!targetEmployee) throw new Error('Selected employee does not exist.');

    // Enforce organizational authority hierarchy
    const ranks = await db.find('ranks');
    const assignerRank = ranks.find(r => r.code === assignerUser.rank?.code) || { level: 8 };
    const targetRank = ranks.find(r => r.code === targetEmployee.rank_code) || { level: 8 };

    const isAuthorized = validateHierarchyAssignment(assignerRank.level, targetRank.level);
    if (!isAuthorized && assignerUser.role_code !== 'CEO') {
      throw new Error(`Organizational hierarchy violation: Level ${assignerRank.level} cannot assign tasks upward to Level ${targetRank.level}.`);
    }

    const task = await db.insert('tasks', {
      title,
      description: description || '',
      assigned_to: Number(assigned_to),
      assigned_by: Number(assignerUser.id),
      department: department || targetEmployee.department,
      priority: priority || 'Normal',
      due_date: due_date || null,
      progress: 0,
      status: 'Pending'
    });

    // Notify assignee
    await db.insert('notifications', {
      employee_id: targetEmployee.id,
      type: 'Tasks',
      title: 'New Task Assigned',
      body: `You have been assigned: "${title}" by ${assignerUser.full_name}. Priority: ${priority || 'Normal'}.`
    });

    await recordAudit(assignerUser, 'TASK_ASSIGNED', 'tasks', task.id, { assigned_to, title }, req);
    return task;
  },

  /**
   * Resolves or acknowledges SOS emergency alerts.
   */
  async acknowledgeSOS(sosId, actor = null, req = null) {
    const updated = await db.update('sos', sosId, {
      status: 'acknowledged',
      acknowledged_by: Number(actor?.id || 1),
      acknowledged_at: new Date().toISOString()
    });
    await recordAudit(actor, 'SOS_ACKNOWLEDGED', 'sos', sosId, {}, req);
    return updated;
  },

  async resolveSOS(sosId, resolutionNotes = '', actor = null, req = null) {
    const updated = await db.update('sos', sosId, {
      status: 'resolved',
      resolved_by: Number(actor?.id || 1),
      resolved_at: new Date().toISOString(),
      resolution_notes: resolutionNotes
    });
    await recordAudit(actor, 'SOS_RESOLVED', 'sos', sosId, { resolutionNotes }, req);
    return updated;
  },

  /**
   * Retrieves and manages organizational ranks.
   */
  async getRanks() {
    return await db.find('ranks', {}, { order: { column: 'level', ascending: true } });
  },

  async createRank(data, actor = null, req = null) {
    const { code, name, level, description } = data;
    const existing = await db.findOne('ranks', { code });
    if (existing) throw new Error(`Rank with code ${code} already exists.`);

    const rank = await db.insert('ranks', {
      code,
      name,
      level: Number(level),
      description: description || '',
      active: true
    });
    await recordAudit(actor, 'RANK_CREATED', 'ranks', rank.id, { code, level }, req);
    return rank;
  },

  async updateRank(id, data, actor = null, req = null) {
    const updated = await db.update('ranks', id, data);
    await recordAudit(actor, 'RANK_UPDATED', 'ranks', id, data, req);
    return updated;
  },

  /**
   * Builds the interactive organization tree from CEO down to operational staff.
   */
  async getOrganizationTree() {
    const employees = await db.find('employees');
    const ranks = await db.find('ranks');
    const departments = await db.find('departments');
    const users = await db.find('users');

    const fullStaff = employees.map(e => {
      const rank = ranks.find(r => r.code === e.rank_code) || { name: 'Staff', level: 8, code: e.rank_code || 'STAFF' };
      const user = users.find(u => Number(u.id) === Number(e.user_id));
      const manager = employees.find(m => Number(m.id) === Number(e.reporting_manager_id));
      const directReports = employees.filter(sub => Number(sub.reporting_manager_id) === Number(e.id));
      return {
        ...e,
        rank,
        email: user?.email || '',
        manager_name: manager ? `${manager.first_name} ${manager.last_name}` : null,
        manager_position: manager?.position || null,
        direct_reports_count: directReports.length,
        direct_report_ids: directReports.map(d => d.id)
      };
    });

    fullStaff.sort((a, b) => (a.rank?.level || 8) - (b.rank?.level || 8));

    // Structure hierarchy by rank level and role
    const ceo = fullStaff.find(e => e.rank_code === 'CEO' || e.rank?.level === 1) || fullStaff[0];
    const executives = fullStaff.filter(e => e.id !== ceo?.id && (e.rank?.level <= 5 || ['CTO', 'HR', 'ACCOUNTANT', 'SENIOR_ACCOUNTANT', 'EXECUTIVE_DIRECTOR'].includes(e.rank_code)));
    const managers = fullStaff.filter(e => e.rank_code === 'MANAGER' || e.rank?.level === 6);
    const supervisors = fullStaff.filter(e => e.rank_code === 'SUPERVISOR' || e.rank?.level === 7);
    const operationalStaff = fullStaff.filter(e => (e.rank?.level >= 8 || e.rank_code === 'STAFF' || !e.rank_code) && e.id !== ceo?.id && !executives.includes(e) && !managers.includes(e) && !supervisors.includes(e));

    // Departmental groupings
    const departmentMap = {};
    for (const emp of fullStaff) {
      const deptName = emp.department || 'Commercial Operations';
      if (!departmentMap[deptName]) {
        departmentMap[deptName] = [];
      }
      departmentMap[deptName].push(emp);
    }

    return {
      ceo,
      executives,
      managers,
      supervisors,
      operationalStaff,
      all: fullStaff,
      departments: departments.length > 0 ? departments : Object.keys(departmentMap).map((name, i) => ({ id: i + 1, name })),
      department_groups: departmentMap,
      ranks
    };
  },

  /**
   * Reassigns an organization node / staff member to a new manager, department, or rank level.
   */
  async reassignOrganizationNode(employeeId, data, actor = null, req = null) {
    const employee = await db.findById('employees', employeeId);
    if (!employee) throw new Error('Organization node / Employee not found');

    const updateFields = {};
    if (data.reporting_manager_id !== undefined) {
      updateFields.reporting_manager_id = data.reporting_manager_id ? Number(data.reporting_manager_id) : null;
    }
    if (data.department) {
      updateFields.department = data.department;
    }
    if (data.position) {
      updateFields.position = data.position;
    }
    if (data.rank_code) {
      updateFields.rank_code = data.rank_code;
    }
    if (data.territory) {
      updateFields.territory = data.territory;
    }
    if (data.base_salary) {
      updateFields.base_salary = Number(data.base_salary);
    }

    const updated = await db.update('employees', employee.id, updateFields);

    await recordAudit(actor, 'ORG_STRUCTURE_REASSIGNED', 'employees', employee.id, { changes: updateFields }, req);
    return updated;
  },

  /**
   * Deactivates / removes an employee from the active organization chart.
   */
  async deleteOrganizationNode(employeeId, actor = null, req = null) {
    const employee = await db.findById('employees', employeeId);
    if (!employee) throw new Error('Employee not found');

    // Check if employee has direct subordinates; if so, reassign their manager to null or superior
    const subordinates = await db.find('employees', { reporting_manager_id: Number(employeeId) });
    for (const sub of subordinates) {
      await db.update('employees', sub.id, { reporting_manager_id: employee.reporting_manager_id || null });
    }

    await db.update('employees', employee.id, { status: 'inactive' });
    if (employee.user_id) {
      await db.update('users', employee.user_id, { status: 'inactive' });
    }

    await recordAudit(actor, 'ORG_NODE_DEACTIVATED', 'employees', employee.id, {}, req);
    return { success: true, message: `Employee ${employee.first_name} ${employee.last_name} removed from active organization structure.` };
  },


  /**
   * Onboard and register new staff member with user account and employee record.
   */
  async registerStaff(staffData, actor = null, req = null) {
    const {
      first_name,
      last_name,
      email,
      phone,
      department_id,
      department,
      position,
      territory,
      rank_code = 'STAFF',
      role_code,
      base_salary = 250000,
      housing_allowance = 100000,
      transport_allowance = 50000,
      other_allowance = 20000,
      address = '15 Atiba Osborne, Mende, Maryland, Lagos',
      date_of_birth
    } = staffData;

    if (!first_name || !last_name) {
      throw new Error('First name and last name are required to register staff.');
    }

    if (!email && !phone) {
      throw new Error('Please provide an email address or phone number.');
    }

    let normalizedEmail = null;
    if (email && email.trim()) {
      normalizedEmail = normalizeEmail(email);
      const existingUser = await db.findOne('users', { email: normalizedEmail });
      if (existingUser) {
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

    // Role mapping
    const finalRole = role_code || (
      rank_code === 'CEO' ? 'CEO' :
      rank_code === 'CTO' || rank_code === 'IT_ADMIN' ? 'IT_ADMIN' :
      rank_code === 'HR' ? 'HR' :
      rank_code === 'ACCOUNTANT' || rank_code === 'SENIOR_ACCOUNTANT' ? 'ACCOUNTANT' :
      department?.toLowerCase().includes('sales') ? 'SALES_AGENT' :
      department?.toLowerCase().includes('field') ? 'FIELD_AGENT' : 'EMPLOYEE'
    );

    const passwordToUse = (staffData.password && staffData.password.trim().length >= 6)
      ? staffData.password.trim()
      : 'ChangeMe123!';
    const passwordHash = bcrypt.hashSync(passwordToUse, 10);

    const user = await db.insert('users', {
      full_name: `${first_name} ${last_name}`,
      email: normalizedEmail,
      phone: normalizedPhone,
      password_hash: passwordHash,
      role_code: finalRole,
      status: 'active'
    });

    const allEmps = await db.find('employees');
    const nextNum = allEmps.length + 1001;
    const employee_code = `EMP-${nextNum}`;

    const employee = await db.insert('employees', {
      company_id: Number(staffData.company_id || actor?.company_id || req?.user?.company_id || 1),
      user_id: user.id,
      employee_code,
      first_name,
      last_name,
      email: normalizedEmail,
      phone: normalizedPhone,
      department_id: Number(department_id || 1),
      department: department || 'Commercial Sales',
      position: position || 'Operations Officer',
      territory: territory || 'Headquarters',
      state: staffData.state || 'Lagos',
      lga: staffData.lga || '',
      city: staffData.city || '',
      rank_code,
      base_salary: Number(base_salary || 0),
      housing_allowance: Number(housing_allowance || 0),
      transport_allowance: Number(transport_allowance || 0),
      other_allowance: Number(other_allowance || 0),
      date_of_birth: date_of_birth || '1995-01-01',
      address,
      status: 'active'
    });

    // Also initialize leave balances
    await db.insert('leave_balances', {
      employee_id: employee.id,
      year: 2026,
      annual: 20,
      sick: 12,
      casual: 5
    });

    // Assign initial work location if provided
    let locationAssignment = null;
    const locIdToAssign = staffData.assigned_location_id || staffData.work_location_id || staffData.location_id;
    if (locIdToAssign) {
      try {
        locationAssignment = await locationService.assignEmployeeLocation({
          company_id: employee.company_id,
          employee_id: employee.id,
          location_id: Number(locIdToAssign),
          assignment_type: staffData.assignment_type || 'primary',
          is_primary: true,
          reason: 'Initial assignment upon staff registration'
        }, actor, req);
      } catch (assignErr) {
        console.warn('Initial location assignment error during registration:', assignErr.message);
      }
    }

    await recordAudit(actor, 'STAFF_REGISTERED', 'employees', employee.id, {
      email,
      employee_code,
      finalRole,
      assigned_location: locationAssignment?.location?.name || 'Unassigned'
    }, req);

    return {
      user,
      employee,
      location_assignment: locationAssignment,
      temporary_password: 'ChangeMe123!'
    };
  },


  /**
   * Retrieves all corporate announcements.
   */
  async getAnnouncements() {
    const list = await db.find('announcements', {}, { order: { column: 'created_at', ascending: false } });
    return list || [];
  },

  /**
   * Creates a corporate announcement.
   */
  async createAnnouncement(data, actor = null, req = null) {
    const { title, message, category = 'General', priority = 'NORMAL', target_audience = 'ALL', pinned = false } = data;
    if (!title || !message) {
      throw new Error('Announcement title and message are required.');
    }

    const item = await db.insert('announcements', {
      company_id: Number(actor?.company_id || 1),
      title,
      message,
      category,
      priority,
      target_audience,
      author_name: actor?.full_name || 'HR Command Center',
      pinned: Boolean(pinned),
      created_at: new Date().toISOString()
    });

    await recordAudit(actor, 'ANNOUNCEMENT_CREATED', 'announcements', item.id, { title, category }, req);
    return item;
  },

  /**
   * Updates an existing announcement.
   */
  async updateAnnouncement(id, data, actor = null, req = null) {
    const existing = await db.findById('announcements', id);
    if (!existing) throw new Error('Announcement not found.');

    const updated = await db.update('announcements', id, {
      title: data.title || existing.title,
      message: data.message || existing.message,
      category: data.category || existing.category,
      priority: data.priority || existing.priority,
      target_audience: data.target_audience || existing.target_audience,
      pinned: data.pinned !== undefined ? Boolean(data.pinned) : existing.pinned
    });

    await recordAudit(actor, 'ANNOUNCEMENT_UPDATED', 'announcements', id, { title: updated.title }, req);
    return updated;
  },

  /**
   * Deletes an announcement.
   */
  async deleteAnnouncement(id, actor = null, req = null) {
    const existing = await db.findById('announcements', id);
    if (!existing) throw new Error('Announcement not found.');

    await db.delete('announcements', id);
    await recordAudit(actor, 'ANNOUNCEMENT_DELETED', 'announcements', id, { title: existing.title }, req);
    return { success: true, message: 'Announcement deleted.' };
  },

  /**
   * Retrieves staff birthdays, work anniversaries and celebrations.
   */
  async getStaffBirthdays() {
    const employees = await db.find('employees', { status: 'active' });
    const now = new Date();
    const currentMonth = now.getMonth() + 1; // 1-12
    const currentDay = now.getDate();

    const staffList = employees.map(emp => {
      let dob = emp.date_of_birth ? new Date(emp.date_of_birth) : null;
      let birthdayThisYear = null;
      let daysUntilBirthday = 999;
      let isThisMonth = false;
      let isToday = false;
      let age = null;

      if (dob && !isNaN(dob.getTime())) {
        const birthMonth = dob.getMonth() + 1;
        const birthDay = dob.getDate();
        isThisMonth = birthMonth === currentMonth;
        isToday = birthMonth === currentMonth && birthDay === currentDay;

        birthdayThisYear = new Date(now.getFullYear(), dob.getMonth(), dob.getDate());
        if (birthdayThisYear < new Date(now.getFullYear(), now.getMonth(), now.getDate())) {
          birthdayThisYear.setFullYear(now.getFullYear() + 1);
        }
        const diffMs = birthdayThisYear.getTime() - now.getTime();
        daysUntilBirthday = Math.ceil(diffMs / (1000 * 60 * 60 * 24));
        age = now.getFullYear() - dob.getFullYear();
      }

      return {
        id: emp.id,
        employee_code: emp.employee_code,
        first_name: emp.first_name,
        last_name: emp.last_name,
        full_name: `${emp.first_name} ${emp.last_name}`,
        department: emp.department,
        position: emp.position,
        rank_code: emp.rank_code,
        phone: emp.phone,
        date_of_birth: emp.date_of_birth || null,
        hire_date: emp.hire_date || '2023-01-15',
        daysUntilBirthday,
        isThisMonth,
        isToday,
        age
      };
    });

    staffList.sort((a, b) => a.daysUntilBirthday - b.daysUntilBirthday);

    const thisMonthBirthdays = staffList.filter(s => s.isThisMonth);
    const upcoming7Days = staffList.filter(s => s.daysUntilBirthday >= 0 && s.daysUntilBirthday <= 7);

    return {
      all: staffList,
      thisMonth: thisMonthBirthdays,
      upcoming: upcoming7Days
    };
  },

  /**
   * Updates an employee's birthday or milestone record.
   */
  async updateStaffBirthday(employeeId, data, actor = null, req = null) {
    const employee = await db.findById('employees', employeeId);
    if (!employee) throw new Error('Employee not found.');

    const updated = await db.update('employees', employee.id, {
      date_of_birth: data.date_of_birth || employee.date_of_birth,
      hire_date: data.hire_date || employee.hire_date
    });

    await recordAudit(actor, 'STAFF_BIRTHDAY_UPDATED', 'employees', employee.id, { date_of_birth: data.date_of_birth }, req);
    return updated;
  },

  /**
   * Broadcasts a birthday celebration notice to the entire company staff portal.
   */
  async broadcastBirthday(employeeId, customWish = '', actor = null, req = null) {
    const employee = await db.findById('employees', employeeId);
    if (!employee) throw new Error('Employee not found.');

    const wishText = customWish || `Happy Birthday to our fantastic team member, ${employee.first_name} ${employee.last_name} (${employee.position}, ${employee.department})! Wishing you another year of outstanding success and prosperity with EdgeWForce! 🎉🎂`;

    const announcement = await db.insert('announcements', {
      company_id: Number(actor?.company_id || 1),
      title: `🎂 Happy Birthday ${employee.first_name} ${employee.last_name}!`,
      message: wishText,
      category: 'Celebration',
      priority: 'HIGH',
      target_audience: 'ALL',
      author_name: actor?.full_name || 'HR People Team',
      pinned: true,
      created_at: new Date().toISOString()
    });

    // Also send an instant congratulatory notification directly to employee
    await db.insert('notifications', {
      employee_id: employee.id,
      type: 'General',
      title: '🎉 Happy Birthday from the Entire Team!',
      body: 'Management and the entire workforce celebrate you today! Thank you for your dedication and excellence.'
    });

    await recordAudit(actor, 'BIRTHDAY_BROADCAST_PUBLISHED', 'announcements', announcement.id, { employee_id: employee.id }, req);
    return announcement;
  }
};

