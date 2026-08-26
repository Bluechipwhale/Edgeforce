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
-- 4. USERS & PASSWORDS
-- Default bcrypt hash for 'ChangeMe123!' ($2a$10$Xq7u61qWz2fX/jG4N.zEJuqTskf.s8J4LkV7Qh1eU8uG7S5hTf17a)
INSERT INTO users (full_name, email, password_hash, phone, role_code, status) VALUES
('Thompson Babatunde', 'sales@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348031234567', 'SALES_AGENT', 'active'),
('Godfrey Okorie', 'field@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348029876543', 'FIELD_AGENT', 'active'),
('Gloria Iwuh', 'staff@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348145550192', 'EMPLOYEE', 'active'),
('Vivian Osigweh', 'ceo@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348099887766', 'CEO', 'active'),
('Olasode Olawale', 'it@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348077665544', 'IT_ADMIN', 'active'),
('Adedayo Ajayi', 'hr@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348055443322', 'HR', 'active'),
('Happiness Florence', 'accountant@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348033221100', 'ACCOUNTANT', 'active'),
('Chinedu Nwosu', 'manager@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348123456789', 'MANAGER', 'active'),
('Amina Bello', 'supervisor@edgewforce.com', '$2a$10$wE9UfUa8sM3Z.Yp2T5mH5uL6L1F9n2d8Y2W8Z9V4p1Q2r3S4t5u6v', '+2348187654321', 'SUPERVISOR', 'active')
ON CONFLICT (email) DO NOTHING;

-- 5. EMPLOYEES
INSERT INTO employees (user_id, employee_code, first_name, last_name, phone, department, position, territory, rank_code, hire_date, base_salary, housing_allowance, transport_allowance, other_allowance, date_of_birth, address) VALUES
(1, 'EMP-1001', 'Thompson', 'Babatunde', '+2348031234567', 'Commercial Sales', 'Senior Commercial Sales Agent', 'Lagos Mainland', 'STAFF', '2024-01-15', 380000, 160000, 80000, 30000, '1992-05-14', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(2, 'EMP-1002', 'Godfrey', 'Okorie', '+2348029876543', 'Field Operations', 'Field Operations Lead Agent', 'Lagos Island & Lekki', 'STAFF', '2024-02-01', 350000, 150000, 75000, 25000, '1994-09-22', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(3, 'EMP-1003', 'Gloria', 'Iwuh', '+2348145550192', 'Corporate Operations', 'Corporate Operations Analyst', 'Headquarters', 'STAFF', '2024-03-10', 420000, 180000, 90000, 35000, '1990-11-08', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(4, 'EMP-1004', 'Vivian', 'Osigweh', '+2348099887766', 'Executive Management', 'Chief Executive Officer', 'National', 'CEO', '2023-01-01', 2500000, 1000000, 500000, 250000, '1980-04-18', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(5, 'EMP-1005', 'Olasode', 'Olawale', '+2347037934201', 'Technology & IT', 'IT Super Admin / Portal Administrator', 'National', 'IT_ADMIN', '2023-03-15', 1800000, 700000, 350000, 150000, '1985-07-29', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(6, 'EMP-1006', 'Adedayo', 'Ajayi', '+2348055443322', 'Human Resources', 'Head of Human Resources', 'Headquarters', 'HR', '2023-05-01', 1200000, 500000, 250000, 100000, '1987-12-03', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(7, 'EMP-1007', 'Happiness', 'Florence', '+2348033221100', 'Finance & Accounts', 'Head of Accounting & Payroll', 'Headquarters', 'ACCOUNTANT', '2023-06-01', 1100000, 450000, 220000, 90000, '1989-03-12', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(8, 'EMP-1008', 'Chinedu', 'Nwosu', '+2348123456789', 'Commercial Sales', 'Lagos Territory Sales Manager', 'Lagos West & East', 'MANAGER', '2023-08-01', 950000, 400000, 200000, 80000, '1986-10-25', '15 Atiba Osborne, Mende, Maryland, Lagos'),
(9, 'EMP-1009', 'Amina', 'Bello', '+2348187654321', 'Field Operations', 'Field Operations Supervisor', 'Lagos Island', 'SUPERVISOR', '2023-09-15', 750000, 300000, 150000, 60000, '1991-08-14', '15 Atiba Osborne, Mende, Maryland, Lagos')
ON CONFLICT (employee_code) DO NOTHING;

-- 6. CUSTOMERS (Lagos & Key Commercial Outlets)
INSERT INTO customers (code, name, contact_person, phone, email, address, territory, latitude, longitude, balance, credit_limit, registered_by) VALUES
('CUST-101', 'Mega Plaza Supermarket', 'Alhaji Rasheed Bello', '+2348034567890', 'procurement@megaplaza.ng', '14B Idowu Martins St, Victoria Island, Lagos', 'Lagos Island', 6.4281, 3.4219, 185000.00, 1500000.00, 1),
('CUST-102', 'Prince Ebeano Supermarket Lekki', 'Mrs. Chika Okoli', '+2348023456789', 'orders@princeebeano.com', 'Plot 9, Block 4, Oniru Commercial Zone, Lekki, Lagos', 'Lekki Peninsula', 6.4382, 3.4475, 420000.00, 2000000.00, 1),
('CUST-103', 'Spar Nigeria Ikeja Mall', 'Mr. David Adeleke', '+2348098765432', 'ikeja.buying@spar.ng', 'Ikeja City Mall, Alausa, Ikeja, Lagos', 'Ikeja / Alausa', 6.6194, 3.3581, 95000.00, 3000000.00, 1),
('CUST-104', 'Goodies Supermarket Victoria Island', 'Tony Elumelu Branch Rep', '+2348055667788', 'contact@goodiesstores.com', '237B Kofo Abayomi Street, Victoria Island, Lagos', 'Lagos Island', 6.4253, 3.4158, 0.00, 1000000.00, 1),
('CUST-105', 'Hubmart Stores Ikeja GRA', 'Grace Folorunsho', '+2348011223344', 'ikeja@hubmart.com', '26 Isaac John St, GRA, Ikeja, Lagos', 'Ikeja GRA', 6.5894, 3.3592, 310000.00, 1500000.00, 1),
('CUST-106', 'Jendol Superstore Egbeda', 'Oluwaseun Bakare', '+2348077889900', 'egbeda@jendol.com', '124 Egbeda-Idimu Road, Lagos', 'Alimosho / Egbeda', 6.5982, 3.2845, 640000.00, 1200000.00, 1),
('CUST-107', 'Blenco Supermarket Sangotedo', 'Kenechukwu Obi', '+2348134567890', 'sangotedo@blenco.ng', 'KM 26 Lekki-Epe Expressway, Sangotedo, Lagos', 'Lekki-Epe Axis', 6.4678, 3.6120, 120000.00, 1800000.00, 1),
('CUST-108', 'De-Prince Supermarket Magodo', 'Bisi Akande', '+2348167890123', 'magodo@deprince.ng', 'Cmd Road, Beside Secretariat, Magodo, Lagos', 'Magodo / Shangisha', 6.6189, 3.3852, 0.00, 800000.00, 1)
ON CONFLICT (code) DO NOTHING;

-- 7. PRODUCTS (FMCG Packs, Beverages, Provisions in ₦)
INSERT INTO products (sku, name, category, unit, carton_pack_count, price, cost_price, stock_quantity, min_stock_alert, description) VALUES
('SKU-1001', 'Golden Penny Pure Vegetable Oil (1L x 12)', 'Cooking Essentials', 'carton', 12, 48500.00, 42000.00, 140, 20, 'Premium refined vegetable oil, pack of 12 bottles'),
('SKU-1002', 'Milo Energy Food Drink 500g (Tin x 24)', 'Beverages', 'carton', 24, 78000.00, 68000.00, 85, 15, 'Fortified nourishing chocolate malt beverage'),
('SKU-1003', 'Dangote Granulated Sugar 50kg', 'Commodities', 'bag', 1, 88000.00, 79000.00, 60, 10, 'Fine fortified white granulated sugar 50kg sack'),
('SKU-1004', 'Indomie Super Pack Onion Chicken (40 packs)', 'Noodles & Pasta', 'carton', 40, 18500.00, 15500.00, 250, 30, 'Super pack 120g x 40 packs instant noodles'),
('SKU-1005', 'Peak Full Cream Milk Powder 400g (x 24)', 'Dairy', 'carton', 24, 84000.00, 74000.00, 95, 15, 'Rich and creamy instant whole milk powder'),
('SKU-1006', 'Knorr Chicken Seasoning Cubes (50 x 24)', 'Seasonings', 'carton', 24, 34000.00, 29000.00, 180, 25, 'Rich aromatic chicken bullion cubes'),
('SKU-1007', 'Eva Premium Table Water 75cl (Pack of 12)', 'Beverages', 'pack', 12, 3200.00, 2500.00, 320, 40, 'Crisp purified natural spring water bottles'),
('SKU-1008', 'Dano Cool Cow Evaporated Milk (48 x 160g)', 'Dairy', 'carton', 48, 41000.00, 35500.00, 110, 20, 'Fortified condensed evaporated milk')
ON CONFLICT (sku) DO NOTHING;

-- 8. ORDERS & ORDER ITEMS
INSERT INTO orders (order_number, customer_id, sales_agent_id, status, subtotal, discount_amount, vat_amount, total_amount, payment_method, payment_status, order_date) VALUES
('ORD-202608-001', 1, 1, 'delivered', 175000.00, 5000.00, 12750.00, 182750.00, 'Bank Transfer', 'paid', CURRENT_DATE - INTERVAL '2 days'),
('ORD-202608-002', 2, 1, 'delivered', 420000.00, 10000.00, 30750.00, 440750.00, 'POS Terminal', 'paid', CURRENT_DATE - INTERVAL '1 day'),
('ORD-202608-003', 3, 1, 'confirmed', 246000.00, 0.00, 18450.00, 264450.00, 'Credit', 'unpaid', CURRENT_DATE),
('ORD-202608-004', 5, 1, 'pending', 312000.00, 6000.00, 22950.00, 328950.00, 'Bank Transfer', 'unpaid', CURRENT_DATE)
ON CONFLICT (order_number) DO NOTHING;

-- 9. COLLECTIONS
INSERT INTO collections (customer_id, agent_id, amount, payment_method, reference_number, notes, payment_date) VALUES
(1, 1, 150000.00, 'Bank Transfer', 'GTB-TRF-9823411', 'Partial settlement of outstanding invoice', NOW() - INTERVAL '1 day'),
(2, 1, 300000.00, 'POS Terminal', 'STANBIC-POS-77123', 'August bulk purchase settlement', NOW() - INTERVAL '3 days')
ON CONFLICT DO NOTHING;

-- 10. VISITS & ROUTE MANIFEST
INSERT INTO visits (agent_id, customer_id, status, planned_time, priority, check_in_lat, check_in_lng, is_geofence_verified, notes) VALUES
(2, 1, 'completed', NOW() - INTERVAL '4 hours', 'URGENT', 6.4281, 3.4219, true, 'Stock count completed. Recommended vegetable oil restock.'),
(2, 2, 'completed', NOW() - INTERVAL '2 hours', 'HIGH', 6.4382, 3.4475, true, 'Merchandising display verified on main aisle.'),
(2, 4, 'scheduled', NOW() + INTERVAL '1 hour', 'NORMAL', 6.4253, 3.4158, false, 'Scheduled audit of milk powder expiry dates.'),
(2, 5, 'scheduled', NOW() + INTERVAL '3 hours', 'HIGH', 6.5894, 3.3592, false, 'Competitive price check on pasta and seasoning.')
ON CONFLICT DO NOTHING;

-- 11. COMPETITOR INTEL
INSERT INTO competitor_intel (agent_id, customer_id, competitor_brand, product_name, observed_price, our_price, price_difference, shelf_share_percent, promo_details) VALUES
(1, 1, 'Devon Kings', 'Kings Vegetable Oil 1L x 12', 49500.00, 48500.00, 1000.00, 45, 'Devon Kings offering 1 free pack per 20 cartons ordered.'),
(1, 2, 'Bournvita', 'Bournvita Refill Pack 500g (x 24)', 76000.00, 78000.00, -2000.00, 55, 'Bournvita running back-to-school promotional discount of 5%.')
ON CONFLICT DO NOTHING;

-- 12. ATTENDANCE
INSERT INTO attendance (employee_id, date, clock_in_time, clock_out_time, clock_in_lat, clock_in_lng, status, working_hours) VALUES
(1, CURRENT_DATE, NOW() - INTERVAL '7 hours', NULL, 6.4281, 3.4219, 'Present', 7.0),
(2, CURRENT_DATE, NOW() - INTERVAL '6 hours', NULL, 6.4382, 3.4475, 'Present', 6.0),
(3, CURRENT_DATE, NOW() - INTERVAL '8 hours', NULL, 6.4500, 3.4000, 'Present', 8.0),
(1, CURRENT_DATE - INTERVAL '1 day', (CURRENT_DATE - INTERVAL '1 day') + TIME '08:15:00', (CURRENT_DATE - INTERVAL '1 day') + TIME '17:30:00', 6.4281, 3.4219, 'Present', 9.25),
(2, CURRENT_DATE - INTERVAL '1 day', (CURRENT_DATE - INTERVAL '1 day') + TIME '08:45:00', (CURRENT_DATE - INTERVAL '1 day') + TIME '17:00:00', 6.4382, 3.4475, 'Late', 8.25),
(3, CURRENT_DATE - INTERVAL '1 day', (CURRENT_DATE - INTERVAL '1 day') + TIME '07:55:00', (CURRENT_DATE - INTERVAL '1 day') + TIME '17:10:00', 6.4500, 3.4000, 'Present', 9.25)
ON CONFLICT (employee_id, date) DO NOTHING;

-- 13. LEAVE BALANCES & REQUESTS
INSERT INTO leave_balances (employee_id, year, annual, sick, casual) VALUES
(1, 2026, 18, 12, 5),
(2, 2026, 20, 10, 4),
(3, 2026, 15, 12, 5)
ON CONFLICT (employee_id, year) DO NOTHING;

INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, days, reason, status) VALUES
(1, 'Annual', CURRENT_DATE + INTERVAL '14 days', CURRENT_DATE + INTERVAL '18 days', 5, 'Annual family holiday and rest', 'pending'),
(3, 'Sick', CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE - INTERVAL '9 days', 2, 'Medical checkup and treatment for malaria', 'approved')
ON CONFLICT DO NOTHING;

-- 14. PAYSLIPS (August 2026)
INSERT INTO payslips (employee_id, pay_month, basic_salary, housing_allowance, transport_allowance, other_allowance, gross_pay, tax_paye, pension, other_deductions, total_deductions, net_pay, status) VALUES
(1, '2026-08-01', 380000.00, 160000.00, 80000.00, 30000.00, 650000.00, 95000.00, 49600.00, 0.00, 144600.00, 505400.00, 'published'),
(2, '2026-08-01', 350000.00, 150000.00, 75000.00, 25000.00, 600000.00, 86000.00, 46000.00, 0.00, 132000.00, 468000.00, 'published'),
(3, '2026-08-01', 420000.00, 180000.00, 90000.00, 35000.00, 725000.00, 108000.00, 55200.00, 0.00, 163200.00, 561800.00, 'published')
ON CONFLICT (employee_id, pay_month) DO NOTHING;

-- 15. OKRS
INSERT INTO okrs (employee_id, title, description, year, quarter, progress, status) VALUES
(1, 'Expand Lagos Mainland Retail Distribution Network', 'Onboard 40 new Tier-1 FMCG retail outlets and maintain 90% repeat purchase rate.', 2026, 'Q3', 75, 'On Track'),
(2, 'Field Store Audit Compliance & GPS Accuracy', 'Attain 98% 150m geofence compliance and 100% photo verification across route stops.', 2026, 'Q3', 90, 'On Track'),
(3, 'Workforce Operational Intelligence Automation', 'Deploy automated idle-tracking telemetry and reduce payroll processing cycle time to 4 hours.', 2026, 'Q3', 85, 'On Track')
ON CONFLICT DO NOTHING;

-- 16. TASKS
INSERT INTO tasks (title, description, assigned_to, assigned_by, department, priority, due_date, progress, status) VALUES
('Execute Prince Ebeano Lekki Q3 Stock Audit', 'Inspect shelf presence, out-of-stock SKUs, and collect signed verification slip.', 2, 6, 'Field Operations', 'Urgent', CURRENT_DATE + INTERVAL '1 day', 50, 'In Progress'),
('Reconcile Outstanding Debt with Mega Plaza', 'Meet finance head Alhaji Bello and collect pending balance of ₦185,000.', 1, 7, 'Commercial Sales', 'High', CURRENT_DATE + INTERVAL '2 days', 25, 'Pending'),
('Conduct Biometric Facial Verification Trial', 'Enroll 20 field and operations agents and log confidence scores.', 3, 5, 'Human Resources', 'Normal', CURRENT_DATE + INTERVAL '5 days', 60, 'In Progress')
ON CONFLICT DO NOTHING;

-- 17. ANNOUNCEMENTS
INSERT INTO announcements (title, body, audience, priority, start_date) VALUES
('Experiential Edge Q3 Commercial Incentive Scheme', 'Sales agents reaching 120% of their monthly target will receive an additional 2.5% super-bonus alongside standard 5% commission.', 'Everyone', 'High', CURRENT_DATE),
('Security Reminder: Strict 150m Geofence Verification', 'All field visits require on-site GPS verification within 150 meters before visit completion is unlocked.', 'Field Operations', 'Urgent', CURRENT_DATE)
ON CONFLICT DO NOTHING;

-- 18. HOLIDAYS (Nigerian Public Holidays 2026)
INSERT INTO holidays (name, date, description, year) VALUES
('New Year''s Day', '2026-01-01', 'Public holiday commemorating the start of the year', 2026),
('Workers'' Day', '2026-05-01', 'International Labor Day celebration', 2026),
('Democracy Day', '2026-06-12', 'Commemoration of Nigeria''s democratic heritage', 2026),
('Independence Day', '2026-10-01', 'National Independence Day celebration', 2026),
('Christmas Day', '2026-12-25', 'Celebration of Christmas', 2026),
('Boxing Day', '2026-12-26', 'Boxing Day holiday', 2026)
ON CONFLICT (date) DO NOTHING;
