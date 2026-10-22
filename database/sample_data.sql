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
