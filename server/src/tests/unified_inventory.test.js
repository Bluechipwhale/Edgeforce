// ==============================================================================
// EDGEWFORCE - CONSOLIDATED PHYSICAL INVENTORY TEST SUITE
// Tests Seeding across 10 Location Sheets, Smart Search, Filtering, Idempotency & Role Access
// ==============================================================================

import test from 'node:test';
import assert from 'node:assert/strict';
import { inventoryService } from '../services/inventoryService.js';
import { PHYSICAL_INVENTORY_LOCATIONS } from '../data/inventoryData.js';
import { db } from '../config/database.js';

test('Unified Physical Inventory Dataset & Smart Search Engine', async (t) => {
  const companyId = 1;

  await t.test('1. Idempotent Seeding loads all 10 physical location datasets', async () => {
    await inventoryService.seedConsolidatedInventory(companyId);
    const products = await inventoryService.getProducts(companyId);

    assert.ok(products.length >= 350, `Expected at least 350 products, got ${products.length}`);

    // Verify all 10 locations exist in the loaded dataset
    const foundLocations = new Set(products.map(p => p.location_of_item || p.warehouse_name));
    for (const loc of PHYSICAL_INVENTORY_LOCATIONS) {
      assert.ok(foundLocations.has(loc), `Location "${loc}" must be present in consolidated dataset`);
    }
  });

  await t.test('2. Multiple seed calls do not create duplicate records (Idempotency)', async () => {
    const countBefore = (await inventoryService.getProducts(companyId)).length;

    // Call seed again 2 more times
    await inventoryService.seedConsolidatedInventory(companyId);
    await inventoryService.seedConsolidatedInventory(companyId);

    const countAfter = (await inventoryService.getProducts(companyId)).length;
    assert.equal(countAfter, countBefore, 'Inventory record count must remain constant after repeated seedings');
  });

  await t.test('3. Exact quantities and conditions are preserved verbatim', async () => {
    const products = await inventoryService.getProducts(companyId);

    // Test specific items with unique quantity formats
    const ironGate = products.find(p => p.name === 'Iron Gate' && p.location_of_item === 'Diamond Estate');
    assert.ok(ironGate, 'Iron Gate at Diamond Estate must exist');
    assert.equal(ironGate.quantity_display, '1 PAIR');

    const waterPumpSac = products.find(p => p.name === 'Sac with water pump');
    assert.ok(waterPumpSac, 'Sac with water pump must exist');
    assert.equal(waterPumpSac.quantity_display, '4 pumps');

    const spoonPacks = products.find(p => p.name === 'Spoon' && p.location_of_item === 'Maryland Office Side');
    assert.ok(spoonPacks, 'Spoon packs must exist');
    assert.equal(spoonPacks.quantity_display, '28 packs');

    const premierBoxes = products.find(p => p.name === 'premiere cool box');
    assert.ok(premierBoxes, 'premiere cool box must exist');
    assert.equal(premierBoxes.condition, '5 damaged');
  });

  await t.test('4. Location filtering accurately isolates items for each of the 10 locations', async () => {
    for (const loc of PHYSICAL_INVENTORY_LOCATIONS) {
      const items = await inventoryService.getProducts(companyId, { location: loc });
      assert.ok(items.length > 0, `Location "${loc}" must return items`);
      for (const item of items) {
        const itemLoc = item.location_of_item || item.warehouse_name;
        assert.equal(itemLoc, loc, `Item "${item.name}" must belong to location "${loc}"`);
      }
    }
  });

  await t.test('5. Smart Search finds items by name, shelf code, location and condition', async () => {
    // Search by item keyword
    const chairSearch = await inventoryService.getProducts(companyId, { search: 'Chair' });
    assert.ok(chairSearch.length > 0, 'Searching for "Chair" must return matching items');

    // Search by shelf number
    const shelfSearch = await inventoryService.getProducts(companyId, { search: 'eestr001' });
    assert.ok(shelfSearch.length > 0, 'Searching for "eestr001" must find items on shelf 1');

    // Search by condition
    const damageSearch = await inventoryService.getProducts(companyId, { search: 'damaged' });
    assert.ok(damageSearch.length > 0, 'Searching for "damaged" must find items with damaged condition');

    // Search by location
    const diamondSearch = await inventoryService.getProducts(companyId, { search: 'Diamond Estate' });
    assert.ok(diamondSearch.length >= 13, 'Searching for "Diamond Estate" must return diamond estate items');
  });

  await t.test('6. Summary metrics calculate accurate catalog statistics', async () => {
    const summary = await inventoryService.getInventorySummary(companyId);
    assert.ok(summary.totalSKUs >= 350, 'Total SKUs must match consolidated inventory');
    assert.ok(summary.totalQuantity > 0, 'Total Quantity must be calculated');
  });
});
