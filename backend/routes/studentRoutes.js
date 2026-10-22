const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/auth');
const requireRole = require('../middleware/role');

// GET /api/students  (Admin only) - list all students
router.get('/', auth, requireRole('Admin'), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM Student ORDER BY student_id');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// GET /api/students/me  (Student) - own profile
router.get('/me', auth, requireRole('Student'), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM Student WHERE student_id = ?', [req.user.student_id]);
        if (rows.length === 0) return res.status(404).json({ message: 'Student not found' });
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// GET /api/students/:id  (Admin only)
router.get('/:id', auth, requireRole('Admin'), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM Student WHERE student_id = ?', [req.params.id]);
        if (rows.length === 0) return res.status(404).json({ message: 'Student not found' });
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

// POST /api/students  (Admin only) - add a student
router.post('/', auth, requireRole('Admin'), async (req, res) => {
    const { roll_no, first_name, last_name, email, phone, department, course, graduation_year, cgpa, backlogs } = req.body;
    try {
        const [result] = await pool.query(
            `INSERT INTO Student (roll_no, first_name, last_name, email, phone, department, course, graduation_year, cgpa, backlogs)
             VALUES (?,?,?,?,?,?,?,?,?,?)`,
            [roll_no, first_name, last_name, email, phone, department, course, graduation_year, cgpa, backlogs || 0]
        );
        res.status(201).json({ student_id: result.insertId });
    } catch (err) {
        res.status(400).json({ message: 'Could not create student', error: err.message });
    }
});

module.exports = router;
