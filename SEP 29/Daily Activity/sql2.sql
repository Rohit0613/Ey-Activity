create TABLE teachers(
teacher_id int auto_increment primary key,
name VARCHAR(50),
Subject_id int);

create Table Subjects(
subject_id int auto_increment primary key,
subject_name varchar(50));


INSERT INTO Subjects (subject_name) VALUES

('Mathematics'),   -- id = 1

('Science'),       -- id = 2

('English'),       -- id = 3

('History'),       -- id = 4

('Geography');     -- id = 5 (no teacher yet)

 INSERT INTO Teachers (name, subject_id) VALUES
('Rahul Sir', 1),   -- Mathematics
('Priya Madam', 2), -- Science
('Arjun Sir', NULL),-- No subject assigned
('Neha Madam', 3);  -- English

Select t.teacher_id, t.name, s.subject_name
from teachers t
inner join subjects s
on t.subject_id=s.subject_id


Select t.teacher_id, t.name, s.subject_name
from teachers t
left join subjects s
on t.subject_id=s.subject_id

Select t.teacher_id, t.name, s.subject_name
from teachers t
right join subjects s
on t.subject_id=s.subject_id

Select t.teacher_id, t.name, s.subject_name
from teachers t
left join subjects s
on t.subject_id=s.subject_id
union
Select t.teacher_id, t.name, s.subject_name
from teachers t
right join subjects s
on t.subject_id=s.subject_id