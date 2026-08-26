// ==============================================================================
// EDGEWFORCE - PRODUCTION DATABASE CLEANUP & RESET SCRIPT
// Run with: node server/scripts/cleanDatabase.js
// ==============================================================================

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import bcrypt from 'bcryptjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const dataDir = path.resolve(__dirname, '../data');
const storePath = path.join(dataDir, 'store.json');

const passwordHash = bcrypt.hashSync('ChangeMe123!', 10);

const cleanState = {
  companies: [
    {
      id: 1,
      name: 'Experiential Edge Nigeria Limited',
      business_type: 'Commercial Sales & Field Operations',
      registration_number: 'RC-1849204',
      email: 'operations@edgewforce.com',
      phone: '+2348030000001',
      address: '15 Atiba Osborne, Mende, Maryland, Lagos, Nigeria',
      country: 'Nigeria',
      state: 'Lagos',
      city: 'Lagos',
      status: 'active',
      created_at: new Date().toISOString()
    }
  ],
  company_settings: [
    {
      id: 1,
      company_id: 1,
      working_days: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      working_hours_start: '08:00',
      working_hours_end: '17:00',
      geofence_radius: 150,
      monthly_target_ngn: 10000000,
      commission_percent: 5,
      currency: 'NGN',
      timezone: 'Africa/Lagos',
      active_modules: {
        workforce: true,
        attendance: true,
        field: true,
        sales: true,
        crm: true,
        payments: true,
        inventory: true,
        delivery: true,
        reports: true,
        tracking: true
      }
    }
  ],
  roles: [
    { id: 1, name: 'super_admin', description: 'Platform Super Administrator' },
    { id: 2, name: 'agent_admin', description: 'Company Agent Administrator' },
    { id: 3, name: 'supervisor', description: 'Field Sales Supervisor' },
    { id: 4, name: 'sales_agent', description: 'Sales Agent' },
    { id: 5, name: 'field_agent', description: 'Field Agent' },
    { id: 6, name: 'hr_manager', description: 'Human Resources Manager' },
    { id: 7, name: 'staff', description: 'General Staff Member' }
  ],
  ranks: [
    { id: 1, code: 'CEO', name: 'Chief Executive Officer', level: 1, description: 'Executive Leadership' },
    { id: 2, code: 'CTO', name: 'Chief Technology Officer', level: 2, description: 'Technology & Infrastructure' },
    { id: 3, code: 'HR', name: 'Head of People & HR', level: 3, description: 'Human Resources & Talent' },
    { id: 4, code: 'SENIOR_ACCOUNTANT', name: 'Head of Finance & Accounts', level: 4, description: 'Financial Governance' },
    { id: 5, code: 'EXECUTIVE_DIRECTOR', name: 'Commercial Operations Director', level: 5, description: 'Commercial Strategy' },
    { id: 6, code: 'MANAGER', name: 'Territory Sales Manager', level: 6, description: 'Area Commercial Operations' },
    { id: 7, code: 'SUPERVISOR', name: 'Field Operations Supervisor', level: 7, description: 'Field Force Management' },
    { id: 8, code: 'STAFF', name: 'Operational Field / Sales Agent', level: 8, description: 'Field Execution & Sales' }
  ],
  users: [
    { id: 1, email: 'ceo@edgewforce.com', password_hash: passwordHash, full_name: 'Chief Executive Officer', role_code: 'super_admin', company_id: 1, status: 'active', created_at: new Date().toISOString() },
    { id: 2, email: 'it@edgewforce.com', password_hash: passwordHash, full_name: 'IT System Administrator', role_code: 'super_admin', company_id: 1, status: 'active', created_at: new Date().toISOString() },
    { id: 3, email: 'hr@edgewforce.com', password_hash: passwordHash, full_name: 'HR & People Manager', role_code: 'hr_manager', company_id: 1, status: 'active', created_at: new Date().toISOString() },
    { id: 4, email: 'admin@edgewforce.com', password_hash: passwordHash, full_name: 'Platform Super Administrator', role_code: 'super_admin', company_id: 1, status: 'active', created_at: new Date().toISOString() }
  ],
  profiles: [
    { id: '11111111-1111-4111-a111-111111111111', company_id: 1, first_name: 'Chief Executive', last_name: 'Officer', phone: '+2348030000001', status: 'active' },
    { id: '22222222-2222-4222-a222-222222222222', company_id: 1, first_name: 'IT', last_name: 'Administrator', phone: '+2348030000002', status: 'active' },
    { id: '33333333-3333-4333-a333-333333333333', company_id: 1, first_name: 'HR', last_name: 'Manager', phone: '+2348030000003', status: 'active' },
    { id: '44444444-4444-4444-a444-444444444444', company_id: 1, first_name: 'Super', last_name: 'Admin', phone: '+2348030000004', status: 'active' }
  ],
  employees: [
    { id: '11111111-1111-4111-a111-111111111111', user_id: 1, company_id: 1, role_id: 1, employee_code: 'EMP-001', first_name: 'Chief Executive', last_name: 'Officer', department: 'Executive Management', job_title: 'Chief Executive Officer', position: 'Chief Executive Officer', rank_code: 'CEO', base_salary: 2500000, housing_allowance: 500000, transport_allowance: 300000, status: 'active' },
    { id: '22222222-2222-4222-a222-222222222222', user_id: 2, company_id: 1, role_id: 1, employee_code: 'EMP-002', first_name: 'IT', last_name: 'Administrator', department: 'Information Technology', job_title: 'IT Administrator', position: 'IT Administrator', rank_code: 'CTO', reporting_manager_id: 1, base_salary: 1200000, housing_allowance: 250000, transport_allowance: 150000, status: 'active' },
    { id: '33333333-3333-4333-a333-333333333333', user_id: 3, company_id: 1, role_id: 6, employee_code: 'EMP-003', first_name: 'HR', last_name: 'Manager', department: 'Human Resources', job_title: 'HR Manager', position: 'People Operations Manager', rank_code: 'HR', reporting_manager_id: 1, base_salary: 1100000, housing_allowance: 200000, transport_allowance: 150000, status: 'active' },
    { id: '44444444-4444-4444-a444-444444444444', user_id: 4, company_id: 1, role_id: 1, employee_code: 'EMP-004', first_name: 'Super', last_name: 'Admin', department: 'Executive Governance', job_title: 'Super Administrator', position: 'Super Administrator', rank_code: 'CEO', reporting_manager_id: 1, base_salary: 1500000, housing_allowance: 300000, transport_allowance: 200000, status: 'active' }
  ],
  markets: [
    { id: 1, company_id: 1, name: 'Lagos Central Commercial Zone', code: 'MKT-LOS-01', state: 'Lagos', city: 'Ikeja', address: 'Commercial Layout, Ikeja', status: 'active' },
    { id: 2, company_id: 1, name: 'Lekki & Island Trade Corridor', code: 'MKT-LOS-02', state: 'Lagos', city: 'Lekki', address: 'Lekki Expressway Corridor', status: 'active' }
  ],
  stores: [
    { id: 1, company_id: 1, market_id: 1, name: 'Ikeja Central Retail Hub', code: 'STR-LOS-001', owner_name: 'Alhaji Musa Gbadamosi', phone: '+2348021112233', address: 'Plot 4 Commercial Avenue, Ikeja', state: 'Lagos', city: 'Ikeja', latitude: 6.5984, longitude: 3.3524, geofence_radius_meters: 150, status: 'active' },
    { id: 2, company_id: 1, market_id: 2, name: 'Lekki Palms Supercenter', code: 'STR-LOS-002', owner_name: 'Mrs. Folake Adeleke', phone: '+2348023334455', address: 'Block 12 Expressway Corridor, Lekki', state: 'Lagos', city: 'Lekki', latitude: 6.4281, longitude: 3.4219, geofence_radius_meters: 150, status: 'active' }
  ],
  warehouses: [
    { id: 1, company_id: 1, name: 'Ikeja Central Depot', code: 'WH-IKJ-01', address: 'Plot 4 Commercial Avenue, Ikeja Industrial Estate, Lagos', city: 'Ikeja', state: 'Lagos', status: 'active' },
    { id: 2, company_id: 1, name: 'Lekki Distribution Hub', code: 'WH-LKK-02', address: 'Block 12 Expressway Corridor, Lekki Phase 1, Lagos', city: 'Lekki', state: 'Lagos', status: 'active' },
    { id: 3, company_id: 1, name: 'Abuja Regional Depot', code: 'WH-ABJ-03', address: 'Industrial Layout Phase 2, Idu Industrial Area, Abuja', city: 'Abuja', state: 'FCT', status: 'active' }
  ],
  products: [
    { id: 1, company_id: 1, sku: 'SKU-001', name: 'Golden Penny Pure Vegetable Oil (5 Litres)', description: 'Premium edible vegetable oil', category: 'Cooking Oils & Fats', brand: 'Golden Penny', unit: 'carton', cost_price: 15000, selling_price: 18500, price: 18500, reorder_level: 25, status: 'active', warehouse_name: 'Ikeja Central Depot', shelve_location: 'Aisle 1 - Bay A (Rack 1)' },
    { id: 2, company_id: 1, sku: 'SKU-002', name: 'Dangote Refined Granulated Sugar (50kg Bag)', description: 'Fortified granulated white sugar', category: 'Sugar & Sweeteners', brand: 'Dangote', unit: 'bag', cost_price: 60000, selling_price: 68000, price: 68000, reorder_level: 15, status: 'active', warehouse_name: 'Ikeja Central Depot', shelve_location: 'Aisle 2 - Bay C (Pallet 3)' },
    { id: 3, company_id: 1, sku: 'SKU-003', name: 'Indomie Instant Noodles Super Pack (40 x 120g)', description: 'Instant noodles super pack carton', category: 'Packaged Food', brand: 'Indomie', unit: 'carton', cost_price: 12000, selling_price: 14200, price: 14200, reorder_level: 40, status: 'active', warehouse_name: 'Lekki Distribution Hub', shelve_location: 'Aisle 3 - Bay B (Rack 2)' }
  ],
  inventory: [
    { id: 1, company_id: 1, product_id: 1, store_id: 1, quantity: 120, reserved_quantity: 0, available_quantity: 120, last_restocked_at: new Date().toISOString() },
    { id: 2, company_id: 1, product_id: 2, store_id: 1, quantity: 45, reserved_quantity: 0, available_quantity: 45, last_restocked_at: new Date().toISOString() },
    { id: 3, company_id: 1, product_id: 3, store_id: 2, quantity: 200, reserved_quantity: 0, available_quantity: 200, last_restocked_at: new Date().toISOString() }
  ],
  attendance: [],
  field_visits: [],
  visits: [],
  sales: [],
  sale_items: [],
  orders: [],
  tasks: [],
  expenses: [],
  notifications: [
    {
      id: 1,
      company_id: 1,
      user_id: '11111111-1111-4111-a111-111111111111',
      title: 'Canonical Database Architecture Active',
      message: 'EdgeWForce canonical database schema is synchronized with Supabase PostgreSQL.',
      type: 'general',
      is_read: false,
      created_at: new Date().toISOString()
    }
  ],
  audit_logs: [],
  collections: [],
  deliveries: [],
  leave_requests: [],
  idle_alerts: [],
  sos: [],
  announcements: [
    {
      id: 1,
      company_id: 1,
      title: 'Welcome to EdgeWForce Corporate Platform',
      message: 'EdgeWForce is fully deployed and configured for Experiential Edge Nigeria Limited field sales, supply chain, and workforce operations.',
      category: 'General',
      priority: 'HIGH',
      target_audience: 'ALL',
      author_name: 'Executive Management',
      pinned: true,
      created_at: new Date().toISOString()
    }
  ],
  inventory_movements: []
};

if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir, { recursive: true });
}

fs.writeFileSync(storePath, JSON.stringify(cleanState, null, 2), 'utf-8');
console.log('✅ EdgeWForce database cleaned and initialized with clean corporate baseline.');
