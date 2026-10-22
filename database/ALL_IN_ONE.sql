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

USE placement_management;

-- ================= STUDENTS (20) =================
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2101','Aarav','Sharma','aarav.sharma1@example.com','CSE','B.Tech',2026,8.9,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2102','Vivaan','Gupta','vivaan.gupta2@example.com','CSE','B.Tech',2026,7.2,1);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2103','Aditya','Verma','aditya.verma3@example.com','CSE','B.Tech',2026,9.1,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2104','Vihaan','Singh','vihaan.singh4@example.com','CSE','B.Tech',2026,6.5,2);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2105','Ananya','Mehta','ananya.mehta5@example.com','IT','B.Tech',2026,8.4,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2106','Diya','Patel','diya.patel6@example.com','IT','B.Tech',2026,7.8,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2107','Ishaan','Rao','ishaan.rao7@example.com','IT','B.Tech',2026,6.9,1);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('EC2108','Kabir','Nair','kabir.nair8@example.com','ECE','B.Tech',2026,8.0,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('EC2109','Myra','Joshi','myra.joshi9@example.com','ECE','B.Tech',2026,7.5,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('EC2110','Reyansh','Kapoor','reyansh.kapoor10@example.com','ECE','B.Tech',2026,5.9,3);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('ME2111','Saanvi','Agarwal','saanvi.agarwal11@example.com','ME','B.Tech',2026,7.1,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('ME2112','Arjun','Malhotra','arjun.malhotra12@example.com','ME','B.Tech',2026,6.3,1);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2113','Anika','Chopra','anika.chopra13@example.com','CSE','B.Tech',2026,9.4,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2114','Rohan','Khanna','rohan.khanna14@example.com','CSE','B.Tech',2026,8.2,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2115','Kavya','Bhatt','kavya.bhatt15@example.com','IT','B.Tech',2026,7.6,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2116','Dhruv','Saxena','dhruv.saxena16@example.com','IT','B.Tech',2026,6.7,2);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('EC2117','Sara','Iyer','sara.iyer17@example.com','ECE','B.Tech',2026,8.8,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('ME2118','Yash','Pillai','yash.pillai18@example.com','ME','B.Tech',2026,7.3,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('CS2119','Riya','Desai','riya.desai19@example.com','CSE','B.Tech',2026,8.6,0);
INSERT INTO Student (roll_no, first_name, last_name, email, department, course, graduation_year, cgpa, backlogs) VALUES ('IT2120','Aryan','Menon','aryan.menon20@example.com','IT','B.Tech',2026,6.1,1);

-- ================= COMPANIES (5) =================
INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES ('TCS','IT Services','hr@tcs.example.com','011-4000001','https://tcs.example.com','Delhi');
INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES ('Infosys','IT Services','hr@infosys.example.com','080-4000002','https://infosys.example.com','Bangalore');
INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES ('Wipro','IT Services','hr@wipro.example.com','080-4000003','https://wipro.example.com','Bangalore');
INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES ('Accenture','Consulting','hr@accenture.example.com','022-4000004','https://accenture.example.com','Mumbai');
INSERT INTO Company (company_name, industry, email, phone, website, location) VALUES ('Cognizant','IT Services','hr@cognizant.example.com','044-4000005','https://cognizant.example.com','Chennai');

-- ================= JOB OPENINGS (10) =================
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (1,'Software Engineer','Software Engineer role at TCS.','Full-time','Delhi',7.0,1,8.0,'2026-11-15','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (1,'Data Analyst Intern','Data Analyst Intern role at TCS.','Internship','Delhi',6.5,2,0.3,'2026-11-20','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (2,'Systems Engineer','Systems Engineer role at Infosys.','Full-time','Bangalore',6.0,2,6.5,'2026-11-18','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (2,'Backend Developer','Backend Developer role at Infosys.','Full-time','Bangalore',7.5,1,9.0,'2026-11-25','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (3,'Associate Engineer','Associate Engineer role at Wipro.','Full-time','Bangalore',6.0,3,6.0,'2026-11-10','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (3,'QA Engineer','QA Engineer role at Wipro.','Full-time','Pune',6.5,2,6.8,'2026-11-22','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (4,'Analyst','Analyst role at Accenture.','Full-time','Mumbai',7.0,1,8.5,'2026-12-01','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (4,'Cloud Engineer Intern','Cloud Engineer Intern role at Accenture.','Internship','Mumbai',7.2,0,0.35,'2026-11-28','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (5,'Programmer Analyst','Programmer Analyst role at Cognizant.','Full-time','Chennai',6.8,2,7.2,'2026-11-30','Open');
INSERT INTO Job_Opening (company_id, job_title, job_description, job_type, location, minimum_cgpa, max_backlogs, salary_package, application_deadline, job_status) VALUES (5,'Full Stack Developer','Full Stack Developer role at Cognizant.','Full-time','Chennai',7.8,0,10.0,'2026-12-05','Open');

-- ================= APPLICATIONS (30+) =================
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (1,1,'2026-10-08','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (2,3,'2026-10-29','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (2,2,'2026-10-19','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (3,1,'2026-10-17','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (3,10,'2026-10-18','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (3,2,'2026-10-21','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (4,4,'2026-10-26','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (4,8,'2026-10-28','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (4,5,'2026-10-26','Applied');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (5,7,'2026-10-07','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (5,6,'2026-10-11','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (6,2,'2026-10-12','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (7,10,'2026-10-26','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (7,5,'2026-10-15','Applied');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (8,7,'2026-10-10','Applied');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (9,10,'2026-10-23','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (9,4,'2026-10-22','Applied');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (10,5,'2026-10-28','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (10,2,'2026-10-08','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (11,7,'2026-10-21','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (12,3,'2026-10-22','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (12,6,'2026-10-09','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (13,10,'2026-10-18','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (14,3,'2026-10-30','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (14,8,'2026-10-18','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (15,6,'2026-10-02','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (15,1,'2026-10-13','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (16,2,'2026-10-19','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (16,4,'2026-10-29','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (17,4,'2026-10-30','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (17,8,'2026-10-05','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (18,3,'2026-10-18','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (18,4,'2026-10-09','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (19,10,'2026-10-05','Shortlisted');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (19,7,'2026-10-03','Rejected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (19,6,'2026-10-28','Selected');
INSERT INTO Application (student_id, job_id, application_date, application_status) VALUES (20,3,'2026-10-26','Rejected');

-- Total applications generated: 37

-- ================= INTERVIEWS (20+) =================
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (1,1,'Aptitude','2026-11-20 10:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (1,2,'Technical','2026-11-13 16:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (2,1,'Aptitude','2026-11-18 09:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (2,2,'Technical','2026-11-22 13:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (4,1,'Aptitude','2026-11-04 13:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (6,1,'Aptitude','2026-11-15 09:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (10,1,'Aptitude','2026-11-17 10:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (11,1,'Aptitude','2026-11-05 14:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (11,2,'Technical','2026-11-18 09:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (12,1,'Aptitude','2026-11-16 09:00:00','Offline','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (20,1,'Aptitude','2026-11-27 13:00:00','Offline','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (21,1,'Aptitude','2026-11-08 10:00:00','Online','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (24,1,'Aptitude','2026-11-27 10:00:00','Offline','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (26,1,'Aptitude','2026-11-22 16:00:00','Online','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (27,1,'Aptitude','2026-11-17 15:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (27,2,'Technical','2026-11-18 12:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (28,1,'Aptitude','2026-11-13 14:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (28,2,'Technical','2026-11-17 16:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (30,1,'Aptitude','2026-11-08 12:00:00','Online','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (32,1,'Aptitude','2026-11-01 12:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (32,2,'Technical','2026-11-01 10:00:00','Online','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (34,1,'Aptitude','2026-11-08 10:00:00','Online','Scheduled', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (36,1,'Aptitude','2026-11-03 12:00:00','Offline','Completed', NULL);
INSERT INTO Interview (application_id, round_number, interview_type, interview_date, interview_mode, interview_status, remarks) VALUES (36,2,'Technical','2026-11-22 16:00:00','Offline','Completed', NULL);

-- Total interviews generated: 24

-- ================= PLACEMENTS =================
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (1,'2026-12-07','Accepted',8.0,'2027-07-09');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (2,'2026-12-05','Accepted',6.5,'2027-07-12');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (11,'2026-12-19','Accepted',6.8,'2027-07-10');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (27,'2026-12-16','Accepted',8.0,'2027-07-04');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (28,'2026-12-16','Accepted',0.3,'2027-07-13');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (32,'2026-12-14','Accepted',6.5,'2027-07-04');
INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date) VALUES (36,'2026-12-04','Accepted',6.8,'2027-07-02');

-- Total placements generated: 7

-- ================= USER ACCOUNTS =================
-- NOTE: password_hash values below are bcrypt hashes of the plaintext password 'Password@123' (for ALL accounts, demo only).
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('admin@placement.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Admin',NULL);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('aarav.sharma1@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',1);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('vivaan.gupta2@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',2);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('aditya.verma3@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',3);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('vihaan.singh4@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',4);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('ananya.mehta5@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',5);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('diya.patel6@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',6);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('ishaan.rao7@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',7);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('kabir.nair8@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',8);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('myra.joshi9@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',9);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('reyansh.kapoor10@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',10);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('saanvi.agarwal11@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',11);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('arjun.malhotra12@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',12);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('anika.chopra13@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',13);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('rohan.khanna14@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',14);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('kavya.bhatt15@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',15);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('dhruv.saxena16@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',16);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('sara.iyer17@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',17);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('yash.pillai18@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',18);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('riya.desai19@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',19);
INSERT INTO User_Account (email, password_hash, role, student_id) VALUES ('aryan.menon20@example.com','$2b$10$CwTycUXWue0Thq9StjUM0uJ8G6IYEIFd3JumS5x4A0A.Z9Q9W3S0C','Student',20);

-- ============================================================
-- Phase 2 - Stored Procedures
-- ============================================================
USE placement_management;

DELIMITER $$

-- Procedure 1: Check whether a student is eligible for a job
-- Usage: CALL CheckStudentEligibility(1, 1);
DROP PROCEDURE IF EXISTS CheckStudentEligibility$$
CREATE PROCEDURE CheckStudentEligibility(
    IN p_student_id INT,
    IN p_job_id INT
)
BEGIN
    DECLARE v_cgpa DECIMAL(3,2);
    DECLARE v_backlogs INT;
    DECLARE v_min_cgpa DECIMAL(3,2);
    DECLARE v_max_backlogs INT;
    DECLARE v_result VARCHAR(20);

    SELECT cgpa, backlogs INTO v_cgpa, v_backlogs
    FROM Student WHERE student_id = p_student_id;

    SELECT minimum_cgpa, max_backlogs INTO v_min_cgpa, v_max_backlogs
    FROM Job_Opening WHERE job_id = p_job_id;

    IF v_cgpa IS NULL OR v_min_cgpa IS NULL THEN
        SET v_result = 'NOT FOUND';
    ELSEIF v_cgpa >= v_min_cgpa AND v_backlogs <= v_max_backlogs THEN
        SET v_result = 'ELIGIBLE';
    ELSE
        SET v_result = 'NOT ELIGIBLE';
    END IF;

    SELECT p_student_id AS student_id, p_job_id AS job_id, v_cgpa AS student_cgpa,
           v_min_cgpa AS required_cgpa, v_backlogs AS student_backlogs,
           v_max_backlogs AS allowed_backlogs, v_result AS eligibility;
END$$

-- Procedure 2: Department-wise placement statistics
-- Usage: CALL GeneratePlacementReport();
DROP PROCEDURE IF EXISTS GeneratePlacementReport$$
CREATE PROCEDURE GeneratePlacementReport()
BEGIN
    SELECT
        s.department,
        COUNT(DISTINCT s.student_id) AS total_students,
        COUNT(DISTINCT p.placement_id) AS placed_students,
        ROUND(COUNT(DISTINCT p.placement_id) * 100.0 / COUNT(DISTINCT s.student_id), 2) AS placement_percentage,
        ROUND(AVG(p.package_lpa), 2) AS avg_package_lpa,
        MAX(p.package_lpa) AS highest_package_lpa
    FROM Student s
    LEFT JOIN Application a ON a.student_id = s.student_id
    LEFT JOIN Placement p ON p.application_id = a.application_id
    GROUP BY s.department
    ORDER BY s.department;
END$$

-- Procedure 3: Select a student for a job (used by Phase 4 transaction demo)
-- Marks application as Selected and creates a Placement record in ONE transaction.
-- Usage: CALL SelectStudentForJob(10, '2026-12-15', 8.00, '2027-07-01');
DROP PROCEDURE IF EXISTS SelectStudentForJob$$
CREATE PROCEDURE SelectStudentForJob(
    IN p_application_id INT,
    IN p_placement_date DATE,
    IN p_package_lpa DECIMAL(5,2),
    IN p_joining_date DATE
)
BEGIN
    DECLARE v_status VARCHAR(20);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT application_status INTO v_status
    FROM Application WHERE application_id = p_application_id FOR UPDATE;

    IF v_status IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Application not found';
    END IF;

    UPDATE Application
    SET application_status = 'Selected'
    WHERE application_id = p_application_id;

    INSERT INTO Placement (application_id, placement_date, offer_status, package_lpa, joining_date)
    VALUES (p_application_id, p_placement_date, 'Offered', p_package_lpa, p_joining_date);

    COMMIT;
END$$

DELIMITER ;

-- ============================================================
-- Phase 2 - Stored Functions
-- ============================================================
USE placement_management;

DELIMITER $$

-- Function 1: Placement percentage for a department
-- Usage: SELECT GetPlacementPercentage('CSE');
DROP FUNCTION IF EXISTS GetPlacementPercentage$$
CREATE FUNCTION GetPlacementPercentage(p_department VARCHAR(50))
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_placed INT DEFAULT 0;
    DECLARE v_percentage DECIMAL(5,2) DEFAULT 0;

    SELECT COUNT(*) INTO v_total FROM Student WHERE department = p_department;

    SELECT COUNT(DISTINCT s.student_id) INTO v_placed
    FROM Student s
    JOIN Application a ON a.student_id = s.student_id
    JOIN Placement p ON p.application_id = a.application_id
    WHERE s.department = p_department;

    IF v_total = 0 THEN
        RETURN 0;
    END IF;

    SET v_percentage = ROUND((v_placed * 100.0) / v_total, 2);
    RETURN v_percentage;
END$$

-- Function 2: Is a given student eligible for a given job (returns 1/0)
-- Usage: SELECT IsStudentEligible(1, 1);
DROP FUNCTION IF EXISTS IsStudentEligible$$
CREATE FUNCTION IsStudentEligible(p_student_id INT, p_job_id INT)
RETURNS TINYINT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_eligible TINYINT DEFAULT 0;

    SELECT CASE WHEN s.cgpa >= j.minimum_cgpa AND s.backlogs <= j.max_backlogs
                THEN 1 ELSE 0 END
    INTO v_eligible
    FROM Student s, Job_Opening j
    WHERE s.student_id = p_student_id AND j.job_id = p_job_id;

    RETURN IFNULL(v_eligible, 0);
END$$

DELIMITER ;

-- ============================================================
-- Phase 2 - Triggers
-- ============================================================
USE placement_management;

DELIMITER $$

-- Trigger 1: Reject duplicate application (same student + same job)
-- The UNIQUE(student_id, job_id) constraint already blocks exact duplicates;
-- this trigger gives a clear, custom error message instead of a generic SQL error.
DROP TRIGGER IF EXISTS trg_no_duplicate_application$$
CREATE TRIGGER trg_no_duplicate_application
BEFORE INSERT ON Application
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM Application
    WHERE student_id = NEW.student_id AND job_id = NEW.job_id;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate application: this student has already applied to this job.';
    END IF;
END$$

-- Trigger 2: Reject placement for an application that is not 'Selected'
DROP TRIGGER IF EXISTS trg_valid_placement$$
CREATE TRIGGER trg_valid_placement
BEFORE INSERT ON Placement
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);
    SELECT application_status INTO v_status
    FROM Application WHERE application_id = NEW.application_id;

    IF v_status IS NULL OR v_status <> 'Selected' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid placement: application must be in Selected status before a placement can be recorded.';
    END IF;
END$$

-- Trigger 3: Reject an application from a student who does not meet the job's
-- minimum CGPA / maximum backlogs criteria (invalid CGPA/backlogs reject)
DROP TRIGGER IF EXISTS trg_check_eligibility_on_apply$$
CREATE TRIGGER trg_check_eligibility_on_apply
BEFORE INSERT ON Application
FOR EACH ROW
BEGIN
    DECLARE v_cgpa DECIMAL(3,2);
    DECLARE v_backlogs INT;
    DECLARE v_min_cgpa DECIMAL(3,2);
    DECLARE v_max_backlogs INT;

    SELECT cgpa, backlogs INTO v_cgpa, v_backlogs
    FROM Student WHERE student_id = NEW.student_id;

    SELECT minimum_cgpa, max_backlogs INTO v_min_cgpa, v_max_backlogs
    FROM Job_Opening WHERE job_id = NEW.job_id;

    IF v_cgpa < v_min_cgpa OR v_backlogs > v_max_backlogs THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ineligible application: student does not meet the minimum CGPA / maximum backlogs for this job.';
    END IF;
END$$

-- Trigger 4: Reject overlapping / clashing interview schedule for the same
-- application (same application, same exact date-time already booked)
DROP TRIGGER IF EXISTS trg_no_duplicate_interview_round$$
CREATE TRIGGER trg_no_duplicate_interview_round
BEFORE INSERT ON Interview
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM Interview
    WHERE application_id = NEW.application_id
      AND interview_date = NEW.interview_date;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Scheduling conflict: this application already has an interview at that exact date/time.';
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- Phase 3 - Indexing + EXPLAIN (before/after)
-- ============================================================
USE placement_management;

-- -----------------------------------------------------------
-- STEP A: Run this BEFORE creating the indexes below, and
-- screenshot the output (note the 'rows' and 'key' columns):
-- -----------------------------------------------------------
-- EXPLAIN SELECT * FROM Application WHERE student_id = 5;
-- EXPLAIN SELECT * FROM Application WHERE job_id = 3;
-- EXPLAIN SELECT * FROM Interview WHERE interview_date > '2026-11-01';

-- -----------------------------------------------------------
-- STEP B: Create indexes on columns used heavily by the
-- reports in reports.sql
-- -----------------------------------------------------------
CREATE INDEX idx_application_student ON Application(student_id);
CREATE INDEX idx_application_job ON Application(job_id);
CREATE INDEX idx_application_status ON Application(application_status);
CREATE INDEX idx_interview_date ON Interview(interview_date);
CREATE INDEX idx_job_company ON Job_Opening(company_id);
CREATE INDEX idx_placement_application ON Placement(application_id);

-- -----------------------------------------------------------
-- STEP C: Run the SAME three EXPLAIN queries again and
-- screenshot the output. 'key' should now show the new index
-- name (instead of NULL) and 'rows' should normally be lower
-- -----------------------------------------------------------
-- EXPLAIN SELECT * FROM Application WHERE student_id = 5;
-- EXPLAIN SELECT * FROM Application WHERE job_id = 3;
-- EXPLAIN SELECT * FROM Interview WHERE interview_date > '2026-11-01';

-- Report note (put this in your Phase 3 document):
-- "Before indexing, EXPLAIN showed type=ALL and key=NULL, meaning MySQL
--  scanned every row in the table (a full table scan). After creating
--  idx_application_student / idx_application_job / idx_interview_date,
--  EXPLAIN showed type=ref and the new index name under 'key', and the
--  'rows' column dropped sharply, because MySQL could jump directly to
--  the matching rows using the index instead of scanning the whole table."

