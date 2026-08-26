// ==============================================================================
// EDGEWFORCE - UNIFIED DATABASE DATA ACCESS LAYER
// Supports Supabase PostgreSQL and Transactional In-Memory / File Persistent Store
// ==============================================================================

import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import bcrypt from 'bcryptjs';
import { logger } from '../utils/logger.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const dataDir = path.resolve(__dirname, '../../data');
const storePath = path.join(dataDir, 'store.json');

fs.mkdirSync(dataDir, { recursive: true });

export let supabase = null;

const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_KEY || process.env.SUPABASE_ANON_KEY;

// Dynamically initialize Supabase if credentials are provided and not in test runner
if (process.env.NODE_ENV !== 'test' && !process.env.TEST_MODE && process.env.SUPABASE_URL && supabaseKey) {
  try {
    const { createClient } = await import('@supabase/supabase-js');
    supabase = createClient(process.env.SUPABASE_URL, supabaseKey, {
      auth: { persistSession: false }
    });
    logger.info('Connected to Supabase PostgreSQL database.');
  } catch (err) {
    logger.warn(`Supabase connection failed: ${err.message}. Operating in local transactional mode.`);
  }
} else {
  logger.info('Supabase credentials not set or in test mode; utilizing high-fidelity local transactional store with persistence.');
}

const defaultPasswordHash = bcrypt.hashSync('ChangeMe123!', 10);

// Helper to generate 100 realistic Nigerian customers
function generateSeedCustomers() {
  const storeNames = [
    'Mega Plaza Supermarket', 'Prince Ebeano Supermarket Lekki', 'Spar Nigeria Ikeja Mall', 'Goodies Supermarket VI',
    'Hubmart Stores Ikeja GRA', 'Jendol Superstore Egbeda', 'Justrite Superstore Ikorodu', 'Bazaar Supermarket Victoria Island',
    'Grand Square Supermarket Abuja', 'Next Cash & Carry Abuja', '4U Supermarket Wuse 2 Abuja', 'Sahad Stores Central Abuja',
    'Market Square Port Harcourt', 'Everyday Supermarket GRA Port Harcourt', 'Genesis Hypermarket Port Harcourt',
    'Well Care Supermarket Kano', 'Country Store Supermarket Kano', 'Jifatu General Enterprises Kano',
    'Blenco Supermarket Sangotedo', 'Adide Retail Outlet Surulere', 'De-Prince Supermarket Magodo', 'Super Saver Ketu',
    'Addide Stores Yaba', 'Best Choice Supermarket Opebi', 'Choice City Supermarket Festac', 'Bheerhugz Retail Palms Lekki',
    'Twins Faja Supermarket Trade Fair', 'Abebi Stores Balogun Market', 'Chukwudi Provisions Onitsha Depot', 'Danbaba Wholesalers Kano',
    'Iya Moria General Provisions Gbagi', 'Boluwatife Stores Dugbe Ibadan', 'Alhaji Musa Grain Depot Bodija', 'Kano Central Provisions Dawanau',
    'Onyx Wholesale Depot Alaba', 'Success & Sons Minimart Agege', 'Divine Mercy Supermarket Ajah', 'Blessed Trinity Groceries Owerri',
    'Pinnacle Mart Asaba', 'Greenfields Retailers Calabar', 'Atlantic Supermarket Uyo', 'Crown Supermarket Benin City',
    'Emirates Wholesale Depot Warri', 'Zenith Superstores Jos', 'Unity Minimart Kaduna', 'Savannah Provisions Maiduguri',
    'Silverbird Retail Gallery VI', 'Amigo Department Store Abuja', 'Globus Supermarket Ikeja', 'Alpha & Omega Store Satellite Town'
  ];

  const territories = [
    { id: 1, name: 'Lagos Mainland', region_id: 1, baseLat: 6.5244, baseLng: 3.3792 },
    { id: 2, name: 'Lagos Island & Lekki', region_id: 1, baseLat: 6.4281, baseLng: 3.4219 },
    { id: 3, name: 'Ikeja & Industrial', region_id: 1, baseLat: 6.5984, baseLng: 3.3524 },
    { id: 4, name: 'Abuja Central', region_id: 2, baseLat: 9.0765, baseLng: 7.3986 },
    { id: 5, name: 'Port Harcourt Metro', region_id: 3, baseLat: 4.8156, baseLng: 7.0498 },
    { id: 6, name: 'Kano Urban', region_id: 2, baseLat: 12.0022, baseLng: 8.5920 }
  ];

  const types = ['Retail', 'Wholesale', 'Distributor', 'Modern Trade', 'Key Account'];
  const tiers = ['Tier 1', 'Tier 2', 'Tier 3'];
  const customers = [];

  for (let i = 1; i <= 100; i++) {
    const baseName = storeNames[(i - 1) % storeNames.length];
    const name = i > storeNames.length ? `${baseName} - Branch ${Math.floor(i / storeNames.length) + 1}` : baseName;
    const terr = territories[(i - 1) % territories.length];
    const custType = types[(i - 1) % types.length];
    const tier = tiers[(i - 1) % tiers.length];

    // Jitter coordinates slightly around base
    const lat = Number((terr.baseLat + (Math.sin(i * 99) * 0.045)).toFixed(6));
    const lng = Number((terr.baseLng + (Math.cos(i * 99) * 0.045)).toFixed(6));

    customers.push({
      id: i,
      company_id: 1,
      code: `CUST-${String(1000 + i)}`,
      name,
      business_name: name,
      customer_type: custType,
      tier,
      region_id: terr.region_id,
      territory_id: terr.id,
      territory: terr.name,
      address: `${10 + (i % 80)} Commercial Avenue, ${terr.name}`,
      latitude: lat,
      longitude: lng,
      geofence_radius: 150,
      contact_person: `Manager ${i}`,
      phone: `+23480${String(10000000 + i * 8831).slice(0, 8)}`,
      email: `outlet${i}@retailnetwork.ng`,
      credit_limit: custType === 'Distributor' ? 5000000 : (custType === 'Wholesale' ? 2500000 : 800000),
      balance: (i % 4 === 0) ? (i * 35000) : ((i % 5 === 0) ? (i * 18000) : 0),
      assigned_agent_id: 1 + (i % 12),
      assigned_supervisor_id: 9 + (i % 3),
      status: 'active',
      last_visit_at: new Date(Date.now() - (i % 7) * 86400000).toISOString(),
      last_order_at: new Date(Date.now() - (i % 5) * 86400000).toISOString(),
      total_sales_ngn: (i * 125000) + 250000,
      created_at: new Date(Date.now() - 60 * 86400000).toISOString()
    });
  }
  return customers;
}

// Helper to generate 50 realistic products with Nigerian FMCG brands
function generateSeedProducts() {
  const catalog = [
    { sku: 'SKU-1001', name: 'Golden Penny Pure Vegetable Oil (1L x 12)', category: 'Cooking Essentials', price: 48500, cost_price: 42000, unit: 'carton' },
    { sku: 'SKU-1002', name: 'Milo Energy Food Drink 500g (Tin x 24)', category: 'Beverages', price: 78000, cost_price: 68000, unit: 'carton' },
    { sku: 'SKU-1003', name: 'Dangote Granulated Sugar 50kg Sack', category: 'Commodities', price: 88000, cost_price: 79000, unit: 'bag' },
    { sku: 'SKU-1004', name: 'Indomie Super Pack Onion Chicken (40 packs)', category: 'Packaged Foods', price: 18500, cost_price: 15500, unit: 'carton' },
    { sku: 'SKU-1005', name: 'Peak Full Cream Milk Powder 400g (x 24)', category: 'Dairy', price: 84000, cost_price: 74000, unit: 'carton' },
    { sku: 'SKU-1006', name: 'Knorr Chicken Seasoning Cubes (50 x 24)', category: 'Seasonings', price: 34000, cost_price: 29000, unit: 'carton' },
    { sku: 'SKU-1007', name: 'Eva Premium Table Water 75cl (Pack of 12)', category: 'Beverages', price: 3200, cost_price: 2500, unit: 'pack' },
    { sku: 'SKU-1008', name: 'Dano Cool Cow Evaporated Milk (48 x 160g)', category: 'Dairy', price: 41000, cost_price: 35500, unit: 'carton' },
    { sku: 'SKU-1009', name: 'Golden Penny Semovita 10kg Bag', category: 'Packaged Foods', price: 14500, cost_price: 12200, unit: 'bag' },
    { sku: 'SKU-1010', name: 'Mama Gold Thai Parboiled Rice 50kg', category: 'Commodities', price: 92000, cost_price: 84000, unit: 'bag' },
    { sku: 'SKU-1011', name: 'Gino Tomato Paste 70g Sachet (50 x 5)', category: 'Cooking Essentials', price: 29500, cost_price: 25000, unit: 'carton' },
    { sku: 'SKU-1012', name: 'Sunlight 2-in-1 Detergent Powder 900g (x 12)', category: 'Household Care', price: 24000, cost_price: 19800, unit: 'carton' },
    { sku: 'SKU-1013', name: 'Hypo Bleach Super Shine 1L (x 12)', category: 'Household Care', price: 16500, cost_price: 13500, unit: 'carton' },
    { sku: 'SKU-1014', name: 'Morning Fresh Dishwashing Liquid 1L (x 12)', category: 'Household Care', price: 28000, cost_price: 23500, unit: 'carton' },
    { sku: 'SKU-1015', name: 'CloseUp Red Hot Gel Toothpaste 140g (x 48)', category: 'Personal Care', price: 42000, cost_price: 36000, unit: 'carton' },
    { sku: 'SKU-1016', name: 'Dettol Antiseptic Disinfectant Liquid 500ml (x 12)', category: 'Personal Care', price: 38000, cost_price: 32000, unit: 'carton' },
    { sku: 'SKU-1017', name: 'Premier Cool Deodorant Soap 125g (x 48)', category: 'Personal Care', price: 26000, cost_price: 21500, unit: 'carton' },
    { sku: 'SKU-1018', name: 'Lipton Yellow Label Tea Bags (100s x 12)', category: 'Beverages', price: 28500, cost_price: 24000, unit: 'carton' },
    { sku: 'SKU-1019', name: 'Nescafe Classic Instant Coffee 50g (x 24)', category: 'Beverages', price: 36000, cost_price: 30500, unit: 'carton' },
    { sku: 'SKU-1020', name: 'Coca-Cola Original 50cl PET (Pack of 12)', category: 'Beverages', price: 4800, cost_price: 3900, unit: 'pack' },
    { sku: 'SKU-1021', name: 'Malta Guinness Can 33cl (Pack of 24)', category: 'Beverages', price: 14500, cost_price: 12200, unit: 'pack' },
    { sku: 'SKU-1022', name: 'Monster Energy Drink 500ml (Pack of 24)', category: 'Beverages', price: 29000, cost_price: 24500, unit: 'pack' },
    { sku: 'SKU-1023', name: 'Chivita 100% Real Orange Juice 1L (x 10)', category: 'Beverages', price: 17500, cost_price: 14800, unit: 'carton' },
    { sku: 'SKU-1024', name: 'Hollandia Yoghurt Plain Sweet 1L (x 10)', category: 'Dairy', price: 18500, cost_price: 15400, unit: 'carton' },
    { sku: 'SKU-1025', name: 'Pringles Sour Cream & Onion 165g (x 14)', category: 'Snacks & Biscuits', price: 35000, cost_price: 29500, unit: 'carton' },
    { sku: 'SKU-1026', name: 'Beloxxi Cream Crackers Biscuit (Pack of 30)', category: 'Snacks & Biscuits', price: 12500, cost_price: 10200, unit: 'carton' },
    { sku: 'SKU-1027', name: 'McVities Digestives Original 400g (x 12)', category: 'Snacks & Biscuits', price: 26000, cost_price: 21800, unit: 'carton' },
    { sku: 'SKU-1028', name: 'Gala Sausage Roll Regular (Box of 100)', category: 'Snacks & Biscuits', price: 19500, cost_price: 16000, unit: 'carton' },
    { sku: 'SKU-1029', name: 'Pampers Baby Dry Diapers Maxi Size 4 (Pack of 4)', category: 'Baby & Child Care', price: 44000, cost_price: 37500, unit: 'carton' },
    { sku: 'SKU-1030', name: 'Cussons Baby Powder 200g (x 24)', category: 'Baby & Child Care', price: 31000, cost_price: 26000, unit: 'carton' },
    { sku: 'SKU-1031', name: 'Always Ultra Sanitary Pads (Pack of 24)', category: 'Personal Care', price: 29500, cost_price: 24800, unit: 'carton' },
    { sku: 'SKU-1032', name: 'Oral-B Pro-Health Toothbrush (Pack of 24)', category: 'Personal Care', price: 22000, cost_price: 18000, unit: 'carton' },
    { sku: 'SKU-1033', name: 'Devon Kings Margarine 250g (x 24)', category: 'Cooking Essentials', price: 27500, cost_price: 23000, unit: 'carton' },
    { sku: 'SKU-1034', name: 'Mamador Pure Cook Vegetable Oil 3.8L (x 4)', category: 'Cooking Essentials', price: 62000, cost_price: 54000, unit: 'carton' },
    { sku: 'SKU-1035', name: 'Grand Pure Soya Oil 2.75L (x 6)', category: 'Cooking Essentials', price: 58000, cost_price: 50500, unit: 'carton' },
    { sku: 'SKU-1036', name: 'Golden Terra Soya Oil Sachet 1L (x 12)', category: 'Cooking Essentials', price: 46000, cost_price: 39500, unit: 'carton' },
    { sku: 'SKU-1037', name: 'Royco Beef Seasoning Cubes (40 x 24)', category: 'Seasonings', price: 31000, cost_price: 26500, unit: 'carton' },
    { sku: 'SKU-1038', name: 'Terra Chicken Seasoning Cubes (50 x 24)', category: 'Seasonings', price: 28500, cost_price: 24000, unit: 'carton' },
    { sku: 'SKU-1039', name: 'Golden Penny Spaghetti 500g (x 20)', category: 'Packaged Foods', price: 22000, cost_price: 18500, unit: 'carton' },
    { sku: 'SKU-1040', name: 'Dangote Flour 50kg Confectionery Bag', category: 'Commodities', price: 74000, cost_price: 66000, unit: 'bag' },
    { sku: 'SKU-1041', name: 'Nutrimilk Apple Flavoured Drink 500ml (x 12)', category: 'Beverages', price: 6200, cost_price: 5100, unit: 'pack' },
    { sku: 'SKU-1042', name: 'Chi Exotic Nectar Pineapple Coconut 1L (x 10)', category: 'Beverages', price: 18000, cost_price: 15200, unit: 'carton' },
    { sku: 'SKU-1043', name: 'Five Alive Citrus Burst Juice 75cl (Pack of 12)', category: 'Beverages', price: 9500, cost_price: 7900, unit: 'pack' },
    { sku: 'SKU-1044', name: 'Ariel Auto Washing Powder 2kg (x 6)', category: 'Household Care', price: 38000, cost_price: 32500, unit: 'carton' },
    { sku: 'SKU-1045', name: 'Viva Plus Detergent 900g (x 12)', category: 'Household Care', price: 21000, cost_price: 17500, unit: 'carton' },
    { sku: 'SKU-1046', name: 'Harpic Power Plus Toilet Cleaner 750ml (x 12)', category: 'Household Care', price: 24500, cost_price: 20500, unit: 'carton' },
    { sku: 'SKU-1047', name: 'Baygon Multi Insect Killer Spray 600ml (x 12)', category: 'Household Care', price: 39000, cost_price: 33500, unit: 'carton' },
    { sku: 'SKU-1048', name: 'Vaseline Petroleum Jelly Original 250g (x 24)', category: 'Personal Care', price: 34500, cost_price: 29000, unit: 'carton' },
    { sku: 'SKU-1049', name: 'Nivea Body Milk Lotion 400ml (x 12)', category: 'Personal Care', price: 56000, cost_price: 48000, unit: 'carton' },
    { sku: 'SKU-1050', name: 'Oral-B Complete Toothpaste 100ml (x 24)', category: 'Personal Care', price: 29000, cost_price: 24500, unit: 'carton' }
  ];

  const warehousesList = ['Ikeja Central Depot', 'Apapa Port Hub', 'Abuja Regional Warehouse'];

  return catalog.map((p, idx) => {
    const whName = warehousesList[idx % warehousesList.length];
    const aisle = (idx % 8) + 1;
    const bay = String.fromCharCode(65 + (idx % 6));
    const rack = (idx % 4) + 1;
    return {
      id: idx + 1,
      company_id: 1,
      ...p,
      warehouse_name: whName,
      shelve_location: `Aisle ${aisle} - Bay ${bay} (Rack ${rack})`,
      stock_quantity: 80 + (idx * 5),
      reorder_level: 25,
      status: 'active',
      created_at: new Date().toISOString()
    };
  });
}

const initialSeed = {
  companies: [
    {
      id: 1,
      uuid: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
      name: 'Nexfeild',
      business_type: 'FMCG Wholesale & Retail Distribution',
      industry: 'Consumer Goods & Retail',
      registration_number: 'RC-1849201',
      email: 'operations@nexfeild.ng',
      phone: '+2348006393435',
      address: 'Plot 12, Commercial Avenue, Ikeja Industrial Estate, Lagos',
      country: 'Nigeria',
      state: 'Lagos',
      city: 'Ikeja',
      logo_url: null,
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
      attendance_rules: { require_gps: true, require_selfie: false, auto_checkout: true },
      visit_rules: { min_duration_minutes: 15, require_photo: true, require_signature: true },
      sales_targets: { monthly_target_ngn: 10000000, commission_percent: 5 },
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
      },
      created_at: new Date().toISOString()
    }
  ],
  regions: [
    { id: 1, company_id: 1, code: 'SW', name: 'South-West Region (Lagos & Ogun)', description: 'Primary commercial hub and retail corridor' },
    { id: 2, company_id: 1, code: 'NC', name: 'North-Central Region (Abuja & Plateau)', description: 'Federal capital territory and northern gateway' },
    { id: 3, company_id: 1, code: 'SS', name: 'South-South / South-East (Rivers & Enugu)', description: 'Oil hub and eastern trade networks' }
  ],
  territories: [
    { id: 1, company_id: 1, region_id: 1, code: 'LAG-MAIN', name: 'Lagos Mainland' },
    { id: 2, company_id: 1, region_id: 1, code: 'LAG-ISL', name: 'Lagos Island & Lekki' },
    { id: 3, company_id: 1, region_id: 1, code: 'LAG-IKJ', name: 'Ikeja & Industrial' },
    { id: 4, company_id: 1, region_id: 2, code: 'ABJ-CEN', name: 'Abuja Central' },
    { id: 5, company_id: 1, region_id: 3, code: 'PH-METRO', name: 'Port Harcourt Metro' },
    { id: 6, company_id: 1, region_id: 2, code: 'KAN-URB', name: 'Kano Urban' }
  ],
  teams: [
    { id: 1, company_id: 1, territory_id: 1, name: 'Team Alpha (Mainland Commercials)', supervisor_id: 9 },
    { id: 2, company_id: 1, territory_id: 2, name: 'Team Bravo (Island & Key Accounts)', supervisor_id: 9 },
    { id: 3, company_id: 1, territory_id: 3, name: 'Team Charlie (Ikeja Merchandising)', supervisor_id: 9 },
    { id: 4, company_id: 1, territory_id: 4, name: 'Team Delta (Abuja Federal)', supervisor_id: 9 },
    { id: 5, company_id: 1, territory_id: 5, name: 'Team Echo (Rivers & Delta)', supervisor_id: 9 }
  ],
  branches: [
    { id: 1, company_id: 1, name: 'Lagos Corporate HQ', address: '15 Atiba Osborne, Mende, Maryland, Lagos', phone: '+2348031234567' },
    { id: 2, company_id: 1, name: 'Victoria Island Experience Center', address: '14B Idowu Martins St, VI, Lagos', phone: '+2348099887766' },
    { id: 3, company_id: 1, name: 'Abuja Regional Distribution Hub', address: 'Plot 412, Central Business District, Abuja', phone: '+2348055443322' },
    { id: 4, company_id: 1, name: 'Port Harcourt Operations Base', address: '54 Trans-Amadi Industrial Layout, PH', phone: '+2348077665544' }
  ],
  warehouses: [
    { id: 1, company_id: 1, code: 'WH-IKJ', name: 'Ikeja Central Distribution Center', address: 'Plot 12, Commercial Avenue, Ikeja, Lagos', manager_id: 8 },
    { id: 2, company_id: 1, code: 'WH-LEK', name: 'Lekki Peninsula Fulfillment Depot', address: 'Oniru Commercial Zone, Lekki, Lagos', manager_id: 9 },
    { id: 3, company_id: 1, code: 'WH-ABJ', name: 'Abuja Northern Hub Warehouse', address: 'Industrial Layout, Idu, Abuja', manager_id: 8 }
  ],
  departments: [
    { id: 1, name: 'Commercial Sales', code: 'SALES', description: 'Retail distribution & accounts' },
    { id: 2, name: 'Field Operations', code: 'FIELD', description: 'Store audits & route execution' },
    { id: 3, name: 'Human Resources', code: 'HR', description: 'People operations & welfare' },
    { id: 4, name: 'Finance & Accounts', code: 'FINANCE', description: 'Treasury, collections & payroll' },
    { id: 5, name: 'Technology & IT', code: 'TECH', description: 'Portal administration, security & telemetry' },
    { id: 6, name: 'Executive Management', code: 'EXEC', description: 'Strategic leadership' }
  ],
  ranks: [
    { id: 1, code: 'CEO', name: 'Chief Executive Officer', level: 1, active: true },
    { id: 2, code: 'IT_ADMIN', name: 'IT Super Admin / Portal Administrator', level: 1, active: true },
    { id: 3, code: 'CTO', name: 'Chief Technology Officer', level: 2, active: true },
    { id: 4, code: 'HR', name: 'Head of Human Resources', level: 3, active: true },
    { id: 5, code: 'SENIOR_ACCOUNTANT', name: 'Head of Accounting & Payroll', level: 4, active: true },
    { id: 6, code: 'ACCOUNTANT', name: 'Accountant', level: 5, active: true },
    { id: 7, code: 'MANAGER', name: 'Regional Manager', level: 6, active: true },
    { id: 8, code: 'SUPERVISOR', name: 'Field Operations Supervisor', level: 7, active: true },
    { id: 9, code: 'STAFF', name: 'Operations Staff', level: 8, active: true }
  ],
  permissions: [
    { id: 1, code: 'view_dashboard', name: 'View Dashboard', category: 'General' },
    { id: 2, code: 'view_employees', name: 'View Employees', category: 'HR' },
    { id: 3, code: 'create_employee', name: 'Create Employee', category: 'HR' },
    { id: 4, code: 'edit_employee', name: 'Edit Employee', category: 'HR' },
    { id: 5, code: 'assign_tasks', name: 'Assign Tasks', category: 'Tasks' },
    { id: 6, code: 'approve_leave', name: 'Approve Leave', category: 'HR' },
    { id: 7, code: 'view_payroll', name: 'View Payroll', category: 'Finance' },
    { id: 8, code: 'manage_payroll', name: 'Manage Payroll', category: 'Finance' },
    { id: 9, code: 'view_attendance', name: 'View Attendance', category: 'HR' },
    { id: 10, code: 'manage_attendance', name: 'Manage Attendance', category: 'HR' },
    { id: 11, code: 'view_idle_reports', name: 'View Idle Reports', category: 'HR' },
    { id: 12, code: 'manage_ranks', name: 'Manage Ranks', category: 'HR' },
    { id: 13, code: 'view_sales', name: 'View Sales', category: 'Sales' },
    { id: 14, code: 'create_orders', name: 'Create Orders', category: 'Sales' },
    { id: 15, code: 'record_collections', name: 'Record Collections', category: 'Sales' },
    { id: 16, code: 'view_customers', name: 'View Customers', category: 'Sales' },
    { id: 17, code: 'create_customers', name: 'Create Customers', category: 'Sales' },
    { id: 18, code: 'view_field_operations', name: 'View Field Operations', category: 'Field' },
    { id: 19, code: 'manage_routes', name: 'Manage Routes', category: 'Field' },
    { id: 20, code: 'view_sos', name: 'View SOS Alerts', category: 'Emergency' },
    { id: 21, code: 'resolve_sos', name: 'Resolve SOS Alerts', category: 'Emergency' },
    { id: 22, code: 'manage_products', name: 'Manage Products', category: 'Inventory' },
    { id: 23, code: 'view_competitors', name: 'View Competitor Intel', category: 'Marketing' },
    { id: 24, code: 'view_reports', name: 'View Reports', category: 'Executive' },
    { id: 25, code: 'admin_portal', name: 'Super Admin Portal Access', category: 'IT' }
  ],
  users: [
    { id: 1, company_id: 1, full_name: 'IT Super Admin', email: 'it@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348000000001', role_code: 'SUPER_ADMIN', status: 'active', created_at: new Date().toISOString() },
    { id: 2, company_id: 1, full_name: 'Chief Executive Officer', email: 'ceo@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348000000002', role_code: 'CEO', status: 'active', created_at: new Date().toISOString() },
    { id: 3, company_id: 1, full_name: 'Head of Human Resources', email: 'hr@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348000000003', role_code: 'HR_MANAGER', status: 'active', created_at: new Date().toISOString() },
    { id: 4, company_id: 1, full_name: 'Commercial Sales Lead', email: 'sales@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348031234567', role_code: 'SALES_AGENT', status: 'active', created_at: new Date().toISOString() },
    { id: 5, company_id: 1, full_name: 'Field Operations Lead', email: 'field@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348029876543', role_code: 'FIELD_AGENT', status: 'active', created_at: new Date().toISOString() },
    { id: 6, company_id: 1, full_name: 'Finance & Accounting Lead', email: 'accountant@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348000000006', role_code: 'ACCOUNTANT', status: 'active', created_at: new Date().toISOString() },
    { id: 7, company_id: 1, full_name: 'Field Operations Supervisor', email: 'supervisor@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348187654321', role_code: 'SUPERVISOR', status: 'active', created_at: new Date().toISOString() },
    { id: 8, company_id: 1, full_name: 'Corporate Operations Staff', email: 'staff@edgewforce.com', password_hash: defaultPasswordHash, phone: '+2348145550192', role_code: 'STAFF_MEMBER', status: 'active', created_at: new Date().toISOString() }
  ],
  employees: [
    { id: 1, company_id: 1, user_id: 1, employee_code: 'EMP-1001', first_name: 'IT Admin', last_name: 'Service', phone: '+2348000000001', department_id: 5, department: 'Technology & IT', position: 'IT Super Admin / System Engineer', territory: 'Headquarters', rank_code: 'IT_ADMIN', base_salary: 1800000, performance_score: 98.0, status: 'active' },
    { id: 2, company_id: 1, user_id: 2, employee_code: 'EMP-1002', first_name: 'Executive', last_name: 'Management', phone: '+2348000000002', department_id: 6, department: 'Executive Management', position: 'Chief Executive Officer', territory: 'National', rank_code: 'CEO', base_salary: 2500000, performance_score: 99.0, status: 'active' },
    { id: 3, company_id: 1, user_id: 3, employee_code: 'EMP-1003', first_name: 'HR', last_name: 'Manager', phone: '+2348000000003', department_id: 3, department: 'Human Resources', position: 'Head of Human Resources', territory: 'Headquarters', rank_code: 'HR', base_salary: 1200000, performance_score: 95.0, status: 'active' },
    { id: 4, company_id: 1, user_id: 4, employee_code: 'EMP-1004', first_name: 'Thompson', last_name: 'Babatunde', phone: '+2348031234567', department_id: 1, department: 'Commercial Sales', position: 'Senior Commercial Sales Agent', territory: 'Lagos Mainland', supervisor_id: 7, rank_code: 'STAFF', base_salary: 380000, performance_score: 92.5, status: 'active' },
    { id: 5, company_id: 1, user_id: 5, employee_code: 'EMP-1005', first_name: 'Godfrey', last_name: 'Okorie', phone: '+2348029876543', department_id: 2, department: 'Field Operations', position: 'Field Operations Lead Agent', territory: 'Lagos Island & Lekki', supervisor_id: 7, rank_code: 'STAFF', base_salary: 350000, performance_score: 88.0, status: 'active' },
    { id: 6, company_id: 1, user_id: 6, employee_code: 'EMP-1006', first_name: 'Finance', last_name: 'Officer', phone: '+2348000000006', department_id: 4, department: 'Finance & Accounts', position: 'Head of Accounting & Payroll', territory: 'Headquarters', rank_code: 'ACCOUNTANT', base_salary: 1100000, performance_score: 90.0, status: 'active' },
    { id: 7, company_id: 1, user_id: 7, employee_code: 'EMP-1007', first_name: 'Amina', last_name: 'Bello', phone: '+2348187654321', department_id: 2, department: 'Field Operations', position: 'Field Operations Supervisor', territory: 'Lagos Island', rank_code: 'SUPERVISOR', base_salary: 750000, performance_score: 96.0, status: 'active' },
    { id: 8, company_id: 1, user_id: 8, employee_code: 'EMP-1008', first_name: 'Gloria', last_name: 'Iwuh', phone: '+2348145550192', department_id: 3, department: 'Corporate Operations', position: 'Workforce Operations Analyst', territory: 'Headquarters', supervisor_id: 3, rank_code: 'STAFF', base_salary: 420000, performance_score: 85.0, status: 'active' }
  ],
  customers: generateSeedCustomers(),
  products: generateSeedProducts(),
  orders: [],
  order_items: [],
  order_approvals: [],
  collections: [],
  deliveries: [],
  inventory_movements: [],
  visits: [],
  visit_reports: [],
  attendance: [],
  location_tracking: [],
  alerts: [],
  performance_scores: [],
  audit_logs: [],
  stores: [
    { id: 1, code: 'STR-101', name: 'Mega Plaza Supermarket', store_type: 'Supermarket', contact_person: 'Alhaji Rasheed Bello', phone: '+2348034567890', email: 'procurement@megaplaza.ng', address: '14B Idowu Martins St, Victoria Island, Lagos', territory: 'Lagos Island', latitude: 6.4281, longitude: 3.4219, geofence_radius: 150, supervisor_id: 9, company_id: 1, assigned_field_agents: [2], assigned_sales_agents: [1], status: 'active', created_at: new Date().toISOString() }
  ],
  store_requests: [],
  work_locations: [
    { id: 1, company_id: 1, name: 'Lagos Victoria Island Office', location_type: 'Office', address: '14B Idowu Martins St, Victoria Island', state: 'Lagos', lga: 'Eti-Osa', city: 'Victoria Island', latitude: 6.4281, longitude: 3.4219, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 2, company_id: 1, name: 'Ibadan Dugbe Central Market', location_type: 'Market', address: 'Dugbe Commercial Hub, Ibadan', state: 'Oyo', lga: 'Ibadan North-West', city: 'Ibadan', latitude: 7.3872, longitude: 3.8821, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 3, company_id: 1, name: 'Abeokuta Kuto Regional Market', location_type: 'Market', address: 'Kuto Market Road, Abeokuta', state: 'Ogun', lga: 'Abeokuta South', city: 'Abeokuta', latitude: 7.1452, longitude: 3.3483, geofence_radius: 200, geofence_radius_meters: 200, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 4, company_id: 1, name: 'Abuja Central Business Hub', location_type: 'Branch', address: 'Plot 412 CBD, Abuja', state: 'FCT Abuja', lga: 'Municipal', city: 'Abuja Central', latitude: 9.0578, longitude: 7.4951, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 5, company_id: 1, name: 'Kano Dawanau Provisions Depot', location_type: 'Market', address: 'Dawanau Wholesale Market Axis, Kano', state: 'Kano', lga: 'Dawakin Tofa', city: 'Kano', latitude: 12.0833, longitude: 8.4500, geofence_radius: 250, geofence_radius_meters: 250, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 6, company_id: 1, name: 'Port Harcourt Trans-Amadi Hub', location_type: 'Distributor', address: '54 Trans-Amadi Industrial Layout, Port Harcourt', state: 'Rivers', lga: 'Port Harcourt', city: 'Port Harcourt', latitude: 4.8156, longitude: 7.0498, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 7, company_id: 1, name: 'Enugu Main Market Branch', location_type: 'Branch', address: 'Market Road, Ogbete, Enugu', state: 'Enugu', lga: 'Enugu North', city: 'Enugu', latitude: 6.4474, longitude: 7.4984, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 8, company_id: 1, name: 'Ikeja Central Distribution Depot', location_type: 'Warehouse', address: 'Plot 12, Commercial Avenue, Ikeja Industrial Estate', state: 'Lagos', lga: 'Ikeja', city: 'Ikeja', latitude: 6.5984, longitude: 3.3524, geofence_radius: 150, geofence_radius_meters: 150, status: 'active', created_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() }
  ],
  employee_location_assignments: [
    { id: 1, company_id: 1, employee_id: 1, location_id: 8, assignment_type: 'primary', is_primary: true, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 2, company_id: 1, employee_id: 2, location_id: 1, assignment_type: 'primary', is_primary: true, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 3, company_id: 1, employee_id: 2, location_id: 8, assignment_type: 'secondary', is_primary: false, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 4, company_id: 1, employee_id: 3, location_id: 8, assignment_type: 'primary', is_primary: true, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 5, company_id: 1, employee_id: 11, location_id: 3, assignment_type: 'primary', is_primary: true, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() },
    { id: 6, company_id: 1, employee_id: 12, location_id: 8, assignment_type: 'primary', is_primary: true, is_active: true, start_date: null, end_date: null, assigned_by: 4, created_at: new Date().toISOString(), updated_at: new Date().toISOString() }
  ],
  location_assignment_history: [
    { id: 1, company_id: 1, employee_id: 1, previous_location_id: null, previous_location_name: null, new_location_id: 8, new_location_name: 'Ikeja Central Distribution Depot', assignment_type: 'primary', action: 'ASSIGNED', changed_by: 4, changed_by_name: 'Admin', reason: 'Initial department placement', created_at: new Date(Date.now() - 30 * 86400000).toISOString() },
    { id: 2, company_id: 1, employee_id: 2, previous_location_id: null, previous_location_name: null, new_location_id: 1, new_location_name: 'Lagos Victoria Island Office', assignment_type: 'primary', action: 'ASSIGNED', changed_by: 4, changed_by_name: 'Admin', reason: 'Assigned to Island regional center', created_at: new Date(Date.now() - 30 * 86400000).toISOString() },
    { id: 3, company_id: 1, employee_id: 11, previous_location_id: null, previous_location_name: null, new_location_id: 3, new_location_name: 'Abeokuta Kuto Regional Market', assignment_type: 'primary', action: 'ASSIGNED', changed_by: 4, changed_by_name: 'Admin', reason: 'Assigned to Ogun territory', created_at: new Date(Date.now() - 20 * 86400000).toISOString() }
  ],
  location_logs: [
    {
      id: 255126,
      employee_id: 11,
      employee_name: 'Oke Oluwafolakemi Abosede',
      role: 'SALES_AGENT',
      company_id: 1,
      supervisor_id: 9,
      store_id: 2,
      location_id: 2,
      assigned_market: 'Ibadan Bodija Market',
      assigned_region: 'WEST',
      assigned_state: 'Oyo',
      timestamp: new Date().toISOString(),
      server_timestamp: new Date().toISOString(),
      local_time_lagos: '2026-08-21 08:37:50',
      latitude: 7.3875,
      longitude: 3.8824,
      accuracy: 4.8,
      address: 'Bodija Market Hub, Ibadan, Oyo State',
      current_activity: 'Morning Attendance',
      activity: 'Morning Attendance',
      attendance_type: 'MORNING_ATTENDANCE',
      attendance_id: 1,
      is_inside_geofence: true,
      distance_from_store: 24,
      distance_meters: 24,
      geofence_status: 'Verified',
      status: 'success',
      battery_level: 95
    },
    {
      id: 255125,
      employee_id: 2,
      employee_name: 'Babatunde Lawal',
      role: 'FIELD_AGENT',
      company_id: 1,
      supervisor_id: 9,
      store_id: 1,
      location_id: 1,
      assigned_market: 'Lagos Victoria Island Office',
      assigned_region: 'LAGOS',
      assigned_state: 'Lagos',
      timestamp: new Date(Date.now() - 3600000).toISOString(),
      server_timestamp: new Date(Date.now() - 3600000).toISOString(),
      local_time_lagos: '2026-08-21 08:12:15',
      latitude: 6.4282,
      longitude: 3.4220,
      accuracy: 3.2,
      address: '14B Idowu Martins St, Victoria Island, Lagos',
      current_activity: 'Morning Attendance',
      activity: 'Morning Attendance',
      attendance_type: 'MORNING_ATTENDANCE',
      attendance_id: 2,
      is_inside_geofence: true,
      distance_from_store: 12,
      distance_meters: 12,
      geofence_status: 'Verified',
      status: 'success',
      battery_level: 88
    },
    {
      id: 255124,
      employee_id: 12,
      employee_name: 'Chiamaka Nwosu',
      role: 'FIELD_AGENT',
      company_id: 1,
      supervisor_id: 9,
      store_id: 7,
      location_id: 7,
      assigned_market: 'Enugu Main Market Branch',
      assigned_region: 'EAST',
      assigned_state: 'Enugu',
      timestamp: new Date(Date.now() - 7200000).toISOString(),
      server_timestamp: new Date(Date.now() - 7200000).toISOString(),
      local_time_lagos: '2026-08-21 07:45:00',
      latitude: 6.4475,
      longitude: 7.4985,
      accuracy: 5.0,
      address: 'Market Road, Ogbete, Enugu State',
      current_activity: 'Morning Attendance',
      activity: 'Morning Attendance',
      attendance_type: 'MORNING_ATTENDANCE',
      attendance_id: 3,
      is_inside_geofence: true,
      distance_from_store: 45,
      distance_meters: 45,
      geofence_status: 'Verified',
      status: 'success',
      battery_level: 92
    },
    {
      id: 255123,
      employee_id: 10,
      employee_name: 'Bashiru Aminu',
      role: 'SALES_AGENT',
      company_id: 1,
      supervisor_id: 9,
      store_id: 5,
      location_id: 5,
      assigned_market: 'Kano Dawanau Provisions Depot',
      assigned_region: 'NORTH',
      assigned_state: 'Kano',
      timestamp: new Date(Date.now() - 14400000).toISOString(),
      server_timestamp: new Date(Date.now() - 14400000).toISOString(),
      local_time_lagos: '2026-08-21 07:30:20',
      latitude: 12.0834,
      longitude: 8.4501,
      accuracy: 4.1,
      address: 'Dawanau Wholesale Market Axis, Kano State',
      current_activity: 'Morning Attendance',
      activity: 'Morning Attendance',
      attendance_type: 'MORNING_ATTENDANCE',
      attendance_id: 4,
      is_inside_geofence: true,
      distance_from_store: 30,
      distance_meters: 30,
      geofence_status: 'Verified',
      status: 'success',
      battery_level: 98
    }
  ],
  field_activities: [],
  sales_activities: [],
  location_alerts: [],
  daily_summaries: [],
  leave_balances: [
    { id: 1, employee_id: 1, year: 2026, annual: 18, sick: 12, casual: 5 },
    { id: 2, employee_id: 2, year: 2026, annual: 20, sick: 10, casual: 4 },
    { id: 3, employee_id: 3, year: 2026, annual: 15, sick: 12, casual: 5 },
    { id: 5, employee_id: 5, year: 2026, annual: 25, sick: 15, casual: 5 }
  ],
  leave_requests: [],
  payslips: [],
  okrs: [],
  tasks: [
    {
      id: 1,
      company_id: 1,
      assigned_to: 1,
      assigned_by: 9,
      supervisor_id: 9,
      department_id: 1,
      title: 'Submit Commercial Campaign Performance Deck',
      description: 'Prepare final Q3 reach metrics, retail shelf photos, and engagement report.',
      client_name: 'Carex Nigeria',
      project_name: 'Carex Clean Hands Tour',
      priority: 'high',
      task_type: 'delivery',
      status: 'pending',
      delivery_stages: {
        prepared: true,
        reviewed: true,
        sent_to_client: false,
        client_delivery: false
      },
      due_at: new Date(Date.now() + 2 * 3600000).toISOString(),
      due_date: new Date().toISOString().slice(0, 10),
      acknowledged_at: new Date(Date.now() - 3600000).toISOString(),
      acknowledged_by: 1,
      completed_at: null,
      created_at: new Date(Date.now() - 7200000).toISOString()
    },
    {
      id: 2,
      company_id: 1,
      assigned_to: 2,
      assigned_by: 9,
      supervisor_id: 9,
      department_id: 2,
      title: 'Dispatch Merchandising Audit Proof',
      description: 'Audit shelf positioning across Lekki superstores and deliver photo verification.',
      client_name: 'PZ Cussons',
      project_name: 'BBNaija Brand Activation',
      priority: 'urgent',
      task_type: 'delivery',
      status: 'pending',
      delivery_stages: {
        prepared: true,
        reviewed: false,
        sent_to_client: false,
        client_delivery: false
      },
      due_at: new Date(Date.now() + 45 * 60000).toISOString(),
      due_date: new Date().toISOString().slice(0, 10),
      acknowledged_at: null,
      acknowledged_by: null,
      completed_at: null,
      created_at: new Date(Date.now() - 3600000).toISOString()
    },
    {
      id: 3,
      company_id: 1,
      assigned_to: 1,
      assigned_by: 9,
      supervisor_id: 9,
      department_id: 1,
      title: 'Weekly Key Account Inventory Reconciliation',
      description: 'Cross-check physical pallet stock with ERP orders for Mega Plaza and Ebeano.',
      client_name: 'Internal Operations',
      project_name: 'Operations Audit',
      priority: 'normal',
      task_type: 'general',
      status: 'completed',
      due_at: new Date(Date.now() - 4 * 3600000).toISOString(),
      due_date: new Date().toISOString().slice(0, 10),
      acknowledged_at: new Date(Date.now() - 6 * 3600000).toISOString(),
      acknowledged_by: 1,
      completed_at: new Date(Date.now() - 4.5 * 3600000).toISOString(),
      completion_notes: 'Reconciliation complete. All 238 cartons verified and signed off.',
      created_at: new Date(Date.now() - 8 * 3600000).toISOString()
    }
  ],
  task_reminders: [
    {
      id: 1,
      company_id: 1,
      task_id: 1,
      user_id: 1,
      employee_id: 1,
      reminder_at: new Date(Date.now() + 15 * 60000).toISOString(),
      reminder_level: 'pre_deadline',
      channels: ['in_app', 'email', 'whatsapp', 'push'],
      status: 'scheduled',
      attempts: 0,
      idempotency_key: 'REM-1-pre_deadline-1',
      created_at: new Date().toISOString()
    },
    {
      id: 2,
      company_id: 1,
      task_id: 2,
      user_id: 2,
      employee_id: 2,
      reminder_at: new Date(Date.now() + 5 * 60000).toISOString(),
      reminder_level: 'pre_deadline',
      channels: ['in_app', 'email', 'whatsapp', 'push'],
      status: 'scheduled',
      attempts: 0,
      idempotency_key: 'REM-2-pre_deadline-2',
      created_at: new Date().toISOString()
    }
  ],
  task_reminder_rules: [
    { id: 1, company_id: 1, trigger_condition: 'OVERDUE_15M', notify_roles: ['SUPERVISOR'], channels: ['in_app', 'email'] },
    { id: 2, company_id: 1, trigger_condition: 'OVERDUE_60M', notify_roles: ['SUPERVISOR', 'HR'], channels: ['in_app', 'email', 'whatsapp'] }
  ],
  reminder_delivery_logs: [
    {
      id: 1,
      company_id: 1,
      reminder_id: 1,
      task_id: 1,
      user_id: 1,
      channel: 'in_app',
      status: 'sent',
      sent_at: new Date(Date.now() - 3600000).toISOString(),
      created_at: new Date(Date.now() - 3600000).toISOString()
    },
    {
      id: 2,
      company_id: 1,
      reminder_id: 1,
      task_id: 1,
      user_id: 1,
      channel: 'email',
      status: 'sent',
      provider_message_id: 'MSG-EML-98124',
      sent_at: new Date(Date.now() - 3600000).toISOString(),
      created_at: new Date(Date.now() - 3600000).toISOString()
    }
  ],
  employee_idle_sessions: [
    {
      id: 1,
      company_id: 1,
      employee_id: 1,
      user_id: 1,
      idle_started_at: new Date(Date.now() - 7200000).toISOString(),
      detected_at: new Date(Date.now() - 6600000).toISOString(),
      duration_seconds: 600,
      reason: 'Physical Meeting',
      reason_details: 'Attending client presentation review with Senior Commercial Director',
      status: 'explained',
      reported_to_it_at: new Date(Date.now() - 6600000).toISOString(),
      reported_to_hr_at: new Date(Date.now() - 6600000).toISOString(),
      created_at: new Date(Date.now() - 6600000).toISOString()
    }
  ],
  escalation_rules: [
    { id: 1, company_id: 1, trigger_condition: 'OVERDUE_15M', notify_roles: ['SUPERVISOR'], channels: ['in_app', 'email'] },
    { id: 2, company_id: 1, trigger_condition: 'OVERDUE_60M', notify_roles: ['SUPERVISOR', 'HR'], channels: ['in_app', 'email', 'whatsapp'] }
  ],
  announcements: [
    { id: 1, title: 'EdgeWForce Enterprise Platform Active', body: 'The complete Operating System for Field Sales & Workforce Operations is now live for (c) Nexfeild 2026', audience: 'Everyone', priority: 'High', start_date: new Date().toISOString().slice(0, 10), created_at: new Date().toISOString() }
  ],
  holidays: [
    { id: 1, name: "New Year's Day", date: '2026-01-01', description: 'Public Holiday', year: 2026 },
    { id: 2, name: "Workers' Day", date: '2026-05-01', description: 'International Workers Day', year: 2026 },
    { id: 3, name: "Democracy Day", date: '2026-06-12', description: 'Democracy Day', year: 2026 },
    { id: 4, name: "Independence Day", date: '2026-10-01', description: 'National Independence Day', year: 2026 },
    { id: 5, name: "Christmas Day", date: '2026-12-25', description: 'Christmas Day', year: 2026 },
    { id: 6, name: "Boxing Day", date: '2026-12-26', description: 'Boxing Day', year: 2026 }
  ],
  settlements: [],
  sos: [],
  idle_alerts: [],
  push_subscriptions: [],
  notifications: [
    { id: 1, employee_id: 1, type: 'Sales', title: 'Commission Updated', body: 'Take-Home Sales Commission is calculated at 5% for all closed orders.', read: false, created_at: new Date().toISOString() },
    { id: 2, employee_id: 2, type: 'Field', title: 'Route Manifest Ready', body: 'You have 4 store audit stops assigned for today.', read: false, created_at: new Date().toISOString() }
  ],
  face_events: []
};

// Initialize or load local store
let store = JSON.parse(JSON.stringify(initialSeed));

function loadPersistedStore() {
  try {
    if (fs.existsSync(storePath)) {
      const data = fs.readFileSync(storePath, 'utf8');
      const loaded = JSON.parse(data);
      store = { ...initialSeed, ...loaded };
      store.companies = initialSeed.companies;
      store.company_settings = initialSeed.company_settings;
      store.regions = initialSeed.regions;
      store.territories = initialSeed.territories;
      store.teams = initialSeed.teams;
      store.branches = initialSeed.branches;
      store.warehouses = initialSeed.warehouses;
      store.users = initialSeed.users;
      store.employees = initialSeed.employees;
      store.customers = loaded.customers && loaded.customers.length >= 50 ? loaded.customers : initialSeed.customers;
      store.products = loaded.products && loaded.products.length >= 20 ? loaded.products : initialSeed.products;
      store.orders = loaded.orders && loaded.orders.length ? loaded.orders : initialSeed.orders;
      store.order_items = loaded.order_items && loaded.order_items.length ? loaded.order_items : initialSeed.order_items;
      store.order_approvals = loaded.order_approvals && loaded.order_approvals.length ? loaded.order_approvals : initialSeed.order_approvals;
      store.deliveries = loaded.deliveries && loaded.deliveries.length ? loaded.deliveries : initialSeed.deliveries;
      store.inventory_movements = loaded.inventory_movements && loaded.inventory_movements.length ? loaded.inventory_movements : initialSeed.inventory_movements;
      store.collections = loaded.collections && loaded.collections.length ? loaded.collections : initialSeed.collections;
      store.visits = loaded.visits && loaded.visits.length ? loaded.visits : initialSeed.visits;
      store.visit_reports = loaded.visit_reports && loaded.visit_reports.length ? loaded.visit_reports : initialSeed.visit_reports;
      store.attendance = loaded.attendance && loaded.attendance.length ? loaded.attendance : initialSeed.attendance;
      store.alerts = loaded.alerts && loaded.alerts.length ? loaded.alerts : initialSeed.alerts;
      store.performance_scores = loaded.performance_scores && loaded.performance_scores.length ? loaded.performance_scores : initialSeed.performance_scores;
      store.audit_logs = loaded.audit_logs && loaded.audit_logs.length ? loaded.audit_logs : initialSeed.audit_logs;
      store.stores = loaded.stores && loaded.stores.length ? loaded.stores : initialSeed.stores;
      store.work_locations = loaded.work_locations && loaded.work_locations.length ? loaded.work_locations : initialSeed.work_locations;
      store.employee_location_assignments = loaded.employee_location_assignments && loaded.employee_location_assignments.length ? loaded.employee_location_assignments : initialSeed.employee_location_assignments;
      store.location_assignment_history = loaded.location_assignment_history && loaded.location_assignment_history.length ? loaded.location_assignment_history : initialSeed.location_assignment_history;
    } else {
      savePersistedStore();
    }
  } catch (err) {
    logger.error('Failed to load local store file, resetting to seed', err);
    store = JSON.parse(JSON.stringify(initialSeed));
  }
}


let saveTimeout = null;

function savePersistedStore() {
  if (saveTimeout) clearTimeout(saveTimeout);
  saveTimeout = setTimeout(() => {
    try {
      fs.writeFile(storePath, JSON.stringify(store, null, 2), 'utf8', (err) => {
        if (err) logger.error('Failed to persist store to disk asynchronously', err);
      });
    } catch (err) {
      logger.error('Failed to schedule store persistence', err);
    }
  }, 100);
}

loadPersistedStore();

// Helper to race promise against a timeout
function fetchWithTimeout(promise, ms = 450) {
  let timeoutId;
  const timeoutPromise = new Promise((_, reject) => {
    timeoutId = setTimeout(() => reject(new Error('SUPABASE_TIMEOUT')), ms);
  });
  return Promise.race([promise, timeoutPromise]).finally(() => clearTimeout(timeoutId));
}

// Canonical Table Name Mapper
function resolveCanonicalTable(table) {
  const map = {
    visits: 'field_visits',
    orders: 'sales',
    order_items: 'sale_items',
    alerts: 'idle_alerts'
  };
  return map[table] || table;
}

export const db = {
  resetToSeed() {
    store = JSON.parse(JSON.stringify(initialSeed));
    savePersistedStore();
    return true;
  },

  async find(table, filter = {}, options = {}) {
    const canonicalTable = resolveCanonicalTable(table);

    if (supabase && process.env.NODE_ENV !== 'test') {
      try {
        let q = supabase.from(canonicalTable).select(options.select || '*');
        for (const [k, v] of Object.entries(filter)) {
          if (v !== undefined && v !== null) {
            // Alias resolution for attendance filters
            const mappedKey = (canonicalTable === 'attendance' && k === 'date') ? 'attendance_date' : k;
            q = q.eq(mappedKey, v);
          }
        }
        if (options.order) q = q.order(options.order.column, { ascending: options.order.ascending !== false });
        if (options.limit) q = q.limit(options.limit);
        
        const { data, error } = await fetchWithTimeout(q, 450);
        if (!error && data && data.length > 0) {
          return data.map(item => {
            // Normalize attendance fields for backwards compatibility
            if (canonicalTable === 'attendance') {
              return {
                ...item,
                date: item.attendance_date || item.date,
                clock_in_time: item.clock_in || item.clock_in_time,
                clock_out_time: item.clock_out || item.clock_out_time,
                clock_in_lat: item.clock_in_latitude ?? item.clock_in_lat,
                clock_in_lng: item.clock_in_longitude ?? item.clock_in_lng,
                clock_out_lat: item.clock_out_latitude ?? item.clock_out_lat,
                clock_out_lng: item.clock_out_longitude ?? item.clock_out_lng
              };
            }
            return item;
          });
        }
      } catch (err) {
        // Fast instant fallback to local store without blocking
      }
    }

    const targetList = store[canonicalTable] || store[table] || [];
    let items = targetList.filter(item => {
      return Object.entries(filter).every(([k, v]) => {
        if (v === undefined || v === null) return true;
        const itemVal = item[k] !== undefined ? item[k] : (k === 'date' ? item.attendance_date : (k === 'attendance_date' ? item.date : undefined));
        return String(itemVal) === String(v);
      });
    });

    if (options.order) {
      const col = options.order.column;
      const asc = options.order.ascending !== false;
      items.sort((a, b) => {
        const valA = a[col] ?? '';
        const valB = b[col] ?? '';
        if (typeof valA === 'number' && typeof valB === 'number') {
          return asc ? valA - valB : valB - valA;
        }
        return asc ? String(valA).localeCompare(String(valB)) : String(valB).localeCompare(String(valA));
      });
    }

    if (options.limit) {
      items = items.slice(0, options.limit);
    }

    return JSON.parse(JSON.stringify(items));
  },

  async findOne(table, filter = {}) {
    const list = await this.find(table, filter, { limit: 1 });
    return list[0] || null;
  },

  async findById(table, id) {
    return this.findOne(table, { id });
  },

  async insert(table, record) {
    const canonicalTable = resolveCanonicalTable(table);

    // Normalize canonical attendance columns
    const normalized = { ...record };
    if (canonicalTable === 'attendance') {
      if (normalized.date && !normalized.attendance_date) normalized.attendance_date = normalized.date;
      if (normalized.clock_in_time && !normalized.clock_in) normalized.clock_in = normalized.clock_in_time;
      if (normalized.clock_out_time && !normalized.clock_out) normalized.clock_out = normalized.clock_out_time;
      if (normalized.clock_in_lat && !normalized.clock_in_latitude) normalized.clock_in_latitude = normalized.clock_in_lat;
      if (normalized.clock_in_lng && !normalized.clock_in_longitude) normalized.clock_in_longitude = normalized.clock_in_lng;
      if (normalized.clock_out_lat && !normalized.clock_out_latitude) normalized.clock_out_latitude = normalized.clock_out_lat;
      if (normalized.clock_out_lng && !normalized.clock_out_longitude) normalized.clock_out_longitude = normalized.clock_out_lng;
    }

    if (supabase) {
      try {
        const { data, error } = await supabase.from(canonicalTable).insert(normalized).select().single();
        if (!error && data) return data;
      } catch (err) {
        logger.warn(`Supabase insert for ${canonicalTable} failed, using local store: ${err.message}`);
      }
    }

    if (!store[canonicalTable]) store[canonicalTable] = [];
    const maxId = store[canonicalTable].reduce((max, r) => Math.max(max, Number(r.id) || 0), 0);
    const newRecord = {
      id: record.id || maxId + 1,
      created_at: new Date().toISOString(),
      ...normalized
    };

    store[canonicalTable].push(newRecord);
    savePersistedStore();
    return JSON.parse(JSON.stringify(newRecord));
  },

  async update(table, id, updates) {
    const canonicalTable = resolveCanonicalTable(table);

    // Normalize canonical attendance columns
    const normalized = { ...updates };
    if (canonicalTable === 'attendance') {
      if (normalized.date && !normalized.attendance_date) normalized.attendance_date = normalized.date;
      if (normalized.clock_in_time && !normalized.clock_in) normalized.clock_in = normalized.clock_in_time;
      if (normalized.clock_out_time && !normalized.clock_out) normalized.clock_out = normalized.clock_out_time;
      if (normalized.clock_in_lat && !normalized.clock_in_latitude) normalized.clock_in_latitude = normalized.clock_in_lat;
      if (normalized.clock_in_lng && !normalized.clock_in_longitude) normalized.clock_in_longitude = normalized.clock_in_lng;
      if (normalized.clock_out_lat && !normalized.clock_out_latitude) normalized.clock_out_latitude = normalized.clock_out_lat;
      if (normalized.clock_out_lng && !normalized.clock_out_longitude) normalized.clock_out_longitude = normalized.clock_out_lng;
    }

    if (supabase) {
      try {
        const { data, error } = await supabase.from(canonicalTable).update(normalized).eq('id', id).select().single();
        if (!error && data) return data;
      } catch (err) {
        logger.warn(`Supabase update for ${canonicalTable} failed, using local store: ${err.message}`);
      }
    }

    const targetTable = store[canonicalTable] ? canonicalTable : table;
    if (!store[targetTable]) store[targetTable] = [];
    const index = store[targetTable].findIndex(r => String(r.id) === String(id));
    if (index === -1) {
      // If not found in primary store, try fallback
      return null;
    }

    store[targetTable][index] = {
      ...store[targetTable][index],
      ...normalized,
      updated_at: new Date().toISOString()
    };

    savePersistedStore();
    return JSON.parse(JSON.stringify(store[targetTable][index]));
  },

  async delete(table, id) {
    const canonicalTable = resolveCanonicalTable(table);

    if (supabase) {
      try {
        await supabase.from(canonicalTable).delete().eq('id', id);
      } catch (err) {
        logger.warn(`Supabase delete for ${canonicalTable} failed: ${err.message}`);
      }
    }

    const targetTable = store[canonicalTable] ? canonicalTable : table;
    if (!store[targetTable]) return false;
    const initialLen = store[targetTable].length;
    store[targetTable] = store[targetTable].filter(r => String(r.id) !== String(id));
    const deleted = store[targetTable].length < initialLen;
    if (deleted) savePersistedStore();
    return deleted;
  },

  /**
   * Executes an atomic transaction callback with safe rollback capability.
   */
  async transaction(callback) {
    const snapshot = JSON.stringify(store);
    try {
      const result = await callback(this);
      savePersistedStore();
      return result;
    } catch (error) {
      store = JSON.parse(snapshot);
      savePersistedStore();
      throw error;
    }
  }
};
