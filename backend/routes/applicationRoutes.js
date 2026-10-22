const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');
const { ownApplication } = require('../middleware/ownership');

// GET /api/applications  (Admin: all | Student: own only)
router.get('/', auth, async (req, res) => {
    try {
        let sql = `
            SELECT a.*, s.first_name, s.last_name, s.roll_no, j.job_title, c.company_name
            FROM Application a
            JOIN Student s ON s.student_id = a.student_id
            JOIN Job_Opening j ON j.job_id = a.job_id
            JOIN Company c ON c.company_id = j.company_id`;
        const params = [];
        if (req.user.role === 'Student') {
            sql += ' WHERE a.student_id = ?';
            params.push(req.user.student_id);
        }
        sql += ' ORDER BY a.application_id DESC';
        const [rows] = await pool.query(sql, params);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// GET /api/applications/:id  (Admin or the owning student)
router.get('/:id', auth, ownApplication, async (req, res) => {
    const [rows] = await pool.query('SELECT * FROM Application WHERE application_id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ message: 'Application not found' });
    res.json(rows[0]);
});

// POST /api/applications  (Student applies to a job)
router.post('/', auth, requireRole('Student'), async (req, res) => {
    const { job_id } = req.body;
    const student_id = req.user.student_id;
    const application_date = new Date().toISOString().slice(0, 10);
    try {
        const [result] = await pool.query(
            `INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (?,?,?,'Applied')`,
            [student_id, job_id, application_date]
        );
        res.status(201).json({ application_id: result.insertId });
    } catch (err) {
        // Triggers (duplicate / ineligible) raise SQLSTATE 45000 with a clear message
        res.status(400).json({ message: err.sqlMessage || 'Could not submit application', error: err.message });
    }
});

// PUT /api/applications/:id/status  (Admin only) - e.g. Shortlisted / Rejected
router.put('/:id/status', auth, requireRole('Admin'), async (req, res) => {
    const { application_status } = req.body;
    try {
        await pool.query('UPDATE Application SET application_status = ? WHERE application_id = ?', [application_status, req.params.id]);
        res.json({ message: 'Status updated' });
    } catch (err) {
        res.status(400).json({ message: 'Could not update status', error: err.message });
    }
});

module.exports = router;
