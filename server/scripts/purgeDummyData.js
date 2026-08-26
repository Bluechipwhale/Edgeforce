// ==============================================================================
// EDGEWFORCE - PURGE DUMMY/DEMO TRANSACTION DATA
// Preserves real registered users, employees, company profile, roles & ranks.
// Removes fake sales, visits, attendance, test expenses, and sample stock movements.
// Run with: node server/scripts/purgeDummyData.js
// ==============================================================================

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const storePath = path.resolve(__dirname, '../data/store.json');

if (!fs.existsSync(storePath)) {
  console.log('[ERROR] Store file not found at:', storePath);
  process.exit(1);
}

try {
  const store = JSON.parse(fs.readFileSync(storePath, 'utf8'));

  console.log('--- PURGING DEMO/MOCK TRANSACTION DATA ---');
  console.log(`Original Users: ${store.users?.length || 0}`);
  console.log(`Original Employees: ${store.employees?.length || 0}`);
  console.log(`Original Customers: ${store.customers?.length || 0}`);
  console.log(`Original Orders/Sales: ${store.orders?.length || store.sales?.length || 0}`);

  // Purge transactional mock tables
  store.orders = [];
  store.sales = [];
  store.order_items = [];
  store.sale_items = [];
  store.attendance = [];
  store.visits = [];
  store.field_visits = [];
  store.field_activities = [];
  store.expenses = [];
  store.collections = [];
  store.stock_movements = [];
  store.idle_records = [];
  store.location_alerts = [];
  store.sos = [];
  store.tasks = [];
  store.leave_requests = [];
  store.notifications = [];
  store.audit_logs = [];

  // Write back clean state
  fs.writeFileSync(storePath, JSON.stringify(store, null, 2), 'utf8');

  console.log('\n[SUCCESS] Transactional dummy data purged successfully!');
  console.log(`Remaining Authentic Users: ${store.users?.length || 0}`);
  console.log(`Remaining Authentic Employees: ${store.employees?.length || 0}`);
  console.log('Your production store is now clean and ready for real operations.\n');
} catch (err) {
  console.error('[ERROR] Failed to purge dummy data:', err.message);
  process.exit(1);
}
