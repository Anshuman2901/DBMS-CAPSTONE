const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../config/db');
require('dotenv').config();

// POST /api/auth/login
router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }
    try {
        const [rows] = await pool.query('SELECT * FROM User_Account WHERE email = ?', [email]);
        if (rows.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        const user = rows[0];
        const match = await bcrypt.compare(password, user.password_hash);
        if (!match) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        let studentInfo = null;
        if (user.role === 'Student') {
            const [s] = await pool.query('SELECT * FROM Student WHERE student_id = ?', [user.student_id]);
            studentInfo = s[0] || null;
        }

        const token = jwt.sign(
            { user_id: user.user_id, role: user.role, student_id: user.student_id },
            process.env.JWT_SECRET,
            { expiresIn: '8h' }
        );

        res.json({
            token,
            role: user.role,
            student_id: user.student_id,
            name: studentInfo ? `${studentInfo.first_name} ${studentInfo.last_name || ''}`.trim() : 'Admin'
        });
    } catch (err) {
        res.status(500).json({ message: 'Server error', error: err.message });
    }
});

module.exports = router;
