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
