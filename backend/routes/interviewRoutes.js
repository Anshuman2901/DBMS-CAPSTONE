const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// GET /api/interviews  (Admin: all | Student: own only)
router.get('/', auth, async (req, res) => {
    try {
        let sql = `
            SELECT i.*, a.student_id, s.first_name, s.last_name, j.job_title, c.company_name
            FROM Interview i
            JOIN Application a ON a.application_id = i.application_id
            JOIN Student s ON s.student_id = a.student_id
            JOIN Job_Opening j ON j.job_id = a.job_id
            JOIN Company c ON c.company_id = j.company_id`;
        const params = [];
        if (req.user.role === 'Student') {
            sql += ' WHERE a.student_id = ?';
            params.push(req.user.student_id);
        }
        sql += ' ORDER BY i.interview_date ASC';
        const [rows] = await pool.query(sql, params);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// POST /api/interviews  (Admin only) - schedule an interview round
router.post('/', auth, requireRole('Admin'), async (req, res) => {
    const { application_id, round_number, interview_type, interview_date, interview_mode } = req.body;
    try {
        const [result] = await pool.query(
            `INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status)
             VALUES (?,?,?,?,?,'Scheduled')`,
            [application_id, round_number, interview_type, interview_date, interview_mode]
        );
        res.status(201).json({ interview_id: result.insertId });
    } catch (err) {
        res.status(400).json({ message: err.sqlMessage || 'Could not schedule interview', error: err.message });
    }
});

module.exports = router;
