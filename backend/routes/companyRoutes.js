const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// GET /api/companies  (Admin + Student can view)
router.get('/', auth, async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM Company ORDER BY company_id');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// POST /api/companies  (Admin only)
router.post('/', auth, requireRole('Admin'), async (req, res) => {
    const { company_name, industry, email, phone, website, location } = req.body;
    try {
        const [result] = await pool.query(
            `INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES (?,?,?,?,?,?)`,
            [company_name, industry, email, phone, website, location]
        );
        res.status(201).json({ company_id: result.insertId });
    } catch (err) {
        res.status(400).json({ message: 'Could not create company', error: err.message });
    }
});

module.exports = router;
