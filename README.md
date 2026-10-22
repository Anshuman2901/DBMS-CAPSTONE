# Student Placement & Recruitment Management System

DBMS Capstone Project — a full-stack, role-based web application for managing
campus placements: students, companies, job openings, applications, interviews
and placements, backed by a single connected MySQL database.

Built across 5 phases (20 marks each), as required by the capstone brief:

| Phase | What it covers | Where |
|---|---|---|
| 1 | ER diagram, 3NF normalization, final schema | `docs/Phase-1-Report.md`, `docs/ER-Diagram.png` |
| 2 | DDL, sample data, procedures, functions, triggers | `database/schema.sql` → `triggers.sql` |
| 3 | Reports, indexing, EXPLAIN before/after | `database/reports.sql`, `database/indexes.sql` |
| 4 | RBAC, transactions, test cases | `docs/Phase-4-Test-Cases.md`, backend middleware |
| 5 | Full website (Node + Express + MySQL + HTML/CSS/JS) | `backend/`, `frontend/` |

This whole project has been built and tested end-to-end (database, backend
API and login flow) before being handed to you — you only need to set it up
locally. See **SETUP.md** for exact, step-by-step instructions.

## Tech stack
- **Database:** MySQL 8
- **Backend:** Node.js, Express, mysql2, JWT auth, bcrypt password hashing
- **Frontend:** Plain HTML, CSS, JavaScript (no framework)

## Project structure
```
database/     SQL files — run in this order: schema → sample_data → procedures
              → functions → triggers → indexes. reports.sql has the Phase 3 queries.
backend/      Node.js + Express REST API
frontend/     Admin and Student websites (plain HTML/CSS/JS)
docs/         Phase 1 report, ER diagram, Phase 4 test cases
screenshots/  Put your MySQL Workbench / browser screenshots here for submission
```

## Demo login (after you run `npm run seed:passwords`, see SETUP.md)
- Admin: `admin@placement.com`
- Student: any student email from `database/sample_data.sql`
- Password (both): `Password@123`

## Status
- [x] Phase 1 — Data Modeling & Schema Design
- [x] Phase 2 — Procedural Implementation
- [x] Phase 3 — Query & Report Development
- [x] Phase 4 — Security, Access Control & Testing
- [x] Phase 5 — Integration, UI & Final Presentation
