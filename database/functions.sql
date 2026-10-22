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
