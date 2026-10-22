// Usage: requireRole('Admin')  or  requireRole('Admin', 'Student')
function requireRole(...allowedRoles) {
    return (req, res, next) => {
        if (!req.user || !allowedRoles.includes(req.user.role)) {
            return res.status(403).json({ message: 'Forbidden: you do not have access to this resource' });
        }
        next();
    };
}

module.exports = requireRole;
