import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { db } from '../config/database.js';
import { staffImportService } from '../services/staffImportService.js';
import { hrService } from '../services/hrService.js';
import { authService } from '../services/authService.js';

describe('Authoritative Staff Provisioning & Security Tests', () => {
  it('1. Verifies all 58 authoritative staff records are imported with leading zeros in Staff ID preserved', async () => {
    const importResult = await staffImportService.importAuthoritativeStaff();
    assert.strictEqual(importResult.total_records, 58, 'Total imported records must equal exactly 58');

    const employees = await db.find('employees');
    assert(employees.length >= 58, `Employees count in database must be at least 58, found: ${employees.length}`);

    // Verify leading zeroes preservation in text staff IDs
    const emp019 = employees.find(e => e.staff_id === '019');
    assert(emp019, 'Staff ID 019 must exist and be stored as string with leading zero preserved');
    assert.strictEqual(emp019.staff_id, '019');

    const emp003 = employees.find(e => e.staff_id === '003');
    assert(emp003, 'Staff ID 003 must exist with leading zero preserved');
    assert.strictEqual(emp003.staff_id, '003');
  });

  it('2. Verifies import idempotency - running import second time produces 0 new accounts', async () => {
    const secondImport = await staffImportService.importAuthoritativeStaff();
    assert.strictEqual(secondImport.accounts_created, 0, 'Second import must create 0 new accounts');
    assert.strictEqual(secondImport.employees_created, 0, 'Second import must create 0 new employees');
    assert.strictEqual(secondImport.duplicates_detected, 58, 'Second import must detect all 58 records as duplicates and update them');
  });

  it('3. Verifies Multi-Identifier login using email OR Nigerian phone number', async () => {
    const employees = await db.find('employees');
    const sampleEmp = employees.find(e => e.staff_id && e.phone && (e.work_email || e.personal_email) && e.user_id > 8);
    assert(sampleEmp, 'Sample employee with phone and email must exist');

    const email = sampleEmp.work_email || sampleEmp.personal_email;
    const phone = sampleEmp.phone;

    // Login via email
    const loginByEmail = await authService.login(email, 'ChangeMe123!');
    assert(loginByEmail.token, 'Must return JWT token on email login');
    assert.strictEqual(loginByEmail.user.requires_password_change, true, 'Default password must require change on first login');

    // Login via phone
    const loginByPhone = await authService.login(phone, 'ChangeMe123!');
    assert(loginByPhone.token, 'Must return JWT token on phone login');
    assert.strictEqual(loginByPhone.user.id, loginByEmail.user.id, 'Email and phone logins must resolve to the same user');
  });

  it('4. Verifies strict server-side redaction of sensitive HR/banking data for non-HR callers', async () => {
    const nonHrActor = {
      id: 999,
      email: 'agent@edgewforce.com',
      role_code: 'FIELD_AGENT',
      rank: { code: 'STAFF' }
    };

    const publicDirectory = await hrService.getEmployees(nonHrActor);
    assert(publicDirectory.length > 0, 'Directory must return records');

    for (const record of publicDirectory) {
      assert.strictEqual(record.bank_name, undefined, 'bank_name must be stripped for non-HR callers');
      assert.strictEqual(record.account_number, undefined, 'account_number must be stripped for non-HR callers');
      assert.strictEqual(record.date_of_birth, undefined, 'date_of_birth must be stripped for non-HR callers');
      assert.strictEqual(record.base_salary, undefined, 'base_salary must be stripped for non-HR callers');
      assert.strictEqual(record.emergency_contact_phone, undefined, 'emergency_contact_phone must be stripped for non-HR callers');
      assert.strictEqual(record.home_address, undefined, 'home_address must be stripped for non-HR callers');
    }
  });

  it('5. Verifies HR administrator can retrieve full unredacted staff profile including banking and review flags', async () => {
    const hrActor = {
      id: 2,
      email: 'hr@edgewforce.com',
      role_code: 'HR_MANAGER',
      rank: { code: 'HR' }
    };

    const hrDirectory = await hrService.getEmployees(hrActor);
    const sampleEmp = hrDirectory.find(e => e.account_number);
    assert(sampleEmp, 'Sample employee with bank account must exist in HR directory');
    assert(sampleEmp.account_number, 'HR must see account_number');
    assert(sampleEmp.bank_name, 'HR must see bank_name');
  });

  it('6. HR deactivation preserves staff history and protects system accounts', async () => {
    const employee = (await db.find('employees')).find(record => Number(record.user_id) > 9);
    assert(employee, 'An imported staff account should be available for deactivation testing');

    const result = await hrService.deleteEmployee(employee.id, {
      id: 3,
      email: 'hr@edgewforce.com',
      role_code: 'HR_MANAGER'
    });

    assert.equal(result.employee.status, 'inactive');
    assert.equal((await db.findById('employees', employee.id)).status, 'inactive');
    assert.equal((await db.findById('users', employee.user_id)).status, 'inactive');
    await assert.rejects(
      () => hrService.deleteEmployee(1, { id: 3, email: 'hr@edgewforce.com', role_code: 'HR_MANAGER' }),
      /Protected system staff accounts cannot be deleted/i
    );
  });
});
