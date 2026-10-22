const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// GET /api/jobs  - everyone logged in; Students should only see Open jobs
router.get('/', auth, async (req, res) => {
    try {
        let sql = `SELECT j.*, c.company_name FROM Job_Opening j JOIN Company c ON c.company_id = j.company_id`;
        if (req.user.role === 'Student') sql += ` WHERE j.job_status = 'Open'`;
        sql += ' ORDER BY j.job_id DESC';
        const [rows] = await pool.query(sql);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// GET /api/jobs/:id/eligibility  (Student) - check own eligibility for a job
router.get('/:id/eligibility', auth, requireRole('Student'), async (req, res) => {
    const [rows] = await pool.query('SELECT IsStudentEligible(?, ?) AS eligible', [req.user.student_id, req.params.id]);
    res.json({ eligible: !!rows[0].eligible });
});

// POST /api/jobs  (Admin only)
router.post('/', auth, requireRole('Admin'), async (req, res) => {
    const { company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline } = req.body;
    try {
        const [result] = await pool.query(
            `INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline)
             VALUES (?,?,?,?,?,?,?,?,?)`,
            [company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline]
        );
        res.status(201).json({ job_id: result.insertId });
    } catch (err) {
        res.status(400).json({ message: 'Could not create job', error: err.message });
    }
});

module.exports = router;
