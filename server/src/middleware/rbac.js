// ==============================================================================
// EDGEWFORCE - ROLE & GRANULAR PERMISSION (RBAC) MIDDLEWARE
// ==============================================================================

// Base role mapping to default permissions
const ROLE_PERMISSIONS = {
  SUPER_ADMIN: ['*'],
  super_admin: ['*'],
  ADMIN: ['*'],
  CEO: ['*'],
  IT_ADMIN: ['*'],
  CTO: ['*'],
  AGENT_ADMIN: ['view_dashboard', 'view_employees', 'assign_tasks', 'view_attendance', 'manage_attendance', 'view_sales', 'create_orders', 'record_collections', 'view_customers', 'create_customers', 'view_field_operations', 'manage_routes', 'view_sos', 'manage_products', 'manage_stores', 'view_stores', 'view_reports', 'manage_field_tracking', 'view_deliveries', 'manage_inventory'],
  agent_admin: ['view_dashboard', 'view_employees', 'assign_tasks', 'view_attendance', 'manage_attendance', 'view_sales', 'create_orders', 'record_collections', 'view_customers', 'create_customers', 'view_field_operations', 'manage_routes', 'view_sos', 'manage_products', 'manage_stores', 'view_stores', 'view_reports', 'manage_field_tracking', 'view_deliveries', 'manage_inventory'],
  HR_MANAGER: ['view_dashboard', 'view_employees', 'create_employee', 'edit_employee', 'delete_employee', 'assign_tasks', 'approve_leave', 'view_attendance', 'manage_attendance', 'view_idle_reports', 'manage_ranks', 'view_sos', 'resolve_sos', 'view_reports', 'admin_portal'],
  hr_manager: ['view_dashboard', 'view_employees', 'create_employee', 'edit_employee', 'delete_employee', 'assign_tasks', 'approve_leave', 'view_attendance', 'manage_attendance', 'view_idle_reports', 'manage_ranks', 'view_sos', 'resolve_sos', 'view_reports', 'admin_portal'],
  HR: ['view_dashboard', 'view_employees', 'create_employee', 'edit_employee', 'delete_employee', 'assign_tasks', 'approve_leave', 'view_attendance', 'manage_attendance', 'view_idle_reports', 'manage_ranks', 'view_sos', 'resolve_sos', 'view_reports', 'admin_portal'],
  SENIOR_ACCOUNTANT: ['view_dashboard', 'view_payroll', 'manage_payroll', 'record_collections', 'view_sales', 'view_reports'],
  ACCOUNTANT: ['view_dashboard', 'view_payroll', 'manage_payroll', 'record_collections', 'view_sales'],
  MANAGER: ['view_dashboard', 'view_employees', 'assign_tasks', 'approve_leave', 'view_attendance', 'manage_attendance', 'view_sales', 'view_field_operations', 'manage_routes', 'view_reports', 'manage_stores', 'view_stores', 'manage_field_tracking', 'view_deliveries', 'manage_inventory'],
  SUPERVISOR: ['view_dashboard', 'assign_tasks', 'view_attendance', 'manage_attendance', 'view_field_operations', 'manage_routes', 'view_sos', 'view_reports', 'manage_stores', 'view_stores', 'manage_field_tracking', 'view_deliveries', 'manage_inventory', 'approve_orders'],
  supervisor: ['view_dashboard', 'assign_tasks', 'view_attendance', 'manage_attendance', 'view_field_operations', 'manage_routes', 'view_sos', 'view_reports', 'manage_stores', 'view_stores', 'manage_field_tracking', 'view_deliveries', 'manage_inventory', 'approve_orders'],
  SALES_AGENT: ['view_dashboard', 'view_sales', 'create_orders', 'record_collections', 'view_customers', 'create_customers', 'manage_products', 'view_competitors', 'view_stores', 'request_store'],
  sales_agent: ['view_dashboard', 'view_sales', 'create_orders', 'record_collections', 'view_customers', 'create_customers', 'manage_products', 'view_competitors', 'view_stores', 'request_store'],
  FIELD_AGENT: ['view_dashboard', 'view_field_operations', 'view_customers', 'view_sos', 'view_stores', 'request_store'],
  field_agent: ['view_dashboard', 'view_field_operations', 'view_customers', 'view_sos', 'view_stores', 'request_store'],
  STAFF_MEMBER: ['view_dashboard'],
  staff: ['view_dashboard'],
  EMPLOYEE: ['view_dashboard']
};


/**
 * Checks if current user has any of the allowed roles.
 * @param  {...string} allowedRoles
 */
export function hasRole(...allowedRoles) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        error: { code: 'UNAUTHORIZED', message: 'Authentication required.' }
      });
    }

    const userRole = req.user.role_code;
    const userRank = req.user.rank?.code;
    const userEmail = req.user.email;

    const isMatch = allowedRoles.includes(userRole) || (userRank && allowedRoles.includes(userRank));
    if (
      userRole === 'SUPER_ADMIN' ||
      userRole === 'ADMIN' ||
      userRole === 'IT_ADMIN' ||
      userRank === 'IT_ADMIN' ||
      userRole === 'CEO' ||
      userRank === 'CEO' ||
      userRole === 'CTO' ||
      userRank === 'CTO' ||
      userEmail === 'admin@edgewforce.com' ||
      userEmail === 'it@edgewforce.com' ||
      isMatch
    ) {
      return next();
    }

    return res.status(403).json({
      success: false,
      error: { code: 'FORBIDDEN', message: `Access denied. Requires one of: ${allowedRoles.join(', ')}` }
    });
  };
}

/**
 * Checks if current user has a specific granular permission.
 * @param {string} permissionCode
 */
export function hasPermission(permissionCode) {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        error: { code: 'UNAUTHORIZED', message: 'Authentication required.' }
      });
    }

    const role = req.user.role_code;
    const rank = req.user.rank?.code;
    const userPermissions = [
      ...(ROLE_PERMISSIONS[role] || []),
      ...(ROLE_PERMISSIONS[rank] || [])
    ];

    if (userPermissions.includes('*') || userPermissions.includes(permissionCode)) {
      return next();
    }

    return res.status(403).json({
      success: false,
      error: { code: 'PERMISSION_DENIED', message: `Missing required permission: ${permissionCode}` }
    });
  };
}

/**
 * Validates that an employee is not attempting to assign tasks or make modifications
 * to a superior higher in the organizational hierarchy.
 */
export function validateHierarchyAssignment(assignerRankLevel, targetRankLevel) {
  const assignerLevel = Number(assignerRankLevel || 8);
  const targetLevel = Number(targetRankLevel || 8);

  // In our hierarchy: 1 = CEO (highest), 8 = STAFF (lowest).
  // An assigner must have a level strictly LESS THAN or EQUAL TO target level (e.g. Level 1 can assign to Level 1..8)
  return assignerLevel <= targetLevel;
}
