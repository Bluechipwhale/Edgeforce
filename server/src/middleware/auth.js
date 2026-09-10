// ==============================================================================
// EDGEWFORCE - JWT AUTHENTICATION MIDDLEWARE
// ==============================================================================

import jwt from 'jsonwebtoken';
import { db } from '../config/database.js';

const JWT_SECRET = process.env.JWT_SECRET || '3458929f44e69c199398c77212600d9f760aabb9b1dda42680556892307277ea';

export async function requireAuth(req, res, next) {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({
        success: false,
        error: { code: 'UNAUTHORIZED', message: 'Authentication required. Please provide a valid Bearer token.' }
      });
    }

    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, JWT_SECRET);

    const user = await db.findById('users', decoded.userId || decoded.id);
    if (!user || user.status !== 'active') {
      return res.status(401).json({
        success: false,
        error: { code: 'USER_INACTIVE', message: 'User account not found or is deactivated.' }
      });
    }

    const employee = await db.findOne('employees', { user_id: user.id });
    const rank = employee?.rank_code ? await db.findOne('ranks', { code: employee.rank_code }) : null;
    const department = employee?.department_id ? await db.findById('departments', employee.department_id) : null;

    // Attach complete security context
    req.user = {
      ...user,
      employee,
      rank,
      department
    };

    next();
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({
        success: false,
        error: { code: 'TOKEN_EXPIRED', message: 'Session token has expired. Please sign in again.' }
      });
    }
    return res.status(401).json({
      success: false,
      error: { code: 'INVALID_TOKEN', message: 'Invalid authentication token.' }
    });
  }
}

export function signUserToken(user) {
  return jwt.sign(
    {
      userId: user.id,
      email: user.email,
      role: user.role_code
    },
    JWT_SECRET,
    { expiresIn: '7d' }
  );
}
