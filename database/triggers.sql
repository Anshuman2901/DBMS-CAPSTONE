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
