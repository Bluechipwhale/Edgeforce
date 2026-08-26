// ==============================================================================
// EDGEWFORCE - COMMERCIAL SALES ROUTES
// ==============================================================================

import express from 'express';
import { salesController } from '../controllers/salesController.js';
import { requireAuth } from '../middleware/auth.js';
import { upload } from '../middleware/upload.js';

const router = express.Router();

router.use(requireAuth);

// 1. Core Sales & POS
router.get('/my-report', salesController.getMyReport);
router.get('/customers', salesController.getCustomers);
router.post('/customers', salesController.createCustomer);
router.get('/products', salesController.getProducts);
router.post('/products', salesController.createProduct);
router.delete('/products/:id', salesController.deleteProduct);
router.post('/orders', salesController.createOrder);
router.get('/orders', salesController.getOrders);

// 2. Order Approval Workflow
router.post('/orders/:id/approve', salesController.approveOrder);
router.post('/orders/:id/reject', salesController.rejectOrder);
router.post('/orders/:id/request-changes', salesController.requestOrderChanges);

// 3. Sales Funnel & Collections
router.get('/funnel', salesController.getSalesFunnel);
router.post('/payments', salesController.recordPayment);
router.get('/payments', salesController.getPayments);
router.post('/payments/paystack', salesController.processPaystackPayment);

// 4. Intel & Settlement
router.post('/competitor-intel', upload.single('photo'), salesController.createCompetitorIntel);
router.get('/competitor-intel', salesController.getCompetitorIntel);
router.post('/settlements', upload.single('bank_slip'), salesController.createSettlement);
router.get('/settlements', salesController.getSettlements);

export default router;

