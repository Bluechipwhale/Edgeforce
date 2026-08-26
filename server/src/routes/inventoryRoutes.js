// ==============================================================================
// EDGEWFORCE - INVENTORY & STOCK ROUTES
// ==============================================================================

import express from 'express';
import { inventoryController } from '../controllers/inventoryController.js';
import { requireAuth } from '../middleware/auth.js';
import { hasRole } from '../middleware/rbac.js';

const router = express.Router();

router.use(requireAuth);

// 1. Products
router.get('/products', inventoryController.getProducts);
router.get('/products/:id', inventoryController.getProductById);
router.post('/products', hasRole('SUPER_ADMIN', 'ADMIN', 'MANAGER', 'IT_ADMIN', 'CEO'), inventoryController.createProduct);
router.put('/products/:id', hasRole('SUPER_ADMIN', 'ADMIN', 'MANAGER', 'IT_ADMIN', 'CEO'), inventoryController.updateProduct);
router.delete('/products/:id', hasRole('SUPER_ADMIN', 'ADMIN', 'MANAGER', 'IT_ADMIN', 'CEO'), inventoryController.deleteProduct);

// 2. Stock Movements & Restocking
router.post('/movements', hasRole('SUPER_ADMIN', 'ADMIN', 'MANAGER', 'SUPERVISOR', 'IT_ADMIN', 'CEO'), inventoryController.recordStockMovement);
router.get('/movements', inventoryController.getMovements);

// 3. Warehouses & Summary
router.get('/warehouses', inventoryController.getWarehouses);
router.get('/summary', inventoryController.getInventorySummary);

export default router;
