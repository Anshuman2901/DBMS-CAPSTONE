const mysql = require('mysql2/promise');
require('dotenv').config();

const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 3306,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
};

if (process.env.DB_SSL === 'true' || process.env.MYSQL_SSL === 'true') {
    dbConfig.ssl = { rejectUnauthorized: false };
}

const pool = mysql.createPool(process.env.DATABASE_URL || process.env.MYSQL_URL || dbConfig);

// Verify connection on startup
pool.getConnection()
    .then(conn => {
        console.log('✓ MySQL connected successfully');
        conn.release();
    })
    .catch(err => {
        console.error('✗ MySQL connection failed:', err.message);
    });

module.exports = pool;
