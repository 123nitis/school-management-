drop  database school_management 
CREATE DATABASE school_management;

USE school_management;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    admission_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    CHECK (status IN ('Active', 'Inactive', 'Graduated'))
);

desc students;

CREATE TABLE student_profiles (
    student_id INT PRIMARY KEY,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    blood_group VARCHAR(5),
    guardian_name VARCHAR(100) NOT NULL,
    guardian_phone VARCHAR(15) NOT NULL,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE
);

CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    CHECK (salary IS NULL OR salary >= 0)
);

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(20) NOT NULL,
    section CHAR(1) NOT NULL,
    academic_year VARCHAR(9) NOT NULL,
    room_number VARCHAR(10),
    class_teacher_id INT,

    UNIQUE (class_name, section, academic_year),

    FOREIGN KEY (class_teacher_id)
        REFERENCES teachers(teacher_id)
        ON DELETE SET NULL
);

CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    subject_code VARCHAR(20) NOT NULL UNIQUE,
    teacher_id INT,

    FOREIGN KEY (teacher_id)
        REFERENCES teachers(teacher_id)
        ON DELETE SET NULL
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    academic_year VARCHAR(9) NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL DEFAULT 'Enrolled',

    UNIQUE (student_id, academic_year),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (class_id)
        REFERENCES classes(class_id),

    CHECK (enrollment_status IN
        ('Enrolled', 'Transferred', 'Completed'))
);


CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    subject_id INT NOT NULL,
    exam_type VARCHAR(30) NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    max_marks DECIMAL(5,2) NOT NULL DEFAULT 100,

    UNIQUE (enrollment_id, subject_id, exam_type),

    FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id),

    FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    CHECK (marks_obtained >= 0),
    CHECK (max_marks > 0),
    CHECK (marks_obtained <= max_marks)
);

INSERT INTO teachers
(first_name, last_name, email, phone, hire_date, salary)
VALUES
('Amit', 'Sharma', 'amit@school.com', '9876500001', '2022-06-01', 45000),
('Priya', 'Das', 'priya@school.com', '9876500002', '2023-04-15', 42000),
('Rahul', 'Sen', 'rahul@school.com', '9876500003', '2021-07-10', 50000);

INSERT INTO students
(first_name, last_name, gender, date_of_birth, email, phone, admission_date)
VALUES
('Aarav', 'Verma', 'Male', '2010-05-12', 'aarav@email.com', '9000000001', '2024-04-01'),
('Ananya', 'Roy', 'Female', '2011-08-20', 'ananya@email.com', '9000000002', '2024-04-01'),
('Rohan', 'Das', 'Male', '2010-12-05', 'rohan@email.com', '9000000003', '2024-04-02'),
('Priya', 'Sen', 'Female', '2011-03-17', 'priya.sen@email.com', '9000000004', '2024-04-02'),
('Arjun', 'Dey', 'Male', '2010-09-10', 'arjun@email.com', '9000000005', '2024-04-03');

INSERT INTO student_profiles
(student_id, address, city, state, blood_group, guardian_name, guardian_phone)
VALUES
(1, '12 Lake Road', 'Kolkata', 'West Bengal', 'O+', 'Raj Verma', '9110000001'),
(2, '14 Park Street', 'Kolkata', 'West Bengal', 'A+', 'Rina Roy', '9110000002'),
(3, '20 MG Road', 'Kolkata', 'West Bengal', 'B+', 'Suman Das', '9110000003'),
(4, '8 Salt Lake', 'Kolkata', 'West Bengal', 'O-', 'Mita Sen', '9110000004'),
(5, '7 New Town', 'Kolkata', 'West Bengal', 'AB+', 'Amit Dey', '9110000005');

INSERT INTO classes
(class_name, section, academic_year, room_number, class_teacher_id)
VALUES
('10', 'A', '2026-2027', '101', 1),
('10', 'B', '2026-2027', '102', 2),
('9', 'A', '2026-2027', '201', 3);

INSERT INTO subjects
(subject_name, subject_code, teacher_id)
VALUES
('Mathematics', 'MATH01', 1),
('Science', 'SCI01', 2),
('English', 'ENG01', 3),
('Computer Science', 'CS01', 1);

INSERT INTO enrollments
(student_id, class_id, enrollment_date, academic_year)
VALUES
(1, 1, '2026-04-01', '2026-2027'),
(2, 1, '2026-04-01', '2026-2027'),
(3, 2, '2026-04-01', '2026-2027'),
(4, 2, '2026-04-01', '2026-2027'),
(5, 3, '2026-04-01', '2026-2027');


INSERT INTO marks
(enrollment_id, subject_id, exam_type, marks_obtained, max_marks)
VALUES
(1, 1, 'Midterm', 85, 100),
(1, 2, 'Midterm', 78, 100),
(1, 3, 'Midterm', 90, 100),
(1, 4, 'Midterm', 95, 100),
(2, 1, 'Midterm', 92, 100),
(2, 2, 'Midterm', 88, 100),
(2, 3, 'Midterm', 84, 100),
(2, 4, 'Midterm', 96, 100),
(3, 1, 'Midterm', 65, 100),
(3, 2, 'Midterm', 72, 100),
(4, 1, 'Midterm', 75, 100),
(4, 3, 'Midterm', 89, 100),
(5, 1, 'Midterm', 55, 100),
(5, 2, 'Midterm', 61, 100);


SELECT * FROM students;
SELECT * FROM student_profiles;
SELECT * FROM teachers;
SELECT * FROM classes;
SELECT * FROM subjects;
SELECT * FROM enrollments;
SELECT * FROM marks;

SELECT first_name, last_name, email
FROM students;

SELECT *
FROM students
WHERE gender = 'Female';


SELECT *
FROM students
WHERE admission_date > '2024-04-01';

SELECT *
FROM students
WHERE first_name LIKE 'A%';

SELECT *
FROM students
WHERE student_id BETWEEN 2 AND 4;

SELECT *
FROM students
WHERE student_id IN (1, 3, 5);

SELECT student_id, first_name, last_name, status
FROM students
WHERE status = 'Active'
ORDER BY first_name ASC;

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.class_name,
    c.section
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN classes c
    ON e.class_id = c.class_id;
    
SELECT
    s.first_name,
    s.last_name,
    sub.subject_name,
    m.exam_type,
    m.marks_obtained,
    m.max_marks
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN marks m
    ON e.enrollment_id = m.enrollment_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id;
    
    
SELECT
    s.first_name,
    s.last_name,
    p.guardian_name,
    p.guardian_phone
FROM students s
JOIN student_profiles p
    ON s.student_id = p.student_id;
    
    
SELECT
    t.first_name,
    t.last_name,
    sub.subject_name
FROM teachers t
LEFT JOIN subjects sub
    ON t.teacher_id = sub.teacher_id;
    
    
SELECT
    s.first_name,
    sub.subject_name,
    m.marks_obtained
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN marks m
    ON e.enrollment_id = m.enrollment_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id
WHERE m.marks_obtained > 80;


SELECT
    s.first_name,
    sub.subject_name,
    m.marks_obtained
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN marks m
    ON e.enrollment_id = m.enrollment_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id
WHERE m.marks_obtained < 60;


SELECT
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM subjects sub
JOIN marks m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name;

SELECT
    sub.subject_name,
    MAX(m.marks_obtained) AS highest_marks
FROM subjects sub
JOIN marks m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name;

SELECT
    c.class_name,
    c.section,
    COUNT(e.student_id) AS total_students
FROM classes c
LEFT JOIN enrollments e
    ON c.class_id = e.class_id
GROUP BY c.class_id, c.class_name, c.section;

SELECT
    sub.subject_name,
    AVG(m.marks_obtained) AS average_marks
FROM subjects sub
JOIN marks m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name
HAVING AVG(m.marks_obtained) > 75;


SELECT
    s.first_name,
    sub.subject_name,
    m.marks_obtained
FROM marks m
JOIN enrollments e
    ON m.enrollment_id = e.enrollment_id
JOIN students s
    ON e.student_id = s.student_id
JOIN subjects sub
    ON m.subject_id = sub.subject_id
ORDER BY m.marks_obtained DESC
LIMIT 5;



