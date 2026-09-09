-- ==============================================================================
-- EDGEWFORCE - PHYSICAL INVENTORY DATABASE SCHEMA & DATA MIGRATION
-- Run this SQL in your Supabase SQL Editor to update the database schema and insert all 10 location items
-- ==============================================================================

-- 1. Ensure columns exist on products table
ALTER TABLE IF EXISTS products 
  ADD COLUMN IF NOT EXISTS location_of_item VARCHAR(255) DEFAULT 'Warehouse Shelves',
  ADD COLUMN IF NOT EXISTS shelf_number VARCHAR(100) DEFAULT '—',
  ADD COLUMN IF NOT EXISTS condition VARCHAR(100) DEFAULT '—',
  ADD COLUMN IF NOT EXISTS quantity_display VARCHAR(100) DEFAULT '1';

-- 2. Create index on location_of_item, shelf_number, and category for blazing-fast search
CREATE INDEX IF NOT EXISTS idx_products_location ON products(company_id, location_of_item);
CREATE INDEX IF NOT EXISTS idx_products_shelf ON products(company_id, shelf_number);
CREATE INDEX IF NOT EXISTS idx_products_condition ON products(company_id, condition);

-- 3. Upsert / Insert Consolidated Physical Inventory Records
INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-001', 'Kenstar brown carton filled with light equipments', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr001', 'eestr001', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-002', 'Sac filled with pots and covers', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr002', 'eestr002', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-003', 'white banner sheeet', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr002', 'eestr002', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-004', 'Metal grinding sheet', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr002', 'eestr002', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-005', 'Black rope', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr002', 'eestr002', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-006', 'Extension cable reel', 'Electrical & Lighting', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr003', 'eestr003', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-007', 'Metal grinding sheet', 'Hardware & Equipment', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr003', 'eestr003', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-008', 'Sac with water pump', 'Storage & Packaging', 'pcs', 0, 0, 
  4, '4 pumps', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr003', 'eestr003', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-009', 'Half engine', 'Automotive & Logistics', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr004', 'eestr004', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-010', 'Open screw box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr004', 'eestr004', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-011', 'Black Sac filled with parts', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr004', 'eestr004', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-012', 'square green woods', 'Carpentry & Props', 'pcs', 0, 0, 
  12, '12', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr006', 'eestr006', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-013', 'rectangular wood', 'Carpentry & Props', 'pcs', 0, 0, 
  7, '7', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr006', 'eestr006', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-014', 'Priemier cool shield boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  7, '7', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr006', 'eestr006', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-015', 'Black pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr006', 'eestr006', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-016', 'High tension cables red & blue', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr006', 'eestr006', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-017', 'Frypans', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-018', 'Open welding electrodes box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1 box', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-019', 'red gazebo cover cloth', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-020', 'Electrical Meter box', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-021', 'Golden rods', 'Hardware & Equipment', 'pcs', 0, 0, 
  11, '11', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr002', 'eestr002', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-022', 'White pillows cases Veleta', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-023', 'Veleta Black plastic cup bowls', 'Catering & Kitchen', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-024', 'Paint roller brush', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr007', 'eestr007', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-025', 'mamador banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-026', 'Dangote sac filled with white wood veleta', 'Carpentry & Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-027', 'trade convention', 'Marketing & Branding Props', 'pcs', 0, 0, 
  9, '9', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-028', 'Gloss paint small container', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-029', '2 brown box filled filled with black base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6 pieces each', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-030', '1 open brown box filled with black base with a funnel', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr008', 'eestr008', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-031', 'vechile tyre with two small with box in it', 'Automotive & Logistics', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr009', 'eestr009', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-032', 'Brown boxes filled with golden rods and bases', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr010', 'eestr010', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-033', 'Black plastic container', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr010', 'eestr010', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-034', 'Golden rods in bubble wraps', 'Hardware & Equipment', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-035', 'feather banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-036', 'White bag filled with veleta gele', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr011', 'eestr011', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-037', 'veleta rug', 'Flooring & Carpets', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr011', 'eestr011', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-038', 'Veleta banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr011', 'eestr011', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-039', 'Wooden design wrap mat', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr009', 'eestr009', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-040', 'flat light bar', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr011', 'eestr011', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-041', 'silver flat metal', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr011', 'eestr011', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-042', 'water fan', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr012', 'eestr012', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-043', 'Brown boxes filled with black bases', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr012', 'eestr012', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-044', 'vechile headlights', 'Electrical & Lighting', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr013', 'eestr013', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-045', 'Pepsi Gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr013', 'eestr013', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-046', 'pot with glass', 'Catering & Kitchen', 'pcs', 0, 0, 
  7, '7', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr014', 'eestr014', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-047', 'golden iron', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr014', 'eestr014', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-048', 'baby colorful fence wall', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr014', 'eestr014', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-049', 'White baby fence box carton', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr014', 'eestr014', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-050', 'Brown box filled with golden metal rods', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr014', 'eestr014', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-051', 'Celotaped Brown box', 'Storage & Packaging', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr015', 'eestr015', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-052', 'Golden pole', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  '—', 'eestr015', 'eestr015', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-053', 'Shower rods', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  7, '7', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr015', 'eestr015', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-054', 'golden base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  14, '14 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-055', 'decoration cloth', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-056', 'flat golden base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-057', 'cone shape golden base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  8, '8', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-058', 'Gloss paint small container', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-059', 'Black Sac filled with base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-060', 'Checked sac filled with cloth', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-061', 'Dangoted sac filled to half with nails', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr016', 'eestr016', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-062', 'golden stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2 set', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr017', 'eestr017', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-063', 'Golden base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  9, '9', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr017', 'eestr017', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-064', 'Brown box filled with golden metal base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr017', 'eestr017', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-065', 'Prize check', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr017', 'eestr017', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-066', 'Spraying machine', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr018', 'eestr018', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-067', 'plastic roof', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  4, '4 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr018', 'eestr018', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-068', 'Christmas tree', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr018', 'eestr018', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-069', 'Open brown box filled with base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr018', 'eestr018', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-070', 'ariston gazebo', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-071', 'red gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-072', 'Plastic chair cones', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-073', 'Sac filled with pump equipments', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-074', 'Christmas Decorations', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-075', 'Metal rod &Shower rod', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-076', 'Roll of sanding paper', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-077', 'Open box filled with pipe & blumbing stuff', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr019', 'eestr019', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-078', 'plastic seating stool base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  23, '23 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr020', 'eestr020', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-079', 'plastic seating stool top', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr020', 'eestr020', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-080', 'Plastic chair cones', 'Activation Props & Furniture', 'pcs', 0, 0, 
  24, '24', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr020', 'eestr020', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-081', 'Plastic chair cones cover', 'Activation Props & Furniture', 'pcs', 0, 0, 
  7, '7', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr020', 'eestr020', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-082', 'Plastic black base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr021', 'eestr021', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-083', 'Cooler cover', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr021', 'eestr021', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-084', 'Black sac filled with carex cap', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr021', 'eestr021', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-085', 'christmas decorations', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr022', 'eestr022', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-086', 'christmas decorations', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr022', 'eestr022', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-087', 'sack full of carex Bthing glove', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr023', 'eestr023', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-088', 'stage light', 'Electrical & Lighting', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'unknown', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-089', 'cecamix white cement', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-090', 'stage extension', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'unknown', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-091', 'water seal white', 'Paints & Construction', 'pcs', 0, 0, 
  5, '5 pieces', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-092', 'electrical items (general)', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-093', 'plug-in meters', 'Electrical & Lighting', 'pcs', 0, 0, 
  4, '4 pairs', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-094', 'adhesive', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr024', 'eestr024', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-095', 'sam paper', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-096', 'gloss paint small container', 'Paints & Construction', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'unknown', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-097', 'vstar', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-098', 'platerack', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-099', 'carex bathing gloves', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1 bag', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-100', 'wash hand basin stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-101', 'keg', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-102', 'pop screeding bucket', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-103', 'tiny paint bucket', 'Paints & Construction', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr025', 'eestr025', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-104', 'value plus satin 20l', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'unknown', 'eestr026', 'eestr026', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-105', 'vstar', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr026', 'eestr026', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-106', 'vstar', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'notgood', 'eestr026', 'eestr026', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-107', 'wash hand basin stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr026', 'eestr026', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-108', 'paint bucket', 'Paints & Construction', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr026', 'eestr026', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-109', 'Dangote sac filled with white wood', 'Carpentry & Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-110', 'stand with 2 sure long banner', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr027', 'eestr027', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-111', 'Mousuf box filled with carex body vest in a sac', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr027', 'eestr027', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-112', 'big fan', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr027', 'eestr027', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-113', 'black travelling box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr027', 'eestr027', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-114', 'Torn sac filled with light & electrical components', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr027', 'eestr027', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-115', 'mamador gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-116', 'black table cover', 'Activation Props & Furniture', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-117', 'white table cover', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-118', 'premiere cool stay confident jacket', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1 bag', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-119', 'ghana-must-go bag (full)', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-120', 'sac of mamador cloth', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-121', 'sac of silver rods and rolled metal strip', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-122', 'tied check-pattern sac', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-123', 'sac of mamador funnel and rolled cable', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr028', 'eestr028', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-124', 'bag full of yellow sieve', 'Catering & Kitchen', 'pcs', 0, 0, 
  6, '6', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr029', 'eestr029', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-125', 'bag half full yellow seive', 'Storage & Packaging', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr029', 'eestr029', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-126', 'bag full of yellow sieve', 'Catering & Kitchen', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr030', 'eestr030', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-127', 'Box filled with ceiling lights', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr030', 'eestr030', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-128', 'Box full of cutlery', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr031', 'eestr031', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-129', 'premiere cool box', 'Storage & Packaging', 'pcs', 0, 0, 
  8, '8', 'Warehouse Shelves', 'Warehouse Shelves', 
  '5 damaged', 'eestr031', 'eestr031', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-130', 'green metal sheets in brown carton', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr031', 'eestr031', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-131', 'microwave box filled with premeir cool white plastic box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr031', 'eestr031', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-132', 'Bag full of cutlery', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-133', 'kitchen bag of spoons', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-134', 'handheld turning machine', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-135', 'Stella cloth and equipments in baco bag', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-136', 'electrical cables', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-137', 'paint-sized bucket', 'Paints & Construction', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-138', 'keg', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr032', 'eestr032', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-139', 'bag full of yellow sieve', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr033', 'eestr033', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-140', 'half bag of yellow sieve', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr033', 'eestr033', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-141', 'bag of mamador spoons and cartons', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr033', 'eestr033', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-142', 'black bucket filled with carex books', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr033', 'eestr033', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-143', 'bag full of yellow sieve', 'Catering & Kitchen', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr034', 'eestr034', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-144', 'bags of mamador o-spoon', 'Catering & Kitchen', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr034', 'eestr034', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-145', 'bags of yellow sieve spoons', 'Catering & Kitchen', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr034', 'eestr034', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-146', 'nino leuten light holder', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'one cup damaged', 'eestr035', 'eestr035', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-147', 'Big green industrial fans', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr035', 'eestr035', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-148', 'black bucket', 'Storage & Packaging', 'pcs', 0, 0, 
  54, '54', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-149', 'purple plastic bow', 'Hardware & Equipment', 'pcs', 0, 0, 
  23, '23', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-150', 'bow / plastic bows', 'Hardware & Equipment', 'pcs', 0, 0, 
  6, '6', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-151', 'big pot', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-152', 'saw', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'not good', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-153', 'plastic bucket', 'Storage & Packaging', 'pcs', 0, 0, 
  48, '48', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-154', 'sac full of carex books', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-155', 'bowls', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-156', 'pots', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-157', 'Stella cloth and equipments in baco bag', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-158', 'buckets', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-159', 'notebooks', 'Stationery & Print Materials', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr036', 'eestr036', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-160', 'bag of small white plastic', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr037', 'eestr037', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-161', 'carex handheld boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr037', 'eestr037', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-162', 'cover', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr037', 'eestr037', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-163', 'sieve mamador yellow', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1 bag', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr038', 'eestr038', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-164', 'white bag (sumitoto) of yellow handle sieves', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr038', 'eestr038', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-165', 'white nylon of yellow sieved spoons', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr038', 'eestr038', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-166', 'bags of sieved spoons', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr038', 'eestr038', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-167', 'Christmas decorations', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr039', 'eestr039', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-168', 'Metal racks', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr040', 'eestr040', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-169', 'Grey sac filled local sponge threads', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr040', 'eestr040', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-170', 'cooking spoons', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2 cartons', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr041', 'eestr041', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-171', 'Mamador gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr042', 'eestr042', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-172', 'gazebo stand (foldable)', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr042', 'eestr042', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-173', 'white rods', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr042', 'eestr042', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-174', 'White Gazebo stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr042 and 047', 'eestr042 and 047', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-175', 'Gazebo stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr043', 'eestr043', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-176', 'Red picnic table and chairs case', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Eestr043', 'Eestr043', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-177', 'mat (grey color)', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr043', 'eestr043', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-178', 'set-up equipment & collapsable stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr043', 'eestr043', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-179', 'wooden 2sure soap / 2sure mockup', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr044', 'eestr044', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-180', 'plastic perfecct proposal', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr044', 'eestr044', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-181', 'morning resh display stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr044', 'eestr044', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-182', 'wooden 2sure soap mascot', 'Carpentry & Props', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr044', 'eestr044', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-183', 'Display stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr044', 'eestr044', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-184', 'hand wash ceramics for toilet', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr045', 'eestr045', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-185', 'jameson plastic cup', 'Catering & Kitchen', 'pcs', 0, 0, 
  3, '3rolls', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr045', 'eestr045', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-186', 'ceramic bowls', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr045', 'eestr045', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-187', 'hand wash ceramics for toilet / ceramic bowls', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr046', 'eestr046', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-188', '2sure Gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr046', 'eestr046', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-189', 'Pepsi Gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr046', 'eestr046', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-190', 'Black banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr046', 'eestr046', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-191', 'gazebo covers', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr046', 'eestr046', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-192', 'Flag pole set', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr047', 'eestr047', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-193', 'gazebo stand (foldable)', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr047', 'eestr047', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-194', 'big seatable pillow / 2sure pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr050', 'eestr050', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-195', 'small seatable pillow / throw pillows', 'Activation Props & Furniture', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr051', 'eestr051', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-196', 'Jameson throw pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr051', 'eestr051', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-197', '2sure pillow (additional)', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr051', 'eestr051', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-198', 'big seatable pillow / premier cool bar shaped pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr052', 'eestr052', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-199', 'big seatable pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr053', 'eestr053', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-200', 'Jameson throw pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr053', 'eestr053', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-201', 'Roll up banner silver color', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Eestr053', 'Eestr053', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-202', 'Flag pole', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr053', 'eestr053', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-203', 'premiere cool gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  4, '4', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr054', 'eestr054', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-204', 'gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr054', 'eestr054', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-205', 'gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr055', 'eestr055', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-206', 'big gazebo', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr056', 'eestr056', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-207', 'gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr056', 'eestr056', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-208', 'gazebo stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr057', 'eestr057', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-209', 'cushion baby toy', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr057', 'eestr057', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-210', 'Green atroturf', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr059', 'eestr059', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-211', 'red atroturf', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr059', 'eestr059', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-212', 'green atroturf', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'eestr059', 'eestr059', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-213', 'Astroturf green', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr059', 'eestr059', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-214', 'wires', 'Electrical & Lighting', 'pcs', 0, 0, 
  6, '6', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr061', 'eestr061', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-215', 'lights', 'Electrical & Lighting', 'pcs', 0, 0, 
  5, '5', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'eestr061', 'eestr061', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-216', 'Rendiel', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 069', 'Eestr066 to 069', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-217', 'Christmas tree 8 inches', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 070', 'Eestr066 to 070', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-218', 'Christmas tree 10 inches', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 071', 'Eestr066 to 071', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-219', 'Snow man', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 072', 'Eestr066 to 072', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-220', 'Christmas cap', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  10, '10', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 073', 'Eestr066 to 073', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-221', 'Christmas flower blue with white stripe', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  35, '35', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 074', 'Eestr066 to 074', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-222', 'Christmas flower green', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  23, '23', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 075', 'Eestr066 to 075', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-223', 'Christmas flower red', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  6, '6', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 076', 'Eestr066 to 076', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-224', 'Christmas flower red and green together', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 077', 'Eestr066 to 077', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-225', 'Christmas tree dark green', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 078', 'Eestr066 to 078', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-226', 'Christmas box', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  10, '10', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 079', 'Eestr066 to 079', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-227', 'Metallic Christmas tree', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 080', 'Eestr066 to 080', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-228', 'Shades of blue flower', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  15, '15', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 081', 'Eestr066 to 081', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-229', 'Shades of red', 'Hardware & Equipment', 'pcs', 0, 0, 
  11, '11', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 082', 'Eestr066 to 082', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-230', 'Shades of pink flower', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 083', 'Eestr066 to 083', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-231', 'Hanging Christmas decor', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  3, '3', 'Warehouse Shelves', 'Warehouse Shelves', 
  'good', 'Eestr066 to 084', 'Eestr066 to 084', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-232', 'Condemned door', 'Carpentry & Props', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'not good', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-233', 'Elepaq generator', 'Electrical & Lighting', 'pcs', 0, 0, 
  2, '2', 'Warehouse Shelves', 'Warehouse Shelves', 
  'new', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-234', 'Black Thick mat', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-235', 'Valeeta Cone', 'Hardware & Equipment', 'pcs', 0, 0, 
  6, '6', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-236', 'Veleta Gele', 'Apparel & Merchandise', 'pcs', 0, 0, 
  8, '8', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-WAR-237', 'Red gazebo on the floor', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Warehouse Shelves', 'Warehouse Shelves', 
  'Not specified', 'Unassigned', 'Unassigned', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-238', 'Cardboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  9, '9', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-239', 'Inn Chair', 'Activation Props & Furniture', 'pcs', 0, 0, 
  19, '19', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-240', 'Wheel barrow', 'Automotive & Logistics', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-241', 'White Cardboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-242', 'Fan without stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-243', 'Wood', 'Carpentry & Props', 'pcs', 0, 0, 
  72, '72', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-244', 'Big bread', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-245', 'Table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  7, '7', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-246', 'Wood design table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-247', 'Iron stand Design', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-248', 'Viva body Slimmer', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-249', 'Spoon', 'Catering & Kitchen', 'pcs', 0, 0, 
  28, '28 packs', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-250', 'Spliot fan', 'Hardware & Equipment', 'pcs', 0, 0, 
  4, '4', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-251', 'Tomato Jos board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-252', 'Game roll', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-253', 'Car sign', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-254', 'Hand cleaning board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-255', 'Iron display', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-256', 'Cable reel', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-257', 'Iron case', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2 sets', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-258', 'Bucket', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-259', 'Cupboard Brown', 'Marketing & Branding Props', 'pcs', 0, 0, 
  8, '8', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-260', 'Black steel stool without seat head', 'Activation Props & Furniture', 'pcs', 0, 0, 
  18, '18', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-261', 'Wheel barrow', 'Automotive & Logistics', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-262', 'Ox Fan blade and cage', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-263', 'Through History board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-264', 'Green wood riser', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-265', 'Green box prop', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-266', 'Green malaria hand prop', 'Activation Props & Furniture', 'pcs', 0, 0, 
  11, '11', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-267', 'Palette wooden', 'Carpentry & Props', 'pcs', 0, 0, 
  5, '5', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-268', 'Used wooden pieces prop stash', 'Activation Props & Furniture', 'pcs', 0, 0, 
  17, '17', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-269', 'Open black plastic box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-270', 'wooden brown cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-271', 'Rope latch', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-272', 'Plywood', 'Carpentry & Props', 'pcs', 0, 0, 
  3, '3', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-273', 'Rubberfloor', 'Flooring & Carpets', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-274', 'Blue metal tripod', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-275', 'Body slimmer machine', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-276', 'Fan mist machine', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-277', 'Antique wooden chair', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-278', 'Table set plastics', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-279', 'Blue rug', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-280', 'Spoon packs', 'Catering & Kitchen', 'pcs', 0, 0, 
  21, '21', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-281', 'Fan base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-282', 'Drawer and cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-283', 'Old brown knitlike rug', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-284', 'Used wooden pieces', 'Carpentry & Props', 'pcs', 0, 0, 
  19, '19', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-285', 'Black keg', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-286', 'Green gazebo cover', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-287', 'Louvres glass', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-288', 'Small motar and pestle', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-289', 'Tomato jos board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-290', 'Black collapsable table sets', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-291', 'Golden roll rafflle draw cage', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-292', 'Blue rug', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-293', 'Long cable extension roll', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-294', 'Stacked bundle sets of premier cool sign boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-295', 'Yellow & Red colored boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  10, '10', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-296', 'Cobweb dusters', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Maryland Office Side', 'Maryland Office Side', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-297', 'Straight pole small', 'Hardware & Equipment', 'pcs', 0, 0, 
  16, '16', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-298', 'Meduim pole', 'Hardware & Equipment', 'pcs', 0, 0, 
  15, '15', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-299', 'Canopy stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-300', 'Net bundle', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-301', 'Stage stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-302', 'Net barrier', 'Hardware & Equipment', 'pcs', 0, 0, 
  11, '11', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-303', 'Canopy top stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  8, '8', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-304', 'Stage base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-305', 'Tall stage set up stand at the back', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-306', 'Black stage base setup at the back', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-307', 'Silver steel rods', 'Hardware & Equipment', 'pcs', 0, 0, 
  6, '6', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-308', 'Rolled net', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-309', 'Water tanks', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  2, '2', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-310', 'Metal white tripod', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-311', 'Curved black metal steel', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-312', 'Car tire', 'Automotive & Logistics', 'pcs', 0, 0, 
  1, '1', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-313', 'Pipes at the back', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  8, '8', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-314', 'Green metal fence', 'Hardware & Equipment', 'pcs', 0, 0, 
  8, '8', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-315', 'Carex dart board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Maryland Chidinma Office', 'Maryland Chidinma Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-316', 'Green gas cylinder', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-317', 'Valqunised iron', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-318', 'Blue drum', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  2, '2', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-319', 'Wheel barrow', 'Automotive & Logistics', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-320', 'Devon kings keg small & big', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-321', 'Tyre', 'Automotive & Logistics', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-322', 'Yellow gen', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-MAR-323', 'Blue basket', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Maryland Beside Kitchen', 'Maryland Beside Kitchen', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-324', 'Marry Me letter Boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  6, '6', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-325', 'Rolled silver net', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-326', 'White Metal tripod rod', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-327', 'Premier cube box', 'Storage & Packaging', 'pcs', 0, 0, 
  7, '7', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-328', 'Premier shower stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  8, '8', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-329', 'Gift box', 'Storage & Packaging', 'pcs', 0, 0, 
  4, '4', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-330', 'White Triangle wood & board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  10, '10', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-331', 'Cussons baby flat board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  5, '5', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-332', 'Robb flat board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-333', 'Ox fan head', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-334', 'Floodlight cage', 'Electrical & Lighting', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-335', 'Teddy bear', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-336', 'Red&Black flowery sqaure pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-337', 'Sac filled with tapes on shower stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-338', 'Sac filled with clothing props', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-339', 'empty tv box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-340', 'empty brown box', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-341', 'vechile windows', 'Carpentry & Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-342', 'Weight measurement scale', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-343', 'Blue polythene bag with devon cloth', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-344', 'Blue polythene bag with robb cloth', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-345', 'Black polythene filled with yellow cloth', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-346', 'Sac filled with small robb display boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-347', 'Brown flat boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  3, '3', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-348', 'White nylon filled with traditional beads', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-349', 'White paper box filled with quaker', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-350', 'White paper box filled with good mama pamplets', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-351', 'Mirror with light', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-352', 'wine bottle', 'Hardware & Equipment', 'pcs', 0, 0, 
  3, '3', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-353', 'carex stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-354', 'bokku nylon with traditional clothes', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-355', 'Frost machine', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-356', 'givana cosmetics mini signs', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-357', 'joy shower foot mat', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-358', 'Old banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-359', 'Preiemer cool mat', 'Flooring & Carpets', 'pcs', 0, 0, 
  6, '6', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-360', 'Robb tray display board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-361', 'Writing board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-362', 'black bag of pull up banner base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-363', 'Colagte plastic strips', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-364', 'Cussons baby flat board mini', 'Marketing & Branding Props', 'pcs', 0, 0, 
  6, '6', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-365', 'Brown box with tomato jos id & gele', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-366', 'White box with spar book', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-367', 'Kitchen sink', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  3, '3', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-368', 'Black setup stand bags', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-369', 'Baby cussons cut out boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  16, '16', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-370', 'Plastic table leg', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-371', '1 haier thermocool choice board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-372', 'white boards beside carex stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  12, '12', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-373', 'Pink straight board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-374', 'Pink cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-375', 'Ox fan head base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-376', 'Giavanis black shirt', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-377', 'red big umbrella and rod', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  2, '2', 'Ogba Upstairs', 'Ogba Upstairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-378', 'Carex glow box', 'Apparel & Merchandise', 'pcs', 0, 0, 
  20, '20', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-379', 'Golden flag pole', 'Hardware & Equipment', 'pcs', 0, 0, 
  8, '8', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-380', 'Nylon filled with 2 sure nose mask', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-381', 'Mini Sac filled with thermocool shirt', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-382', 'Surgical faace mask', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-383', 'Sac containing traditional bead and adire', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-384', 'Morning fresh square throw pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  19, '19', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-385', 'Morning fresh round pillow', 'Activation Props & Furniture', 'pcs', 0, 0, 
  9, '9', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-386', 'Green polythene bad filled with carex uniform', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-387', 'Black nylon bag filled with red petals and flowers', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-388', 'feather banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  3, '3', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-389', 'Gas cooker', 'Catering & Kitchen', 'pcs', 0, 0, 
  2, '2', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-390', 'Roll on banner', 'Marketing & Branding Props', 'pcs', 0, 0, 
  3, '3', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-391', 'Carex uniform sac', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-392', 'Ariston boardpack', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-393', 'Christmas tree rod', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-394', 'Christmas tree & decoration', 'Seasonal & Holiday Decor', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-395', 'plastic seat', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-396', 'cussons baby registartion books', 'Stationery & Print Materials', 'pcs', 0, 0, 
  6, '6', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-397', 'tomato jos carton filled with registration books', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-398', 'Edged2u Reg books', 'Stationery & Print Materials', 'pcs', 0, 0, 
  7, '7', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-399', 'robb tray boards', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-400', 'nylon filled with rubber lighter', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DOW-401', 'Display promo handouts', 'Stationery & Print Materials', 'pcs', 0, 0, 
  1, '1', 'Downstairs Middle Floor', 'Downstairs Middle Floor', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-402', 'farm table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-403', 'Farm chairs', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-404', 'Aircondition not working', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-405', 'Car tire not good', 'Automotive & Logistics', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-406', 'Jameson wooden table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-407', 'wooden table with iron legs', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-408', 'haise chair', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-409', 'Generator', 'Electrical & Lighting', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-410', 'Jameson farm bench', 'Activation Props & Furniture', 'pcs', 0, 0, 
  7, '7', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-411', 'Jameson farm table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-412', '2 by 2 wood', 'Carpentry & Props', 'pcs', 0, 0, 
  5, '5', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-413', 'pepedem wash/cooking stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-414', 'inside cooking stand 3 water pipe', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-415', 'inside cooking stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-416', 'uncomplete cooking gas top', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-417', 'Jameson farm bench', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-418', 'Jameson green cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  8, '8', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-419', 'White base complete', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-420', 'Display table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-421', 'lather', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-422', 'carex army logo inside jameson green cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  9, '9', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-423', 'cusson carex inside jameson green cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  11, '11', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-424', 'white plywood', 'Carpentry & Props', 'pcs', 0, 0, 
  4, '4', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-425', '2 by 2 plywood', 'Carpentry & Props', 'pcs', 0, 0, 
  50, '50', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-426', 'spinwheel at the back of plywood', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-427', 'plywood sheet', 'Carpentry & Props', 'pcs', 0, 0, 
  6, '6', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-428', 'Jameson table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-429', 'mamador cooking cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-430', 'Kings cooking cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-431', 'premiere cool wooden bar soap', 'Carpentry & Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-432', 'mamador metal cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-433', 'plastic rubber stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  6, '6', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-434', 'mockup display stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  4, '4', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-435', 'Wooden riser tall', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-436', 'morning fresh 10x cupboard', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-437', 'table with iron legs', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-438', 'wooden table with foldable legs not in good condition', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-439', 'mamador metal cooking station', 'Catering & Kitchen', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-440', 'mamador wooden wash stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-441', 'Jamesoon bamboo false wall', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-442', 'display table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  3, '3', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-443', 'white base complete', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-444', 'black base', 'Activation Props & Furniture', 'pcs', 0, 0, 
  15, '15', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-445', 'jameson basket false wall', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-446', 'waterpipe', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-447', 'plywood board thin', 'Marketing & Branding Props', 'pcs', 0, 0, 
  6, '6', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-448', 'plywood board thick', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-449', 'morning fresh bottle mockup live size', 'Marketing & Branding Props', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-450', 'Devon kings crate', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-451', 'pepedem cooking stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-452', 'Jameson wash stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  2, '2', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-453', 'premiere cool display stand', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-454', 'yumyum unveil board', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-455', 'yellow branded plywood', 'Carpentry & Props', 'pcs', 0, 0, 
  5, '5', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-456', 'Jameson farm table', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-457', 'Jameson farm bench', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Ogba Side Store', 'Ogba Side Store', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-458', 'GREEN ASTROTAUF ROUGH', 'Flooring & Carpets', 'pcs', 0, 0, 
  8, '8', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-459', 'GREEN ASTROTAUF SMOOTH', 'Flooring & Carpets', 'pcs', 0, 0, 
  5, '5', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-460', 'GREEN ASTROTAUF SMOOTH NOT BIG', 'Flooring & Carpets', 'pcs', 0, 0, 
  8, '8', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-461', 'BLUE ASTROTAUF ROUGH', 'Flooring & Carpets', 'pcs', 0, 0, 
  2, '2', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-462', 'BLUE ASTROTAUF SMOOTH', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-463', 'RED ASTROTAUF ROUGH', 'Flooring & Carpets', 'pcs', 0, 0, 
  2, '2', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-464', 'RED ASTROTAUF SMOOTH', 'Flooring & Carpets', 'pcs', 0, 0, 
  2, '2', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-465', 'RED ASTROTAUF SMALL ROUGH', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-466', 'RED RUG', 'Flooring & Carpets', 'pcs', 0, 0, 
  4, '4', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-467', 'GREEN RUG', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-468', 'NAVY BLUE RUG', 'Flooring & Carpets', 'pcs', 0, 0, 
  5, '5', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-469', 'BLUE RUG', 'Flooring & Carpets', 'pcs', 0, 0, 
  8, '8', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-470', 'BLUE RUG small', 'Flooring & Carpets', 'pcs', 0, 0, 
  5, '5', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-471', 'BROWN RUG small', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-472', 'BLUE RUG small PIECES', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-473', 'NAVY BLUE RUG VERY BIG+', 'Flooring & Carpets', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-474', 'JAMESON GREEN TAMPOLINE', 'Event Gazebos & Canopies', 'pcs', 0, 0, 
  4, '4', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-475', 'FEATHER BANNER', 'Marketing & Branding Props', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-476', 'ROLL UP BANNER', 'Marketing & Branding Props', 'pcs', 0, 0, 
  8, '8', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-477', 'BOUNCING CASTLE PLUS 2 BLOWER INSIDE A BLACK SACK', 'Storage & Packaging', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-478', 'MANIQUE', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '2', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-479', 'CHILDREN GOAL POST', 'Hardware & Equipment', 'pcs', 0, 0, 
  1, '1', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-OGB-480', 'HAMPER NYLON', 'Storage & Packaging', 'pcs', 0, 0, 
  8, '8', 'Ogba Office - Before Stairs', 'Ogba Office - Before Stairs', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-BAC-481', 'SOCKAWAY VENT PIPE', 'Plumbing & Sanitary', 'pcs', 0, 0, 
  1, '1', 'Back of Ogba Office', 'Back of Ogba Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-BAC-482', 'STAGE IRON', 'Electrical & Lighting', 'pcs', 0, 0, 
  10, '10', 'Back of Ogba Office', 'Back of Ogba Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-BAC-483', 'BASE IRON FOR TAMPOLINE', 'Activation Props & Furniture', 'pcs', 0, 0, 
  30, '30', 'Back of Ogba Office', 'Back of Ogba Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-BAC-484', 'IRON FOR CONNECTING TAMPLINE', 'Hardware & Equipment', 'pcs', 0, 0, 
  20, '20', 'Back of Ogba Office', 'Back of Ogba Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-BAC-485', 'STRAIGHT IRON', 'Hardware & Equipment', 'pcs', 0, 0, 
  8, '8', 'Back of Ogba Office', 'Back of Ogba Office', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-486', 'Carex big x', 'Apparel & Merchandise', 'pcs', 0, 0, 
  1, '1', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-487', 'Iron Gate', 'Hardware & Equipment', 'pcs', 0, 0, 
  2, '1 PAIR', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-488', 'Iron Gate standing by the wall', 'Activation Props & Furniture', 'pcs', 0, 0, 
  1, '1', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-489', 'Bamboo short', 'Carpentry & Props', 'pcs', 0, 0, 
  30, '30', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-490', '2by2', 'Carpentry & Props', 'pcs', 0, 0, 
  19, '19', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-491', 'Plant with real on it', 'Hardware & Equipment', 'pcs', 0, 0, 
  9, '9', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-492', 'Big thick short plank', 'Carpentry & Props', 'pcs', 0, 0, 
  8, '8', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-493', 'Small short plank', 'Carpentry & Props', 'pcs', 0, 0, 
  4, '4', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-494', 'Short 2by2', 'Carpentry & Props', 'pcs', 0, 0, 
  23, '23', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-495', 'Condemned wooden door', 'Carpentry & Props', 'pcs', 0, 0, 
  23, '23', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-496', 'Condemned wooden window', 'Carpentry & Props', 'pcs', 0, 0, 
  1, '1', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-497', 'Hdf board (Inside MD Compound)', 'Marketing & Branding Props', 'pcs', 0, 0, 
  5, '5', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

INSERT INTO products (
  company_id, sku, name, category, unit, price, cost_price, 
  stock_quantity, quantity_display, location_of_item, warehouse_name, 
  condition, shelf_number, shelve_location, reorder_level, status
) VALUES (
  1, 'INV-DIA-498', 'Plank (Inside MD Compound)', 'Carpentry & Props', 'pcs', 0, 0, 
  5, '5', 'Diamond Estate', 'Diamond Estate', 
  '—', '—', '—', 0, 'active'
)
ON CONFLICT (sku) DO UPDATE SET 
  name = EXCLUDED.name,
  quantity_display = EXCLUDED.quantity_display,
  stock_quantity = EXCLUDED.stock_quantity,
  location_of_item = EXCLUDED.location_of_item,
  warehouse_name = EXCLUDED.warehouse_name,
  condition = EXCLUDED.condition,
  shelf_number = EXCLUDED.shelf_number,
  shelve_location = EXCLUDED.shelve_location,
  category = EXCLUDED.category;

