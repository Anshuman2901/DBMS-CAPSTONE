const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// All report routes are Admin-only.
router.use(auth, requireRole('Admin'));

router.get('/company-applications', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT c.company_name, COUNT(a.application_id) AS total_applications
            FROM Company c
            JOIN Job_Opening j ON j.company_id = c.company_id
            JOIN Application a ON a.job_id = j.job_id
            GROUP BY c.company_name ORDER BY total_applications DESC`);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

router.get('/department-placement', async (req, res) => {
    try {
        const [rows] = await pool.query('CALL GeneratePlacementReport()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

router.get('/not-placed', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT s.student_id, s.roll_no, s.first_name, s.last_name, s.department
            FROM Student s
            LEFT JOIN Application a ON a.student_id = s.student_id
            LEFT JOIN Placement p ON p.application_id = a.application_id
            WHERE p.placement_id IS NULL
            GROUP BY s.student_id, s.roll_no, s.first_name, s.last_name, s.department`);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

router.get('/summary', async (req, res) => {
    try {
        const [[summary]] = await pool.query(`
            SELECT
                (SELECT COUNT(*) FROM Student) AS total_students,
                (SELECT COUNT(*) FROM Company) AS total_companies,
                (SELECT COUNT(*) FROM Job_Opening) AS total_jobs,
                (SELECT COUNT(*) FROM Application) AS total_applications,
                (SELECT COUNT(*) FROM Placement) AS total_placed,
                (SELECT ROUND(AVG(package_lpa), 2) FROM Placement) AS avg_package,
                (SELECT MAX(package_lpa) FROM Placement) AS highest_package
        `);
        res.json(summary);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

module.exports = router;
