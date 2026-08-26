// ==============================================================================
// EDGEWFORCE - INVENTORY & WAREHOUSE SERVICE
// ==============================================================================

import { db } from '../config/database.js';
import { logger } from '../utils/logger.js';

export const inventoryService = {
  async getProducts(companyId, filters = {}) {
    const compId = Number(companyId || 1);
    let list = await db.find('products', { company_id: compId });
    if (filters.category && filters.category !== 'all') {
      list = list.filter(p => p.category.toLowerCase() === filters.category.toLowerCase());
    }
    if (filters.search) {
      const q = filters.search.toLowerCase();
      list = list.filter(p => p.name.toLowerCase().includes(q) || p.sku.toLowerCase().includes(q));
    }
    if (filters.low_stock) {
      list = list.filter(p => p.stock_quantity <= (p.reorder_level || 20));
    }
    return list;
  },

  async getProductById(id, companyId) {
    const prod = await db.findById('products', id);
    if (prod && companyId && prod.company_id !== Number(companyId)) return null;
    return prod;
  },

  async createProduct(productData, user) {
    const compId = Number(user?.company_id || productData.company_id || 1);
    const created = await db.insert('products', {
      company_id: compId,
      sku: productData.sku || `SKU-${Date.now().toString().slice(-4)}`,
      name: productData.name,
      category: productData.category || 'General FMCG',
      unit: productData.unit || 'carton',
      price: Number(productData.price || 0),
      cost_price: Number(productData.cost_price || 0),
      stock_quantity: Number(productData.stock_quantity || 0),
      reorder_level: Number(productData.reorder_level || 20),
      warehouse_name: productData.warehouse_name || 'Ikeja Central Depot',
      shelve_location: productData.shelve_location || 'Aisle 1 - Bay A (Rack 1)',
      status: 'active'
    });


    await db.insert('inventory_movements', {
      company_id: compId,
      product_id: created.id,
      movement_type: 'RESTOCK',
      quantity: created.stock_quantity,
      previous_quantity: 0,
      new_quantity: created.stock_quantity,
      reference_number: `INIT-${created.sku}`,
      notes: 'Initial product creation inventory balance',
      recorded_by: user?.id || null
    });

    return created;
  },

  async updateProduct(id, updates, user) {
    const existing = await db.findById('products', id);
    if (!existing) throw new Error('Product not found');

    const updated = await db.update('products', id, updates);
    return updated;
  },

  async deleteProduct(id, user) {
    const existing = await db.findById('products', id);
    if (!existing) throw new Error('Product not found');

    await db.delete('products', id);

    await db.insert('audit_logs', {
      company_id: existing.company_id || 1,
      user_id: user?.id || null,
      user_email: user?.email || 'admin',
      action: 'PRODUCT_DELETED',
      entity: 'products',
      entity_id: String(id),
      previous_value: existing,
      new_value: null
    });

    return {
      success: true,
      message: `Product ${existing.name} (${existing.sku}) deleted successfully.`
    };
  },

  async recordStockMovement(movementData, user) {
    const { product_id, warehouse_id, movement_type, quantity, reference_number, notes } = movementData;
    const prod = await db.findById('products', product_id);
    if (!prod) throw new Error('Product not found');

    const prevQty = Number(prod.stock_quantity || 0);
    const delta = Number(quantity);
    let newQty = prevQty;

    if (['RESTOCK', 'ADJUSTMENT_ADD'].includes(movement_type)) {
      newQty = prevQty + delta;
    } else if (['DISPATCH', 'TRANSFER', 'DAMAGE', 'ADJUSTMENT_SUBTRACT'].includes(movement_type)) {
      if (prevQty < delta && movement_type !== 'DAMAGE') {
        throw new Error(`Insufficient stock. Current stock is ${prevQty} ${prod.unit}s.`);
      }
      newQty = Math.max(0, prevQty - delta);
    }

    // Update product stock
    await db.update('products', product_id, { stock_quantity: newQty });

    // Record movement
    const movement = await db.insert('inventory_movements', {
      company_id: prod.company_id,
      product_id: Number(product_id),
      warehouse_id: warehouse_id ? Number(warehouse_id) : null,
      movement_type,
      quantity: delta,
      previous_quantity: prevQty,
      new_quantity: newQty,
      reference_number: reference_number || `MOV-${Date.now().toString().slice(-6)}`,
      notes: notes || '',
      recorded_by: user?.id || null
    });

    // Check if low stock alert is triggered
    if (newQty <= (prod.reorder_level || 20)) {
      await db.insert('alerts', {
        company_id: prod.company_id,
        alert_type: 'LOW_BATTERY', // or product alert
        severity: 'MEDIUM',
        description: `Low stock alert: ${prod.name} has only ${newQty} ${prod.unit}s remaining (reorder level: ${prod.reorder_level}).`,
        status: 'OPEN'
      });
    }

    return movement;
  },

  async getMovements(companyId, limit = 50) {
    const compId = Number(companyId || 1);
    const list = await db.find('inventory_movements', { company_id: compId }, {
      order: { column: 'created_at', ascending: false },
      limit
    });

    const products = await db.find('products', { company_id: compId });
    const prodMap = new Map(products.map(p => [p.id, p]));

    return list.map(m => ({
      ...m,
      product: prodMap.get(m.product_id) || { name: 'Unknown Item', sku: '' }
    }));
  },

  async getWarehouses(companyId) {
    const compId = Number(companyId || 1);
    return await db.find('warehouses', { company_id: compId });
  },

  async getInventorySummary(companyId) {
    const compId = Number(companyId || 1);
    const products = await db.find('products', { company_id: compId });
    const totalSKUs = products.length;
    const totalQuantity = products.reduce((acc, p) => acc + (p.stock_quantity || 0), 0);
    const totalValuation = products.reduce((acc, p) => acc + ((p.stock_quantity || 0) * (p.cost_price || p.price || 0)), 0);
    const lowStockCount = products.filter(p => p.stock_quantity <= (p.reorder_level || 20)).length;

    return {
      totalSKUs,
      totalQuantity,
      totalValuation,
      lowStockCount
    };
  }
};
