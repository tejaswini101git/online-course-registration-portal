-- Online Course Registration Portal
-- MySQL schema derived from the DBMS PBL report.

CREATE DATABASE IF NOT EXISTS online_course_registration;
USE online_course_registration;

DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS waitlist;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS prerequisites;
DROP TABLE IF EXISTS course_offerings;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'FACULTY', 'ADMIN') NOT NULL,
    phone VARCHAR(15),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    roll_number VARCHAR(20) UNIQUE NOT NULL,
    semester INT NOT NULL,
    department VARCHAR(100),
    cgpa DECIMAL(3,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    department VARCHAR(100),
    designation VARCHAR(50),
    specialization VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    credits INT NOT NULL,
    department VARCHAR(100),
    description TEXT,
    semester INT NOT NULL
);

CREATE TABLE course_offerings (
    offering_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    faculty_id INT,
    semester INT NOT NULL,
    year INT NOT NULL,
    max_capacity INT NOT NULL,
    current_enrollment INT DEFAULT 0,
    schedule VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE prerequisites (
    prerequisite_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    required_course_id INT,
    min_grade VARCHAR(2) DEFAULT 'D',
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (required_course_id) REFERENCES courses(course_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    offering_id INT,
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ENROLLED', 'COMPLETED', 'DROPPED', 'FAILED') DEFAULT 'ENROLLED',
    grade VARCHAR(2),
    grade_date DATETIME,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (offering_id) REFERENCES course_offerings(offering_id)
);

CREATE TABLE waitlist (
    waitlist_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    offering_id INT,
    position INT,
    added_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('WAITING', 'PROMOTED', 'CANCELLED') DEFAULT 'WAITING',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (offering_id) REFERENCES course_offerings(offering_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    semester INT NOT NULL,
    year INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'COMPLETED', 'FAILED') DEFAULT 'PENDING',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    message TEXT,
    recipient_type ENUM('STUDENT', 'FACULTY', 'ALL'),
    urgency ENUM('NORMAL', 'URGENT') DEFAULT 'NORMAL',
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
