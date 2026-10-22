-- ============================================================
-- Student Placement & Recruitment Management System
-- Phase 2 - DDL (Final Approved Phase 1 Schema)
-- ============================================================

DROP DATABASE IF EXISTS placement_management;
CREATE DATABASE placement_management;
USE placement_management;

-- 1. STUDENT
CREATE TABLE Student (
    student_id        INT PRIMARY KEY AUTO_INCREMENT,
    roll_no            VARCHAR(20) UNIQUE NOT NULL,
    first_name         VARCHAR(50) NOT NULL,
    last_name          VARCHAR(50),
    email              VARCHAR(100) UNIQUE NOT NULL,
    phone              VARCHAR(15),
    department         VARCHAR(50) NOT NULL,
    course             VARCHAR(50),
    graduation_year    INT NOT NULL,
    cgpa               DECIMAL(3,2) NOT NULL,
    backlogs           INT DEFAULT 0,
    CONSTRAINT chk_student_cgpa CHECK (cgpa >= 0 AND cgpa <= 10),
    CONSTRAINT chk_student_backlogs CHECK (backlogs >= 0)
);

-- 2. COMPANY
CREATE TABLE Company (
    company_id     INT PRIMARY KEY AUTO_INCREMENT,
    company_name   VARCHAR(100) UNIQUE NOT NULL,
    industry       VARCHAR(50),
    email          VARCHAR(100),
    phone          VARCHAR(15),
    website        VARCHAR(150),
    location       VARCHAR(100)
);

-- 3. JOB_OPENING
CREATE TABLE Job_Opening (
    job_id                INT PRIMARY KEY AUTO_INCREMENT,
    company_id            INT NOT NULL,
    job_title             VARCHAR(100) NOT NULL,
    job_description       TEXT,
    job_type              VARCHAR(30) DEFAULT 'Full-time',
    location              VARCHAR(100),
    minimum_cgpa          DECIMAL(3,2) DEFAULT 0,
    max_backlogs          INT DEFAULT 0,
    salary_package        DECIMAL(5,2) DEFAULT 0,
    application_deadline  DATE NOT NULL,
    job_status            VARCHAR(20) DEFAULT 'Open',
    CONSTRAINT fk_job_company FOREIGN KEY (company_id)
        REFERENCES Company(company_id) ON DELETE CASCADE,
    CONSTRAINT chk_job_mincgpa CHECK (minimum_cgpa >= 0 AND minimum_cgpa <= 10),
    CONSTRAINT chk_job_maxbacklogs CHECK (max_backlogs >= 0),
    CONSTRAINT chk_job_package CHECK (salary_package >= 0)
);

-- 4. APPLICATION
CREATE TABLE Application (
    application_id      INT PRIMARY KEY AUTO_INCREMENT,
    student_id           INT NOT NULL,
    job_id                INT NOT NULL,
    application_date     DATE NOT NULL,
    application_status   VARCHAR(20) DEFAULT 'Applied',
    CONSTRAINT fk_app_student FOREIGN KEY (student_id)
        REFERENCES Student(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_app_job FOREIGN KEY (job_id)
        REFERENCES Job_Opening(job_id) ON DELETE CASCADE,
    CONSTRAINT uq_app_student_job UNIQUE (student_id, job_id)
);

-- 5. INTERVIEW
CREATE TABLE Interview (
    interview_id       INT PRIMARY KEY AUTO_INCREMENT,
    application_id      INT NOT NULL,
    round_number        INT NOT NULL,
    interview_type       VARCHAR(30),
    interview_date       DATETIME NOT NULL,
    interview_mode       VARCHAR(20),
    interview_status     VARCHAR(20) DEFAULT 'Scheduled',
    remarks              VARCHAR(255),
    CONSTRAINT fk_interview_app FOREIGN KEY (application_id)
        REFERENCES Application(application_id) ON DELETE CASCADE,
    CONSTRAINT uq_interview_app_round UNIQUE (application_id, round_number),
    CONSTRAINT chk_round_number CHECK (round_number >= 1)
);

-- 6. PLACEMENT
CREATE TABLE Placement (
    placement_id     INT PRIMARY KEY AUTO_INCREMENT,
    application_id    INT NOT NULL UNIQUE,
    placement_date     DATE NOT NULL,
    offer_status       VARCHAR(20) DEFAULT 'Offered',
    package_lpa        DECIMAL(5,2),
    joining_date       DATE,
    CONSTRAINT fk_placement_app FOREIGN KEY (application_id)
        REFERENCES Application(application_id) ON DELETE CASCADE,
    CONSTRAINT chk_placement_package CHECK (package_lpa >= 0)
);

-- 7. USER_ACCOUNT (login + RBAC)
CREATE TABLE User_Account (
    user_id         INT PRIMARY KEY AUTO_INCREMENT,
    email           VARCHAR(100) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    role            VARCHAR(10) NOT NULL,
    student_id      INT UNIQUE,
    CONSTRAINT fk_user_student FOREIGN KEY (student_id)
        REFERENCES Student(student_id) ON DELETE CASCADE,
    CONSTRAINT chk_user_role CHECK (role IN ('Admin','Student'))
);
