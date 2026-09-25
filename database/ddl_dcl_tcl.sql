-- Examples of DDL, DCL and TCL covered by the project.
-- Review privileges before executing GRANT/REVOKE in a real MySQL server.

-- DDL examples:
-- CREATE TABLE ...
-- ALTER TABLE ...
-- DROP TABLE ...
-- TRUNCATE TABLE ...

-- DCL examples:
-- CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'CHANGE_ME';
-- GRANT SELECT ON online_course_registration.courses TO 'student_user'@'localhost';
-- REVOKE INSERT, UPDATE, DELETE ON online_course_registration.courses
--   FROM 'student_user'@'localhost';

-- TCL examples:
START TRANSACTION;
UPDATE payments
SET status = 'COMPLETED'
WHERE payment_id = 1;
SAVEPOINT payment_update;
COMMIT;

-- To demonstrate rollback instead:
-- START TRANSACTION;
-- UPDATE payments SET status = 'FAILED' WHERE payment_id = 1;
-- ROLLBACK;
