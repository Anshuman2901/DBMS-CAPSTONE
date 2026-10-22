# Student Placement & Recruitment Management System
## Phase 1 — Data Modeling & Schema Design

**Course:** Database Management Systems (Capstone)
**Student:** Anshuman, K.R. Mangalam University

---

## 1. Project Introduction

The Student Placement & Recruitment Management System is a database-driven application that manages the campus placement process of a college. It stores student profiles, recruiting companies, job openings, student applications, interview rounds and final placement records in one connected system. The Training & Placement Office (TPO/Admin) manages the whole process, and students can view only their own data.

## 2. Problem Statement

Many colleges still manage placement data in scattered spreadsheets and paper files. This causes duplicate applications, ineligible students applying to jobs, missing interview records, inconsistent placement statistics and no access control. A properly designed relational database is needed to keep the data consistent, enforce eligibility rules and generate accurate placement reports.

## 3. Objectives

1. Design a normalized (3NF) relational schema for the placement process.
2. Prevent duplicate applications and invalid placements using constraints and triggers.
3. Check student eligibility (CGPA and backlogs) against job criteria.
4. Generate reports such as department-wise placement and package statistics.
5. Provide role-based access for Admin/TPO and Student.
6. Build a web application that works on top of the same database.

## 4. Entities

| # | Entity | Purpose |
|---|---|---|
| 1 | STUDENT | Academic and contact details of a student |
| 2 | COMPANY | Recruiting company details |
| 3 | JOB_OPENING | A job posted by a company with eligibility criteria |
| 4 | APPLICATION | A student's application to a job |
| 5 | INTERVIEW | An interview round for an application |
| 6 | PLACEMENT | Final offer/placement for a selected application |
| 7 | USER_ACCOUNT | Login credentials and role (Admin or Student) |

## 5. Attributes

**STUDENT:** student_id (PK), roll_no (UK), first_name, last_name, email (UK), phone, department, course, graduation_year, cgpa, backlogs

**COMPANY:** company_id (PK), company_name (UK), industry, email, phone, website, location

**JOB_OPENING:** job_id (PK), company_id (FK), job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status

**APPLICATION:** application_id (PK), student_id (FK), job_id (FK), application_date, application_status. Unique: (student_id, job_id)

**INTERVIEW:** interview_id (PK), application_id (FK), round_number, interview_type, interview_date, interview_mode, interview_status, remarks. Unique: (application_id, round_number)

**PLACEMENT:** placement_id (PK), application_id (FK, UK), placement_date, offer_status, package_lpa, joining_date

**USER_ACCOUNT:** user_id (PK), email (UK), password_hash, role, student_id (FK, UK, NULL for Admin)

## 6. ER Diagram

See `docs/ER-Diagram.drawio` (export as `docs/ER-Diagram.png` and insert the image here).

## 7. Relationships

| Relationship | Meaning |
|---|---|
| COMPANY — JOB_OPENING | A company posts many jobs; each job belongs to one company |
| STUDENT — APPLICATION | A student submits many applications; each application belongs to one student |
| JOB_OPENING — APPLICATION | A job receives many applications; each application is for one job |
| APPLICATION — INTERVIEW | An application can have many interview rounds |
| APPLICATION — PLACEMENT | An application results in at most one placement |
| STUDENT — USER_ACCOUNT | A student has at most one login; an Admin account has no student |

STUDENT and JOB_OPENING have a many-to-many relationship, resolved through APPLICATION.

## 8. Cardinalities

| Relationship | Cardinality |
|---|---|
| COMPANY : JOB_OPENING | 1 : N |
| STUDENT : APPLICATION | 1 : N |
| JOB_OPENING : APPLICATION | 1 : N |
| APPLICATION : INTERVIEW | 1 : N |
| APPLICATION : PLACEMENT | 1 : 0..1 |
| STUDENT : USER_ACCOUNT | 1 : 0..1 |

## 9. Normalization up to 3NF

**1NF:** Every attribute holds a single atomic value and every table has a primary key. There are no repeating groups. Interview rounds are stored as separate rows, not as a list inside APPLICATION.

**2NF:** The schema is in 1NF, and no non-key attribute depends on only part of a composite key. All tables use a single-column surrogate primary key, so partial dependency cannot occur. The composite unique keys (student_id, job_id) and (application_id, round_number) are candidate keys, and the other attributes depend on the whole key.

**3NF:** The schema is in 2NF, and no non-key attribute depends on another non-key attribute. Company details are stored only in COMPANY, not repeated in JOB_OPENING. Student details are stored only in STUDENT, not repeated in APPLICATION. Placement outcome is stored in PLACEMENT, not in INTERVIEW or APPLICATION. Job criteria (minimum_cgpa, max_backlogs) depend only on job_id.

**Design note:** `package_lpa` in PLACEMENT (the final offered package) is stored separately from `salary_package` in JOB_OPENING (the advertised package), because the final offer can differ. They are different facts, so this is not redundancy.

The database is normalized up to Third Normal Form (3NF) to reduce redundancy and prevent insertion, deletion and update anomalies.

## 10. Final Relational Schema

```
STUDENT(student_id PK, roll_no UK, first_name, last_name, email UK, phone,
        department, course, graduation_year, cgpa, backlogs)

COMPANY(company_id PK, company_name UK, industry, email, phone, website, location)

JOB_OPENING(job_id PK, company_id FK->COMPANY, job_title, job_description,
            job_type, location, minimum_cgpa, max_backlogs, salary_package,
            application_deadline, job_status)

APPLICATION(application_id PK, student_id FK->STUDENT, job_id FK->JOB_OPENING,
            application_date, application_status, UNIQUE(student_id, job_id))

INTERVIEW(interview_id PK, application_id FK->APPLICATION, round_number,
          interview_type, interview_date, interview_mode, interview_status,
          remarks, UNIQUE(application_id, round_number))

PLACEMENT(placement_id PK, application_id FK->APPLICATION UK, placement_date,
          offer_status, package_lpa, joining_date)

USER_ACCOUNT(user_id PK, email UK, password_hash, role,
             student_id FK->STUDENT UK, NULL for Admin)
```

## 11. PK / FK Constraints

| Table | Primary Key | Foreign Keys |
|---|---|---|
| STUDENT | student_id | — |
| COMPANY | company_id | — |
| JOB_OPENING | job_id | company_id → COMPANY |
| APPLICATION | application_id | student_id → STUDENT, job_id → JOB_OPENING |
| INTERVIEW | interview_id | application_id → APPLICATION |
| PLACEMENT | placement_id | application_id → APPLICATION |
| USER_ACCOUNT | user_id | student_id → STUDENT |

**Check constraints:** cgpa and minimum_cgpa between 0 and 10; backlogs, max_backlogs and salary_package >= 0; round_number >= 1; package_lpa >= 0.

**Business rules for Phase 2 (procedures/triggers):** reject duplicate application; reject placement for a non-selected application; reject application when CGPA or backlogs do not meet the job criteria.
