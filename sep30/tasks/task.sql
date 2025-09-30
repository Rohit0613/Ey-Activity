CREATE DATABASE UniversityDB;
USE UniversityDB;
-- Students Table
CREATE TABLE Students (
student_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);
-- Courses Table
CREATE TABLE Courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(50),
credits INT
);
-- Enrollments Table
CREATE TABLE Enrollments (
enroll_id INT PRIMARY KEY,
student_id INT,
course_id INT,
grade CHAR(2),
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Insert Students
INSERT INTO Students VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Priya', 'Delhi'),
(3, 'Arjun', 'Bengaluru'),
(4, 'Neha', 'Hyderabad'),
(5, 'Vikram', 'Chennai');
-- Insert Courses
INSERT INTO Courses VALUES
(101, 'Mathematics', 4),
(102, 'Computer Science', 3),
(103, 'Economics', 2),
(104, 'History', 3);
-- Insert Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, 'A'),
(2, 1, 102, 'B'),
(3, 2, 103, 'A'),
(4, 3, 101, 'C'),
(5, 4, 102, 'B'),
(6, 5, 104, 'A');


delimiter $$

create procedure listallstudents()
begin
select student_id,name,city
from Students;
end $$

delimiter ;
call listallstudents();

delimiter $$
create procedure listallcourses()
begin
select course_id, course_name,credits
from courses;
end $$

delimiter ;
call listallcourses();



delimiter $$
create procedure findallstudents(In p_city varchar(50))
begin
select student_id,name,city
from Students
where city=p_city;
end $$

delimiter ;
call findallstudents('mumbai')

delimiter $$
create procedure studentwithcourses3()
begin
select s.student_id, s.name,s.city, c.course_name
from enrollments e
join courses c on c.course_id=e.course_id
join students s on s.student_id=e.student_id;
end $$

delimiter ;
call studentwithcourses3();

delimiter $$
create procedure studentgivencourse4(In p_course_id int)
begin
select e.student_id,e.course_id,c.course_name,s.name as students_name
from enrollments e
join students s on e.student_id=s.student_id
join courses c on e.course_id=c.course_id
where e.course_id=p_course_id;
end $$

delimiter ;
call studentgivencourse4(101)


DELIMITER $$
CREATE PROCEDURE CountStudentsInEachCourseFromEnrollments()
BEGIN
SELECT e.course_id,
COUNT(e.student_id) AS number_of_students
FROM Enrollments e
GROUP BY e.course_id;
END $$

DELIMITER ;
call CountStudentsInEachCourseFromEnrollments()


DELIMITER $$
CREATE PROCEDURE countstudenteachcourse1()
BEGIN
SELECT e.course_id,c.course_name,
COUNT(e.student_id) AS numberofstudents
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY e.course_id, c.course_name;
END$$
DELIMITER ;
call countstudenteachcourse1()



delimiter $$
create procedure studentcoursegrade1()
begin
select e.student_id,s.name as students_name,e.grade,c.course_name
from enrollments e
join students s on e.student_id=s.student_id
join courses c on e.course_id=c.course_id;
end $$

delimiter ;
call studentcoursegrade1()


delimiter $$
create procedure studentallcourse(In p_student_id int)
begin
select e.student_id,e.course_id,s.name as students_name,c.course_name
from enrollments e
join students s on e.student_id=s.student_id
join courses c on e.course_id=c.course_id
where e.student_id=p_student_id;
end $$

delimiter ;
call studentallcourse(1)