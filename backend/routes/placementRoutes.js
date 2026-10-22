const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// GET /api/placements  (Admin: all | Student: own only)
router.get('/', auth, async (req, res) => {
    try {
        let sql = `
            SELECT p.*, a.student_id, s.first_name, s.last_name, j.job_title, c.company_name
            FROM Placement p
            JOIN Application a ON a.application_id = p.application_id
            JOIN Student s ON s.student_id = a.student_id
            JOIN Job_Opening j ON j.job_id = a.job_id
            JOIN Company c ON c.company_id = j.company_id`;
        const params = [];
        if (req.user.role === 'Student') {
            sql += ' WHERE a.student_id = ?';
            params.push(req.user.student_id);
        }
        const [rows] = await pool.query(sql, params);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// POST /api/placements  (Admin only) - confirm placement using the
// transactional stored procedure (UPDATE Application + INSERT Placement
// in one COMMIT/ROLLBACK unit, per Phase 4 requirement)
router.post('/', auth, requireRole('Admin'), async (req, res) => {
    const { application_id, placement_date, package_lpa, joining_date } = req.body;
    try {
        await pool.query('CALL SelectStudentForJob(?,?,?,?)', [application_id, placement_date, package_lpa, joining_date]);
        res.status(201).json({ message: 'Placement confirmed' });
    } catch (err) {
        res.status(400).json({ message: err.sqlMessage || 'Could not confirm placement', error: err.message });
    }
});

module.exports = router;
