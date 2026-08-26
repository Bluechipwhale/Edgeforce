-- ==============================================================================
-- EDGEWFORCE - ENTERPRISE SEED DATA (seed.sql)
-- Realistic Nigerian Commercial & Workforce Operations Seed Data
-- ==============================================================================

-- 1. DEPARTMENTS
INSERT INTO departments (name, code, description) VALUES
('Commercial Sales', 'SALES', 'Retail distribution, key accounts and merchant network'),
('Field Operations', 'FIELD', 'Store audits, route execution, merchandising and GPS verification'),
('Human Resources', 'HR', 'People operations, talent, leave and workforce welfare'),
('Finance & Accounts', 'FINANCE', 'Treasury, audit, collections, settlements and payroll'),
('Technology & Product', 'TECH', 'Platform infrastructure, cybersecurity and telemetry'),
('Executive Management', 'EXEC', 'Corporate leadership and strategic governance')
ON CONFLICT (code) DO NOTHING;

-- 2. RANKS
INSERT INTO ranks (code, name, level, description) VALUES
('CEO', 'Chief Executive Officer', 1, 'Top executive authority and corporate governance'),
('CTO', 'Chief Technology Officer', 2, 'Technology, cybersecurity and telemetry oversight'),
('HR', 'Head of Human Resources', 3, 'Workforce operations and people management'),
('SENIOR_ACCOUNTANT', 'Senior Accountant', 4, 'Financial approvals, payroll and cash reconciliation'),
('ACCOUNTANT', 'Accountant', 5, 'Collections ledger, invoice audits and reconciliations'),
('MANAGER', 'Regional Manager', 6, 'Territory operations and commercial targets'),
('SUPERVISOR', 'Field Operations Supervisor', 7, 'Route planning, shift oversight and store audits'),
('STAFF', 'Operations Staff', 8, 'Commercial sales agents, field officers and staff')
ON CONFLICT (code) DO NOTHING;

-- 3. PERMISSIONS
INSERT INTO permissions (code, name, category, description) VALUES
('view_dashboard', 'View Dashboard', 'General', 'Access to main workspace dashboard'),
('view_employees', 'View Employees', 'HR', 'View employee directory and organizational chart'),
('create_employee', 'Create Employee', 'HR', 'Add new employees to the workforce directory'),
('edit_employee', 'Edit Employee', 'HR', 'Modify employee profile and assignments'),
('delete_employee', 'Delete Employee', 'HR', 'Deactivate employee profile'),
('assign_tasks', 'Assign Tasks', 'Tasks', 'Assign tasks to subordinates in hierarchy'),
('approve_leave', 'Approve Leave', 'HR', 'Review and approve/reject leave applications'),
('view_payroll', 'View Payroll', 'Finance', 'View payroll summaries and compensation'),
('manage_payroll', 'Manage Payroll', 'Finance', 'Generate and publish monthly payslips'),
('view_attendance', 'View Attendance', 'HR', 'View team attendance and timesheets'),
('manage_attendance', 'Manage Attendance', 'HR', 'Correct or verify attendance anomalies'),
('view_idle_reports', 'View Idle Reports', 'HR', 'Review 10-minute inactivity reports and explanations'),
('manage_ranks', 'Manage Ranks', 'HR', 'Configure organizational ranks and levels'),
('view_sales', 'View Sales', 'Sales', 'Access commercial sales metrics and POS orders'),
('create_orders', 'Create Orders', 'Sales', 'Book POS sales orders with stock deduction'),
('record_collections', 'Record Collections', 'Sales', 'Post debt recovery collections into ledger'),
('view_customers', 'View Customers', 'Sales', 'Access customer register and credit balances'),
('create_customers', 'Create Customers', 'Sales', 'Register new outlets with GPS tagging'),
('view_field_operations', 'View Field Operations', 'Field', 'Access route manifest and live map'),
('manage_routes', 'Manage Routes', 'Field', 'Assign daily customer stops to field agents'),
('view_sos', 'View SOS Alerts', 'Emergency', 'Receive emergency panic beacon broadcasts'),
('resolve_sos', 'Resolve SOS Alerts', 'Emergency', 'Acknowledge and resolve SOS incidents'),
('manage_products', 'Manage Products', 'Inventory', 'Edit product SKUs, prices and stock counts'),
('manage_inventory', 'Manage Inventory', 'Inventory', 'Perform inventory adjustments and restocks'),
('view_competitors', 'View Competitor Intel', 'Marketing', 'Analyze competitor pricing and shelf share'),
('view_reports', 'View Management Reports', 'Executive', 'Access executive analytics and territory summaries'),
('manage_settings', 'Manage System Settings', 'Admin', 'Configure system parameters and telemetry thresholds')
ON CONFLICT (code) DO NOTHING;

-- 4. USERS & PASSWORDS
-- Default bcrypt hash for 'ChangeMe123!' ($2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v)
INSERT INTO users (id, full_name, email, password_hash, phone, role_code, status) VALUES
(1, 'IT Super Admin', 'it@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348000000001', 'SUPER_ADMIN', 'active'),
(2, 'Chief Executive Officer', 'ceo@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348000000002', 'CEO', 'active'),
(3, 'Head of Human Resources', 'hr@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348000000003', 'HR_MANAGER', 'active'),
(4, 'Commercial Sales Lead', 'sales@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348031234567', 'SALES_AGENT', 'active'),
(5, 'Field Operations Lead', 'field@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348029876543', 'FIELD_AGENT', 'active'),
(6, 'Finance & Accounting Lead', 'accountant@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348000000006', 'ACCOUNTANT', 'active'),
(7, 'Field Operations Supervisor', 'supervisor@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348187654321', 'SUPERVISOR', 'active'),
(8, 'Corporate Operations Staff', 'staff@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348145550192', 'STAFF_MEMBER', 'active'),
(9, 'Platform Super Administrator', 'admin@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348000000000', 'SUPER_ADMIN', 'active')
ON CONFLICT (email) DO NOTHING;

-- 5. EMPLOYEES
INSERT INTO employees (id, user_id, employee_code, first_name, last_name, phone, department, position, territory, rank_code, hire_date, base_salary, housing_allowance, transport_allowance, other_allowance) VALUES
(1, 1, 'EMP-1001', 'IT Admin', 'Service', '+2348000000001', 'Technology & IT', 'IT Super Admin / System Engineer', 'Headquarters', 'IT_ADMIN', '2024-01-01', 1800000, 700000, 350000, 150000),
(2, 2, 'EMP-1002', 'Executive', 'Management', '+2348000000002', 'Executive Management', 'Chief Executive Officer', 'National', 'CEO', '2024-01-01', 2500000, 1000000, 500000, 250000),
(3, 3, 'EMP-1003', 'HR', 'Manager', '+2348000000003', 'Human Resources', 'Head of Human Resources', 'Headquarters', 'HR', '2024-01-01', 1200000, 500000, 250000, 100000),
(4, 4, 'EMP-1004', 'Thompson', 'Babatunde', '+2348031234567', 'Commercial Sales', 'Senior Commercial Sales Agent', 'Lagos Mainland', 'STAFF', '2024-01-15', 380000, 160000, 80000, 30000),
(5, 5, 'EMP-1005', 'Godfrey', 'Okorie', '+2348029876543', 'Field Operations', 'Field Operations Lead Agent', 'Lagos Island & Lekki', 'STAFF', '2024-02-01', 350000, 150000, 75000, 25000),
(6, 6, 'EMP-1006', 'Finance', 'Officer', '+2348000000006', 'Finance & Accounts', 'Head of Accounting & Payroll', 'Headquarters', 'ACCOUNTANT', '2024-03-01', 1100000, 450000, 220000, 90000),
(7, 7, 'EMP-1007', 'Amina', 'Bello', '+2348187654321', 'Field Operations', 'Field Operations Supervisor', 'Lagos Island', 'SUPERVISOR', '2024-03-15', 750000, 300000, 150000, 60000),
(8, 8, 'EMP-1008', 'Gloria', 'Iwuh', '+2348145550192', 'Corporate Operations', 'Workforce Operations Analyst', 'Headquarters', 'STAFF', '2024-04-01', 420000, 180000, 90000, 35000),
(9, 9, 'EMP-1009', 'Platform', 'Administrator', '+2348000000000', 'Executive Governance', 'Super Administrator', 'National', 'CEO', '2024-01-01', 1800000, 700000, 350000, 150000)
ON CONFLICT (employee_code) DO NOTHING;

-- 6. HOLIDAYS (Nigerian Public Holidays 2026)
INSERT INTO holidays (name, date, description, year) VALUES
('New Year''s Day', '2026-01-01', 'Public holiday commemorating the start of the year', 2026),
('Workers'' Day', '2026-05-01', 'International Labor Day celebration', 2026),
('Democracy Day', '2026-06-12', 'Commemoration of Nigeria''s democratic heritage', 2026),
('Independence Day', '2026-10-01', 'National Independence Day celebration', 2026),
('Christmas Day', '2026-12-25', 'Celebration of Christmas', 2026),
('Boxing Day', '2026-12-26', 'Boxing Day holiday', 2026)
ON CONFLICT (date) DO NOTHING;
