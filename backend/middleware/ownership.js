const pool = require('../config/db');

// Blocks a Student from reading another student's application.
// Admin always passes through.
async function ownApplication(req, res, next) {
    if (req.user.role === 'Admin') return next();

    const applicationId = req.params.id;
    try {
        const [rows] = await pool.query(
            'SELECT student_id FROM Application WHERE application_id = ?',
            [applicationId]
        );
        if (rows.length === 0) {
            return res.status(404).json({ message: 'Application not found' });
        }
        if (rows[0].student_id !== req.user.student_id) {
            return res.status(403).json({ message: 'Unauthorized: this is not your application' });
        }
        next();
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
}

module.exports = { ownApplication };
