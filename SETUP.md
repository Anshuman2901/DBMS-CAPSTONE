# Setup Guide (VS Code, step by step)

## 0. Install these first (skip anything already installed)
- VS Code
- MySQL Server + MySQL Workbench
- Node.js (v18 or later)
- A browser (Chrome/Edge)

Check in a terminal:
```
node -v
mysql --version
```

## 1. Open the project
1. Unzip the project you received.
2. In VS Code: `File → Open Folder` → select `Student Placement & Recruitment Management System`.

## 2. Create the database
Open **MySQL Workbench**, connect to your local server, open a new SQL tab, and
run these files **in this exact order** (File → Open SQL Script → Execute, the
lightning bolt icon). Running out of order will cause errors (e.g. triggers
need the tables to exist first).

1. `database/schema.sql` — creates the database and all 7 tables
2. `database/sample_data.sql` — 21 students, 5 companies, 10 jobs, 38 applications, interviews, placements
3. `database/procedures.sql` — stored procedures
4. `database/functions.sql` — stored functions
5. `database/triggers.sql` — validation triggers
6. `database/indexes.sql` — indexes (read the comments for the EXPLAIN before/after demo)

Optional, for Phase 3 report screenshots: open `database/reports.sql` and run
each `SELECT` one at a time.

> This exact sequence was run and verified against a real MySQL 8 server while
> building this project — it works without errors when run in this order.

## 3. Configure and start the backend
1. In VS Code terminal:
   ```
   cd backend
   npm install
   ```
2. Copy `backend/.env.example` to a new file `backend/.env` and edit it:
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_actual_mysql_root_password
   DB_NAME=placement_management
   JWT_SECRET=any_long_random_text_you_like
   PORT=5000
   ```
3. Set real demo passwords (the sample data ships with a placeholder hash —
   this script overwrites it with a proper bcrypt hash of `Password@123` for
   every demo account):
   ```
   npm run seed:passwords
   ```
4. Start the server:
   ```
   npm start
   ```
   You should see: `Server running on http://localhost:5000`
   Keep this terminal open.

## 4. Open the website
1. In VS Code, right-click `frontend/index.html` → **Open with Live Server**
   (install the "Live Server" extension if you don't have it), or just
   double-click `frontend/index.html` to open it in your browser.
2. Log in:
   - Admin: `admin@placement.com` / `Password@123`
   - Student: any email from `database/sample_data.sql` (e.g. `aarav.sharma1@example.com`) / `Password@123`

> If the frontend can't reach the API, check `frontend/js/api.js` — the
> `API_BASE` constant must match the `PORT` you set in `backend/.env`.

## 5. Phase 4 test cases
Follow `docs/Phase-4-Test-Cases.md` — run each case in MySQL Workbench (or
through the website for the RBAC/ownership ones) and screenshot the result
into `screenshots/`.

## 6. For final submission
- `docs/Phase-1-Report.md` — convert to PDF (Word/Google Docs → Export as PDF, or any Markdown-to-PDF tool) → save as `docs/Phase-1.pdf`
- `docs/ER-Diagram.png` — already generated, ready to insert into your report
- Take the screenshots listed in each phase's "Evaluation Focus"
- Zip the whole folder for submission
