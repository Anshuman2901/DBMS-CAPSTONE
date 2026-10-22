-- ============================================================
-- Phase 3 - Queries & Reports
-- ============================================================
USE placement_management;

-- Report 1: Company-wise application count
SELECT c.company_name, COUNT(a.application_id) AS total_applications
FROM Company c
JOIN Job_Opening j ON j.company_id = c.company_id
JOIN Application a ON a.job_id = j.job_id
GROUP BY c.company_name
ORDER BY total_applications DESC;

-- Report 2: Department-wise placement count
SELECT s.department,
       COUNT(DISTINCT p.placement_id) AS placed_count
FROM Student s
JOIN Application a ON a.student_id = s.student_id
JOIN Placement p ON p.application_id = a.application_id
GROUP BY s.department
ORDER BY placed_count DESC;

-- Report 3: Highest package offered
SELECT MAX(package_lpa) AS highest_package_lpa FROM Placement;

-- Report 4: Average package offered
SELECT ROUND(AVG(package_lpa), 2) AS average_package_lpa FROM Placement;

-- Report 5: Students not placed (LEFT JOIN)
SELECT s.student_id, s.roll_no, s.first_name, s.last_name, s.department
FROM Student s
LEFT JOIN Application a ON a.student_id = s.student_id
LEFT JOIN Placement p ON p.application_id = a.application_id
WHERE p.placement_id IS NULL
GROUP BY s.student_id, s.roll_no, s.first_name, s.last_name, s.department
ORDER BY s.department;

-- Report 6: Upcoming interviews (sorted by date)
SELECT i.interview_id, s.first_name, s.last_name, c.company_name,
       j.job_title, i.round_number, i.interview_type, i.interview_date, i.interview_mode
FROM Interview i
JOIN Application a ON a.application_id = i.application_id
JOIN Student s ON s.student_id = a.student_id
JOIN Job_Opening j ON j.job_id = a.job_id
JOIN Company c ON c.company_id = j.company_id
WHERE i.interview_status = 'Scheduled'
ORDER BY i.interview_date ASC;

-- Report 7: Selected students
SELECT s.student_id, s.first_name, s.last_name, c.company_name, j.job_title, a.application_status
FROM Application a
JOIN Student s ON s.student_id = a.student_id
JOIN Job_Opening j ON j.job_id = a.job_id
JOIN Company c ON c.company_id = j.company_id
WHERE a.application_status = 'Selected';

-- Report 8: Monthly attendance / application-style summary — applications per month
SELECT DATE_FORMAT(application_date, '%Y-%m') AS month, COUNT(*) AS total_applications
FROM Application
GROUP BY month
ORDER BY month;

-- Salary / package slip per student (one row per placement)
SELECT s.roll_no, s.first_name, s.last_name, c.company_name, j.job_title,
       p.package_lpa, p.placement_date, p.joining_date, p.offer_status
FROM Placement p
JOIN Application a ON a.application_id = p.application_id
JOIN Student s ON s.student_id = a.student_id
JOIN Job_Opening j ON j.job_id = a.job_id
JOIN Company c ON c.company_id = j.company_id
ORDER BY s.roll_no;
