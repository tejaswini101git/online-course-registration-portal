-- Online Course Registration Portal: query collection
USE online_course_registration;

-- 1. Retrieve all users
SELECT * FROM users;

-- 2. Courses offered in a specific semester
SELECT c.course_code, c.course_name, u.name AS faculty_name,
       co.schedule, co.max_capacity, co.current_enrollment
FROM course_offerings co
JOIN courses c ON co.course_id = c.course_id
JOIN faculty fac ON co.faculty_id = fac.faculty_id
JOIN users u ON fac.user_id = u.user_id
WHERE co.semester = 1 AND co.year = 2025;

-- 3. Enrollments for a specific student
SELECT c.course_code, c.course_name, e.status, e.grade, co.schedule
FROM enrollments e
JOIN course_offerings co ON e.offering_id = co.offering_id
JOIN courses c ON co.course_id = c.course_id
WHERE e.student_id = 1;

-- 4. Course availability
SELECT c.course_name, co.max_capacity, co.current_enrollment,
       (co.max_capacity - co.current_enrollment) AS seats_available
FROM course_offerings co
JOIN courses c ON co.course_id = c.course_id
WHERE co.semester = 1 AND co.year = 2025;

-- 5. Prerequisites for a course
SELECT c.course_name, rc.course_name AS required_course, p.min_grade
FROM prerequisites p
JOIN courses c ON p.course_id = c.course_id
JOIN courses rc ON p.required_course_id = rc.course_id
WHERE c.course_code = 'CS302';

-- 6. Waitlist positions
SELECT s.roll_number, u.name, c.course_name, w.position, w.added_date
FROM waitlist w
JOIN students s ON w.student_id = s.student_id
JOIN users u ON s.user_id = u.user_id
JOIN course_offerings co ON w.offering_id = co.offering_id
JOIN courses c ON co.course_id = c.course_id
WHERE w.status = 'WAITING'
ORDER BY c.course_name, w.position;

-- 7. Calculate CGPA from completed grades
SELECT s.roll_number, u.name,
       ROUND(AVG(
         CASE e.grade
           WHEN 'A' THEN 10
           WHEN 'B' THEN 8
           WHEN 'C' THEN 6
           WHEN 'D' THEN 4
           WHEN 'F' THEN 0
         END
       ), 2) AS calculated_cgpa
FROM students s
JOIN users u ON s.user_id = u.user_id
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.status = 'COMPLETED' AND e.grade IS NOT NULL
GROUP BY s.student_id, s.roll_number, u.name;

-- 8. Most popular courses
SELECT c.course_code, c.course_name, c.credits, c.department,
       co.current_enrollment, co.max_capacity,
       ROUND((co.current_enrollment * 100.0 / co.max_capacity), 2) AS enrollment_percentage
FROM course_offerings co
JOIN courses c ON co.course_id = c.course_id
WHERE co.semester = 1 AND co.year = 2025
ORDER BY co.current_enrollment DESC
LIMIT 5;

-- 9. Students enrolled in a specific course
SELECT s.roll_number, u.name, u.email, e.enrollment_date, e.status
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN users u ON s.user_id = u.user_id
JOIN course_offerings co ON e.offering_id = co.offering_id
JOIN courses c ON co.course_id = c.course_id
WHERE c.course_code = 'CS301'
  AND co.semester = 1 AND co.year = 2025;

-- 10. Payment status
SELECT s.roll_number, u.name, p.semester, p.year,
       p.amount, p.payment_date, p.status
FROM payments p
JOIN students s ON p.student_id = s.student_id
JOIN users u ON s.user_id = u.user_id
WHERE p.semester = 1 AND p.year = 2025
ORDER BY p.status, s.roll_number;

-- 11. Courses with available seats
SELECT c.course_code, c.course_name, co.max_capacity,
       co.current_enrollment,
       (co.max_capacity - co.current_enrollment) AS available_seats
FROM course_offerings co
JOIN courses c ON co.course_id = c.course_id
WHERE co.current_enrollment < co.max_capacity
  AND co.semester = 1 AND co.year = 2025
ORDER BY available_seats DESC;

-- 12. Faculty teaching load
SELECT u.name AS faculty_name, f.department,
       COUNT(co.offering_id) AS courses_teaching,
       SUM(co.current_enrollment) AS total_students
FROM faculty f
JOIN users u ON f.user_id = u.user_id
JOIN course_offerings co ON f.faculty_id = co.faculty_id
WHERE co.semester = 1 AND co.year = 2025
GROUP BY f.faculty_id, u.name, f.department;

-- 13. Student prerequisite eligibility
SELECT c.course_name,
  CASE
    WHEN EXISTS (
      SELECT 1
      FROM prerequisites p
      WHERE p.course_id = c.course_id
        AND NOT EXISTS (
          SELECT 1
          FROM enrollments e2
          JOIN course_offerings co2 ON e2.offering_id = co2.offering_id
          WHERE e2.student_id = 1
            AND co2.course_id = p.required_course_id
            AND e2.status = 'COMPLETED'
            AND e2.grade IS NOT NULL
        )
    ) THEN 'Not Eligible - Prerequisites Not Met'
    ELSE 'Eligible'
  END AS eligibility_status
FROM courses c
WHERE c.course_code = 'CS302';

-- 14. Semester-wise enrollment report
SELECT co.semester, co.year,
       COUNT(DISTINCT e.student_id) AS total_students,
       COUNT(e.enrollment_id) AS total_enrollments,
       ROUND(AVG(co.current_enrollment), 2) AS avg_class_size
FROM enrollments e
JOIN course_offerings co ON e.offering_id = co.offering_id
GROUP BY co.semester, co.year
ORDER BY co.year DESC, co.semester DESC;

-- 15. Students with pending payments
SELECT s.roll_number, u.name, u.email, u.phone,
       p.semester, p.year, p.amount
FROM payments p
JOIN students s ON p.student_id = s.student_id
JOIN users u ON s.user_id = u.user_id
WHERE p.status = 'PENDING'
ORDER BY s.roll_number;
