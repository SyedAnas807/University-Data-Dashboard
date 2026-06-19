-- 1. Create the Database
CREATE DATABASE UniversityDashboard;
GO
USE UniversityDashboard;
GO

-- 2. Create the Teacher Table
CREATE TABLE Teacher (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- 3. Create the Student Table
CREATE TABLE Student (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- 4. Create the Course Table
CREATE TABLE Course (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id)
);

-- 5. Create the Junction Table for Enrollments
CREATE TABLE Student_course (
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);

-- 6. Insert Mock Data: Teachers
INSERT INTO Teacher (id, name) VALUES 
(1, 'Dr. Alan Turing'),
(2, 'Dr. Ada Lovelace'),
(3, 'Prof. Grace Hopper');

-- 7. Insert Mock Data: Students
INSERT INTO Student (id, first_name, last_name) VALUES 
(1, 'John', 'Doe'),
(2, 'Alice', 'Smith'),
(3, 'Michael', 'Johnson'),
(4, 'Sarah', 'Williams'),
(5, 'David', 'Brown'),
(6, 'Emma', 'Davis'),
(7, 'James', 'Wilson'),
(8, 'Olivia', 'Taylor');

-- 8. Insert Mock Data: Courses
INSERT INTO Course (id, name, teacher_id) VALUES 
(101, 'Cloud Infrastructure', 1),
(102, 'Data Structures', 2),
(103, 'AWS Architecture', 1),
(104, 'Machine Learning', 3),
(105, 'Database Management', 2);

-- 9. Insert Mock Data: Enrollments
INSERT INTO Student_course (student_id, course_id) VALUES 
(1, 101), (1, 102), (1, 105),
(2, 101), (2, 103),
(3, 104), (3, 105),
(4, 102), (4, 104),
(5, 101), (5, 102), (5, 103),
(6, 105),
(7, 101), (7, 104),
(8, 102), (8, 103), (8, 105);