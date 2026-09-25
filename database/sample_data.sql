-- Demo/sample data from the academic DBMS project.
-- Password values below are deliberately non-production placeholders.
USE online_course_registration;

INSERT INTO users (name, email, password, role, phone) VALUES
('Tejaswini M', 'tejaswini@gcet.edu.in', 'DEMO_ONLY_Teju', 'STUDENT', '9876543210'),
('Vaishnavi V', 'vaishnavi@gcet.edu.in', 'DEMO_ONLY_Vaish', 'STUDENT', '9876543211'),
('Tanvi Patil', 'tanvi@gcet.edu.in', 'DEMO_ONLY_Tanvi', 'STUDENT', '9876543212'),
('Shreya N', 'shreya@gcet.edu.in', 'DEMO_ONLY_Shreya', 'STUDENT', '9876543213'),
('Dr. Arpitha K', 'arpitha@gcet.edu.in', 'DEMO_ONLY_Arpitha', 'FACULTY', '9876543214'),
('Dr. Nageswara Rao', 'nageswara@gcet.edu.in', 'DEMO_ONLY_Admin', 'ADMIN', '9876543215'),
('Arjun Reddy', 'arjun@gcet.edu.in', 'DEMO_ONLY_Arjun', 'STUDENT', '9876543216'),
('Priya Sharma', 'priya@gcet.edu.in', 'DEMO_ONLY_Priya', 'STUDENT', '9876543217'),
('Karthik Kumar', 'karthik@gcet.edu.in', 'DEMO_ONLY_Karthik', 'STUDENT', '9876543218'),
('Dr. Lakshmi Prasad', 'lakshmi@gcet.edu.in', 'DEMO_ONLY_Lakshmi', 'FACULTY', '9876543219');

INSERT INTO students (user_id, roll_number, semester, department, cgpa) VALUES
(1, '24R11A6668', 3, 'CSE-AIML', 8.5),
(2, '24R11A6699', 3, 'CSE-AIML', 9.0),
(3, '24R11A6696', 3, 'CSE-AIML', 8.7),
(4, '24R11A6676', 3, 'CSE-AIML', 8.9),
(7, '24R11A6601', 3, 'CSE-AIML', 7.8),
(8, '24R11A6602', 3, 'CSE-AIML', 8.2),
(9, '24R11A6603', 3, 'CSE-AIML', 8.0);

INSERT INTO faculty (user_id, department, designation, specialization) VALUES
(5, 'CSE-AIML', 'Associate Professor', 'Database Systems'),
(10, 'CSE-AIML', 'Professor', 'Machine Learning');

INSERT INTO courses (course_code, course_name, credits, department, description, semester) VALUES
('CS301', 'Database Management Systems', 4, 'CSE-AIML', 'Relational databases, SQL, normalization', 3),
('CS302', 'Machine Learning', 4, 'CSE-AIML', 'Supervised and unsupervised learning algorithms', 3),
('CS303', 'Web Technologies', 3, 'CSE-AIML', 'HTML, CSS, JavaScript, React', 3),
('CS304', 'Computer Networks', 4, 'CSE-AIML', 'Network protocols, OSI model', 3),
('CS305', 'Operating Systems', 4, 'CSE-AIML', 'Process management, memory management', 3),
('CS201', 'Data Structures', 4, 'CSE-AIML', 'Arrays, linked lists, trees, graphs', 2),
('CS202', 'Object Oriented Programming', 3, 'CSE-AIML', 'OOP concepts using Java', 2),
('CS401', 'Artificial Intelligence', 4, 'CSE-AIML', 'Search algorithms, knowledge representation', 4),
('CS402', 'Deep Learning', 4, 'CSE-AIML', 'Neural networks, CNNs, RNNs', 4),
('CS403', 'Cloud Computing', 3, 'CSE-AIML', 'AWS, Azure, virtualization', 4);

INSERT INTO course_offerings
(course_id, faculty_id, semester, year, max_capacity, current_enrollment, schedule) VALUES
(1, 1, 1, 2025, 60, 45, 'Mon-Wed 10:00-11:30'),
(2, 2, 1, 2025, 60, 58, 'Tue-Thu 10:00-11:30'),
(3, 1, 1, 2025, 50, 42, 'Mon-Wed 2:00-3:30'),
(4, 2, 1, 2025, 55, 50, 'Tue-Thu 2:00-3:30'),
(5, 1, 1, 2025, 60, 55, 'Wed-Fri 10:00-11:30'),
(6, 2, 1, 2025, 60, 48, 'Mon-Wed 9:00-10:30'),
(7, 1, 1, 2025, 50, 35, 'Tue-Thu 9:00-10:30'),
(8, 2, 1, 2025, 45, 40, 'Wed-Fri 2:00-3:30'),
(9, 2, 1, 2025, 50, 50, 'Mon-Wed 11:30-1:00'),
(10, 1, 1, 2025, 55, 30, 'Tue-Thu 11:30-1:00');

INSERT INTO prerequisites (course_id, required_course_id, min_grade) VALUES
(2, 6, 'C'),
(8, 2, 'B'),
(9, 2, 'B'),
(10, 1, 'C'),
(1, 6, 'C');

INSERT INTO enrollments (student_id, offering_id, status, grade) VALUES
(1, 1, 'ENROLLED', NULL),
(1, 2, 'ENROLLED', NULL),
(1, 3, 'ENROLLED', NULL),
(2, 1, 'ENROLLED', NULL),
(2, 2, 'ENROLLED', NULL),
(2, 4, 'ENROLLED', NULL),
(3, 1, 'ENROLLED', NULL),
(3, 3, 'ENROLLED', NULL),
(3, 5, 'ENROLLED', NULL),
(4, 2, 'ENROLLED', NULL),
(4, 4, 'ENROLLED', NULL),
(4, 5, 'ENROLLED', NULL),
(5, 1, 'COMPLETED', 'A'),
(5, 2, 'COMPLETED', 'B'),
(6, 3, 'ENROLLED', NULL),
(7, 4, 'ENROLLED', NULL);

INSERT INTO waitlist (student_id, offering_id, position, status) VALUES
(5, 2, 1, 'WAITING'),
(6, 2, 2, 'WAITING'),
(7, 9, 1, 'WAITING'),
(1, 9, 2, 'WAITING'),
(2, 5, 1, 'WAITING');

INSERT INTO payments (student_id, semester, year, amount, status) VALUES
(1, 1, 2025, 45000.00, 'COMPLETED'),
(2, 1, 2025, 45000.00, 'COMPLETED'),
(3, 1, 2025, 45000.00, 'COMPLETED'),
(4, 1, 2025, 45000.00, 'COMPLETED'),
(5, 1, 2025, 45000.00, 'PENDING'),
(6, 1, 2025, 45000.00, 'COMPLETED'),
(7, 1, 2025, 45000.00, 'COMPLETED');

INSERT INTO notifications (title, message, recipient_type, urgency) VALUES
('Registration Open', 'Course registration for Semester 1, 2025 is now open', 'STUDENT', 'URGENT'),
('Add/Drop Deadline', 'Last date to add/drop courses: Oct 25, 2025', 'STUDENT', 'URGENT'),
('Grade Submission', 'Faculty: Submit grades by Nov 1, 2025', 'FACULTY', 'NORMAL'),
('System Maintenance', 'Portal will be down on Oct 22 from 2-4 AM', 'ALL', 'NORMAL'),
('Payment Reminder', 'Clear pending dues before Oct 30', 'STUDENT', 'URGENT'),
('Waitlist Update', 'You have been promoted from waitlist for CS302', 'STUDENT', 'URGENT'),
('Course Cancellation', 'CS405 has been cancelled for this semester', 'ALL', 'URGENT'),
('New Course Added', 'CS406 Blockchain Technology now available', 'STUDENT', 'NORMAL'),
('Faculty Meeting', 'Department meeting on Oct 24 at 3 PM', 'FACULTY', 'NORMAL'),
('Exam Schedule', 'Mid-term exam schedule released', 'STUDENT', 'URGENT');
