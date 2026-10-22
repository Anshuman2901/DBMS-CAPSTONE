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
