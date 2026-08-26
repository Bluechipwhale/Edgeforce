// ==============================================================================
// EDGEWFORCE - HR COMMAND CENTER ROUTES
// ==============================================================================

import express from 'express';
import { hrController } from '../controllers/hrController.js';
import { requireAuth } from '../middleware/auth.js';
import { hasRole } from '../middleware/rbac.js';

const router = express.Router();

router.use(requireAuth);
router.use(hasRole('HR', 'CEO', 'CTO', 'IT_ADMIN', 'MANAGER', 'SUPERVISOR'));

router.get('/dashboard', hrController.getDashboard);
router.get('/employees', hrController.getEmployees);
router.post('/employees/register', hrController.registerStaff);
router.post('/staff/register', hrController.registerStaff);
router.put('/employees/:id', hrController.updateEmployee);
router.put('/employees/:id/status', hrController.updateStaffStatus);
router.post('/employees/:id/resend-invitation', hrController.resendInvitation);
router.get('/audit-logs', hrController.getAuditLogs);
router.get('/attendance', hrController.getAttendance);
router.get('/idle-events', hrController.getIdleEvents);
router.get('/leave', hrController.getLeave);
router.put('/leave/:id/approve', hrController.approveLeave);
router.put('/leave/:id/reject', hrController.rejectLeave);
router.get('/tasks', hrController.getTasks);
router.post('/tasks', hrController.assignTask);
router.get('/sos', hrController.getSOS);
router.put('/sos/:id/acknowledge', hrController.acknowledgeSOS);
router.put('/sos/:id/resolve', hrController.resolveSOS);
router.get('/ranks', hrController.getRanks);
router.post('/ranks', hrController.createRank);
router.put('/ranks/:id', hrController.updateRank);
router.get('/organization', hrController.getOrganization);
router.put('/organization/node/:id', hrController.reassignOrganizationNode);
router.delete('/organization/node/:id', hrController.deleteOrganizationNode);

// Announcements & Broadcasts
router.get('/announcements', hrController.getAnnouncements);
router.post('/announcements', hrController.createAnnouncement);
router.put('/announcements/:id', hrController.updateAnnouncement);
router.delete('/announcements/:id', hrController.deleteAnnouncement);

// Staff Birthdays & Milestones
router.get('/birthdays', hrController.getBirthdays);
router.put('/employees/:id/birthday', hrController.updateBirthday);
router.post('/birthdays/broadcast', hrController.broadcastBirthday);

export default router;


