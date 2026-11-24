const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');

const dbConfig = {
    host: process.env.DB_HOST || 'mysql-4b95439-ajha24187-a029.k.aivencloud.com',
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 18790,
    user: process.env.DB_USER || 'avnadmin',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'defaultdb',
    ssl: { rejectUnauthorized: false },
    multipleStatements: true
};

async function run() {
    console.log('Connecting to Aiven MySQL...');
    const conn = await mysql.createConnection(dbConfig);
    console.log('✓ Connected to Aiven MySQL successfully!');

    const dbDir = path.join(__dirname, '..', '..', 'database');

    // 1. Schema
    console.log('Creating schema tables...');
    let schemaSql = fs.readFileSync(path.join(dbDir, 'schema.sql'), 'utf8')
        .replace(/DROP DATABASE IF EXISTS.*?;/gi, '')
        .replace(/CREATE DATABASE.*?;/gi, '')
        .replace(/USE .*?;/gi, '');
    await conn.query(schemaSql);
    console.log('✓ Schema tables created');

    // 2. Sample Data
    console.log('Inserting sample data...');
    let dataSql = fs.readFileSync(path.join(dbDir, 'sample_data.sql'), 'utf8')
        .replace(/USE .*?;/gi, '');
    await conn.query(dataSql);
    console.log('✓ Sample data inserted');

    // 3. Stored Procedures
    console.log('Creating stored procedures...');
    let procSql = fs.readFileSync(path.join(dbDir, 'procedures.sql'), 'utf8')
        .replace(/USE .*?;/gi, '')
        .replace(/DELIMITER \$\$/gi, '')
        .replace(/DELIMITER ;/gi, '');
    let procs = procSql.split('$$').map(p => p.trim()).filter(p => p.length > 0);
    for (const p of procs) {
        if (p.startsWith('--')) {
            const clean = p.replace(/^--.*$/gm, '').trim();
            if (clean) await conn.query(clean);
        } else {
            await conn.query(p);
        }
    }
    console.log('✓ Stored procedures created');

    // 4. Stored Functions
    console.log('Creating stored functions...');
    let funcSql = fs.readFileSync(path.join(dbDir, 'functions.sql'), 'utf8')
        .replace(/USE .*?;/gi, '')
        .replace(/DELIMITER \$\$/gi, '')
        .replace(/DELIMITER ;/gi, '');
    let funcs = funcSql.split('$$').map(f => f.trim()).filter(f => f.length > 0);
    for (const f of funcs) {
        const clean = f.replace(/^--.*$/gm, '').trim();
        if (clean) await conn.query(clean);
    }
    console.log('✓ Stored functions created');

    // 5. Triggers
    console.log('Creating triggers...');
    let trigSql = fs.readFileSync(path.join(dbDir, 'triggers.sql'), 'utf8')
        .replace(/USE .*?;/gi, '')
        .replace(/DELIMITER \$\$/gi, '')
        .replace(/DELIMITER ;/gi, '');
    let trigs = trigSql.split('$$').map(t => t.trim()).filter(t => t.length > 0);
    for (const t of trigs) {
        const clean = t.replace(/^--.*$/gm, '').trim();
        if (clean) await conn.query(clean);
    }
    console.log('✓ Triggers created');

    // 6. Indexes
    console.log('Creating indexes...');
    let idxSql = fs.readFileSync(path.join(dbDir, 'indexes.sql'), 'utf8')
        .replace(/USE .*?;/gi, '');
    await conn.query(idxSql);
    console.log('✓ Indexes created');

    // 7. Passwords
    console.log('Hashing passwords to Password@123...');
    const hash = await bcrypt.hash('Password@123', 10);
    await conn.query('UPDATE User_Account SET password_hash = ?', [hash]);
    console.log('✓ Passwords updated successfully!');

    const [tables] = await conn.query('SHOW TABLES');
    console.log('\nFinal Tables in Cloud DB:', tables.map(r => Object.values(r)[0]));

    await conn.end();
    console.log('\n🎉 ALL DONE! CLOUD DATABASE IS 100% READY!');
}

run().catch(err => {
    console.error('Migration failed:', err);
    process.exit(1);
});
