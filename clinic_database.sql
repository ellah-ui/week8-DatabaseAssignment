-- This script will create a basic structure for a clinic database.
DROP DATABASE IF EXISTS clinic_management;
CREATE DATABASE clinic_management;
USE clinic_management;

-- Create a table for patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Stores patient information';

-- Insert sample data into patients table
-- Note: The phone numbers and emails are fictional and should be replaced with real data.

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES 
('Stellah', 'Angulu', '2005-07-16', 'Female', '+2547-5565-0101', 'clownone@gmail.com', '123 Sinner St'),
('Kare', 'Karim', '1997-04-25', 'Male', '+254-7259-0112', 'karekarim1@email.com', '456 Yura Ave'),
('Minayo', 'Mamisa', '2001-08-22', 'Female', '+254-1989-0722', 'minmami@email.com', '739 Hitu Ave'),
('John', 'Wick', '1990-08-22', 'Male', '+254-9534-7442', 'johnwick@email.com', '908 Tizo St');


-- Create a table for doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) COMMENT 'Stores doctor information';

-- Insert sample data into doctors table
INSERT INTO doctors (first_name, last_name, specialization, phone, email, license_number)
VALUES 
('Robert', 'Johnson', 'Cardiology', '+2547-8097-0298', 'dr.johnson@clinic.com', 'MD123456'),
('Sarah', 'Williams', 'Pediatrics', '+2547-4575-7547', 'dr.williams@clinic.com', 'MD789012'),
('Marie', 'Wena', 'Ophthalmology', '+2547-7675-0947', 'dr.marie@clinic.com', 'MD234914'),
('Peter', 'Raphael', 'Nephrology', '+2547-3129-6513', 'dr.raphael@clinic.com', 'MD634519');


-- Create a table for appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-show') DEFAULT 'Scheduled',
    reason TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    CONSTRAINT unique_doctor_timeslot UNIQUE (doctor_id, appointment_date, appointment_time)
) COMMENT 'Manages appointment scheduling';

-- Insert sample data into appointments table
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason, notes)
VALUES 
(1, 1, '2025-11-01', '09:00:00', 'Scheduled', 'Routine check-up', 'Patient is feeling well'),
(2, 2, '2025-05-22', '10:30:00', 'Scheduled', 'Follow-up visit', 'Patient has a cold'),
(3, 3, '2025-10-03', '11:00:00', 'Cancelled', 'Personal reasons', NULL),
(4, 4, '2025-07-06', '14:00:00', 'No-show', NULL, NULL);


-- Create a table for medical records
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT,
    diagnosis TEXT,
    prescription TEXT,
    notes TEXT,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
) COMMENT 'Stores patient medical history';

-- Insert sample data into medical_records table
INSERT INTO medical_records (patient_id, doctor_id, appointment_id, diagnosis, prescription, notes, record_date)
VALUES 
(1, 1, 1, 'Healthy', 'Vitamin D', 'No issues found', '2025-11-01'),
(2, 2, 2, 'Cold', 'Rest and hydration', 'Patient advised to rest', '2025-05-22'),
(3, 3, 3, 'Eye strain', 'Eye drops', 'Patient advised to reduce screen time', '2025-10-03'),
(4, 4, 4, 'Kidney stones', 'Pain relief medication', 'Patient advised to drink more water', '2025-07-06');

-- Create a table for staff
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
) COMMENT 'Non-doctor clinic personnel';

-- Insert sample data into staff table
INSERT INTO staff (first_name, last_name, role, phone, email, hire_date)
VALUES 
('Alice', 'Smith', 'Receptionist', '+2547-1234-5678', 'alicesm5@clinic.com', '2025-01-15'),
('Bob', 'Brown', 'Nurse', '+2547-2345-6789', 'bbrown4@clinic.com', '2025-02-20'),
('Charlie', 'Davis', 'Lab Technician', '+2547-3456-7890', 'charld89@clinic,com', '2025-03-25'),
('Diana', 'Evans', 'Pharmacist', '+2547-4567-8901', 'dainaE11@gmail.com', '2025-04-30');