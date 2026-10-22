// One-time script: sets a real bcrypt hash of 'Password@123' for every
// demo account inserted by database/sample_data.sql.
// Run with: node scripts/setPasswords.js
require('dotenv').config();
const bcrypt = require('bcryptjs');
const pool = require('../config/db');

async function run() {
    const hash = await bcrypt.hash('Password@123', 10);
    const [result] = await pool.query('UPDATE User_Account SET password_hash = ?', [hash]);
    console.log(`Updated ${result.affectedRows} account(s). All demo accounts now use password: Password@123`);
    process.exit(0);
}

run().catch(err => {
    console.error('Failed to set demo passwords:', err.message);
    process.exit(1);
});
