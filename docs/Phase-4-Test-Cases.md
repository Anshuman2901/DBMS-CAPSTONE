# Phase 4 — Security, Access Control & Testing

## RBAC
- **Admin/TPO**: full access — manage Student, Company, Job_Opening, Application, Interview, Placement; view all reports.
- **Student**: read-only, own records only — own profile, available (open) jobs, own applications, own interviews, own placement.
- Enforced in `backend/middleware/auth.js` (JWT) and `backend/middleware/role.js` (role check) and `backend/middleware/ownership.js` (a Student can only read a resource tied to their own `student_id`, verified against the JWT on every request — e.g. `GET /api/applications/:id` returns `403 Unauthorized` if the application does not belong to the logged-in student).

## Transactions
`SelectStudentForJob` (database/procedures.sql) and `POST /api/placements` (backend) wrap the `UPDATE Application ... SET application_status='Selected'` + `INSERT INTO Placement` in one `START TRANSACTION ... COMMIT`, with `ROLLBACK` on any error, so a student is never left "Selected" without a placement row, or vice versa.

## Test Cases

| # | Test | Input | Expected | How it's enforced |
|---|---|---|---|---|
| 1 | Valid student insert | Realistic data | Pass | — |
| 2 | Invalid CGPA | `cgpa = 12` | Reject | `chk_student_cgpa` CHECK constraint |
| 3 | Negative backlogs | `backlogs = -1` | Reject | `chk_student_backlogs` CHECK constraint |
| 4 | Duplicate application | Same student + same job twice | Reject | `uq_app_student_job` UNIQUE + `trg_no_duplicate_application` |
| 5 | Ineligible student applies | CGPA below job's minimum_cgpa | Reject | `trg_check_eligibility_on_apply` |
| 6 | Placement on non-Selected application | `application_status = 'Applied'` | Reject | `trg_valid_placement` |
| 7 | Negative salary package | `package_lpa = -5` | Reject | `chk_placement_package` CHECK constraint |
| 8 | Student accesses another student's application | `GET /api/applications/:id` for someone else's id | `403 Unauthorized` | `ownership.js` middleware |
| 9 | Student tries an Admin-only route | `POST /api/companies` as Student role | `403 Unauthorized` | `role.js` middleware |
| 10 | Valid placement | Application already `Selected` | Pass, Placement row created | `SelectStudentForJob` procedure, transaction |
| 11 | Login with wrong password | Correct email, wrong password | `401 Invalid credentials` | bcrypt compare in `authRoutes.js` |
| 12 | Access without token | No `Authorization` header | `401 Unauthorized` | `auth.js` middleware |

> For submission: run each case in MySQL Workbench or via the website, and paste a screenshot of the error/success message next to its row above.

## Sample demo login (password for ALL demo accounts: `Password@123`)
- Admin: `admin@placement.com`
- Student: any student email from `database/sample_data.sql`, e.g. `aarav.sharma1@example.com`
