create table patients(
patient_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
gender CHAR(1),
city VARCHAR(50));

create table doctors(
doctor_id INT PRIMARY KEY,
name VARCHAR(50),
specialization VARCHAR(50),
experience INT);

create table appointments(
appointment_id INT PRIMARY KEY,
patient_id int,doctor_id int,
FOREIGN KEY(patient_id) references patients(patient_id),
FOREIGN KEY(doctor_id) references doctors(doctor_id),
appointment_date DATE,
status VARCHAR(20));

create table medicalrecords(
record_id INT PRIMARY KEY,
patient_id int,doctor_id int,
FOREIGN KEY(patient_id)  references Patients(patient_id),
FOREIGN KEY(doctor_id) references Doctors(doctor_id),
diagnosis VARCHAR(100),
treatment VARCHAR(100),
date DATE);

create table billing(
bill_id INT PRIMARY KEY,
patient_id int,
FOREIGN KEY(patient_id) references Patients(patient_id),
amount DECIMAL(10,2),
bill_date DATE,
status VARCHAR(20));

INSERT INTO Patients (patient_id, name, age, gender, city) VALUES
(1, 'Aarav Sharma', 35, 'M', 'Mumbai'),
(2, 'Diya Singh', 28, 'F', 'Delhi'),
(3, 'Vivaan Reddy', 42, 'M', 'Bengaluru'),
(4, 'Aditi Kumari', 19, 'F', 'Chennai'),
(5, 'Kabir Patel', 50, 'M', 'Ahmedabad'),
(6, 'Priya Das', 30, 'F', 'Kolkata'),
(7, 'Rohan Mehta', 25, 'M', 'Pune'),
(8, 'Ishita Rao', 60, 'F', 'Hyderabad'),
(9, 'Arjun Gupta', 12, 'M', 'Jaipur'),
(10, 'Sneha Menon', 38, 'F', 'Kochi');

INSERT INTO Doctors (doctor_id, name, specialization, experience) VALUES
(1, 'Dr. Rajesh Kumar', 'Cardiology', 10),
(2, 'Dr. Pooja Sharma', 'Orthopedics', 8),
(3, 'Dr. Amit Singh', 'Pediatrics', 15),
(4, 'Dr. Shruti Desai', 'Dermatology', 7),
(5, 'Dr. Vikram Rao', 'Neurology', 12);

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, 1, '2025-10-01', 'Scheduled'),
(2, 2, 3, '2025-10-01', 'Scheduled'),
(3, 3, 2, '2025-10-02', 'Scheduled'),
(4, 4, 4, '2025-10-02', 'Confirmed'),
(5, 5, 1, '2025-10-03', 'Scheduled'),
(6, 6, 5, '2025-10-03', 'Confirmed'),
(7, 7, 2, '2025-10-04', 'Scheduled'),
(8, 8, 3, '2025-10-04', 'Confirmed'),
(9, 9, 4, '2025-10-05', 'Scheduled'),
(10, 10, 5, '2025-10-05', 'Confirmed');

INSERT INTO MedicalRecords (record_id, patient_id, doctor_id, diagnosis, treatment, date) VALUES
(1, 1, 1, 'Hypertension', 'Medication and lifestyle changes', '2025-10-01'),
(2, 2, 3, 'Common Cold', 'Rest and fluids', '2025-10-01'),
(3, 3, 2, 'Fractured Arm', 'Cast application', '2025-10-02'),
(4, 4, 4, 'Acne', 'Topical cream and antibiotics', '2025-10-02'),
(5, 5, 1, 'Coronary Artery Disease', 'Angioplasty recommendation', '2025-10-03'),
(6, 6, 5, 'Migraine', 'Pain relievers and rest', '2025-10-03'),
(7, 7, 2, 'Knee Pain', 'Physical therapy', '2025-10-04'),
(8, 8, 3, 'Fever', 'Antipyretics and observation', '2025-10-04'),
(9, 9, 4, 'Eczema', 'Moisturizers and corticosteroids', '2025-10-05'),
(10, 10, 5, 'Epilepsy', 'Anticonvulsant medication adjustment', '2025-10-05');

INSERT INTO Billing (bill_id, patient_id, amount, bill_date, status) VALUES
(1, 1, 1500.00, '2025-10-01', 'Paid'),
(2, 2, 500.00, '2025-10-01', 'Unpaid'),
(3, 3, 3000.00, '2025-10-02', 'Paid'),
(4, 4, 750.00, '2025-10-02', 'Unpaid'),
(5, 5, 5000.00, '2025-10-03', 'Unpaid'),
(6, 6, 600.00, '2025-10-03', 'Paid'),
(7, 7, 1200.00, '2025-10-04', 'Unpaid'),
(8, 8, 400.00, '2025-10-04', 'Paid'),
(9, 9, 900.00, '2025-10-05', 'Paid'),
(10, 10, 2000.00, '2025-10-05', 'Unpaid'); 

select p.name,p.patient_id,m.doctor_id
from medicalrecords m
left join Patients p
on p.patient_id=m.patient_id
where m.doctor_id=1;


SELECT d.doctor_id, d.name as Doctor_name, p.name as Patient_Name, a.appointment_id
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p on a.patient_id=p.patient_id
ORDER BY d.doctor_id ASC, a.appointment_id ASC;

select b.patient_id,p.name,b.status
from Billing b
join Patients p on p.patient_id=b.patient_id
where b.status='Unpaid';

Delimiter $$

Create Procedure GetPatientHistory(in s_patient_id int)
Begin
select m.record_id, m.patient_id,p.name as Patient_Name,m.diagnosis, m.treatment,m.date
from Medicalrecords m
join Patients p on p.patient_id=m.patient_id
where m.patient_id=s_patient_id;
End $$
Delimiter ;
call GetPatientHistory(1)

GetDoctorAppointments(doctor_id)

Delimiter $$
Create Procedure GetDoctorAppointments3(in s_doctor_id int)
Begin
select a.appointment_id,a.doctor_id, a.patient_id,p.name as Patient_Name, d.name as Doctor_name,a.appointment_date
from Appointments a
join Patients p on p.patient_id=a.patient_id
join Doctors d on d.doctor_id=s_doctor_id
where d.doctor_id=s_doctor_id;
End $$
Delimiter ;
Call GetDoctorAppointments3(1)