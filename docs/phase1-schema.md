# Phase 1 — Final Schema (LOCKED after approval)

## 1. STUDENT
| Column | Type | Constraint |
|---|---|---|
| student_id | INT | PK, AUTO_INCREMENT |
| roll_no | VARCHAR(20) | UNIQUE, NOT NULL |
| first_name | VARCHAR(50) | NOT NULL |
| last_name | VARCHAR(50) | |
| email | VARCHAR(100) | UNIQUE, NOT NULL |
| phone | VARCHAR(15) | |
| department | VARCHAR(50) | NOT NULL |
| course | VARCHAR(50) | |
| graduation_year | INT | NOT NULL |
| cgpa | DECIMAL(3,2) | CHECK (0 to 10) |
| backlogs | INT | DEFAULT 0, CHECK (>= 0) |

## 2. COMPANY
| Column | Type | Constraint |
|---|---|---|
| company_id | INT | PK, AUTO_INCREMENT |
| company_name | VARCHAR(100) | UNIQUE, NOT NULL |
| industry | VARCHAR(50) | |
| email | VARCHAR(100) | |
| phone | VARCHAR(15) | |
| website | VARCHAR(150) | |
| location | VARCHAR(100) | |

## 3. JOB_OPENING
| Column | Type | Constraint |
|---|---|---|
| job_id | INT | PK, AUTO_INCREMENT |
| company_id | INT | FK -> COMPANY(company_id), NOT NULL |
| job_title | VARCHAR(100) | NOT NULL |
| job_description | TEXT | |
| job_type | VARCHAR(30) | (Full-time / Internship) |
| location | VARCHAR(100) | |
| minimum_cgpa | DECIMAL(3,2) | CHECK (0 to 10) |
| max_backlogs | INT | DEFAULT 0, CHECK (>= 0) |
| salary_package | DECIMAL(5,2) | CHECK (>= 0), in LPA |
| application_deadline | DATE | NOT NULL |
| job_status | VARCHAR(20) | DEFAULT 'Open' (Open / Closed) |

## 4. APPLICATION
| Column | Type | Constraint |
|---|---|---|
| application_id | INT | PK, AUTO_INCREMENT |
| student_id | INT | FK -> STUDENT(student_id), NOT NULL |
| job_id | INT | FK -> JOB_OPENING(job_id), NOT NULL |
| application_date | DATE | NOT NULL |
| application_status | VARCHAR(20) | DEFAULT 'Applied' (Applied / Shortlisted / Rejected / Selected) |
| | | UNIQUE (student_id, job_id) |

## 5. INTERVIEW
| Column | Type | Constraint |
|---|---|---|
| interview_id | INT | PK, AUTO_INCREMENT |
| application_id | INT | FK -> APPLICATION(application_id), NOT NULL |
| round_number | INT | NOT NULL, CHECK (>= 1) |
| interview_type | VARCHAR(30) | (Technical / HR / Aptitude) |
| interview_date | DATETIME | NOT NULL |
| interview_mode | VARCHAR(20) | (Online / Offline) |
| interview_status | VARCHAR(20) | DEFAULT 'Scheduled' |
| remarks | VARCHAR(255) | |
| | | UNIQUE (application_id, round_number) |

## 6. PLACEMENT
| Column | Type | Constraint |
|---|---|---|
| placement_id | INT | PK, AUTO_INCREMENT |
| application_id | INT | FK -> APPLICATION(application_id), UNIQUE, NOT NULL |
| placement_date | DATE | NOT NULL |
| offer_status | VARCHAR(20) | DEFAULT 'Offered' (Offered / Accepted / Declined) |
| package_lpa | DECIMAL(5,2) | CHECK (>= 0) |
| joining_date | DATE | |

## 7. USER_ACCOUNT
| Column | Type | Constraint |
|---|---|---|
| user_id | INT | PK, AUTO_INCREMENT |
| email | VARCHAR(100) | UNIQUE, NOT NULL |
| password_hash | VARCHAR(255) | NOT NULL |
| role | VARCHAR(10) | NOT NULL (Admin / Student) |
| student_id | INT | FK -> STUDENT(student_id), UNIQUE, NULL for Admin |

## Relationships and Cardinality
- COMPANY 1 ---- N JOB_OPENING
- STUDENT 1 ---- N APPLICATION
- JOB_OPENING 1 ---- N APPLICATION
- APPLICATION 1 ---- N INTERVIEW
- APPLICATION 1 ---- 0..1 PLACEMENT
- STUDENT 1 ---- 0..1 USER_ACCOUNT