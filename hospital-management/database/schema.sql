-- ============================================================
-- Digital Hospital and Patient Management System
-- Database Schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- ---------------------------------------------------------
-- ADMIN (system administrator login)
-- ---------------------------------------------------------
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL
);

-- ---------------------------------------------------------
-- PATIENT
-- ---------------------------------------------------------
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    gender VARCHAR(10),
    dob DATE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- DOCTOR
-- ---------------------------------------------------------
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    consultation_fee DECIMAL(10,2) DEFAULT 500.00,
    available_from TIME DEFAULT '09:00:00',
    available_to TIME DEFAULT '17:00:00'
);

-- ---------------------------------------------------------
-- APPOINTMENT
-- Links a patient to a doctor at a specific date/time slot
-- ---------------------------------------------------------
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    visit_date DATE NOT NULL,
    visit_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'BOOKED', -- BOOKED, COMPLETED, CANCELLED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id) ON DELETE CASCADE,
    -- Prevents two appointments for the same doctor at the same date+time
    UNIQUE KEY unique_doctor_slot (doctor_id, visit_date, visit_time)
);

-- ---------------------------------------------------------
-- MEDICAL_RECORD
-- One record per completed appointment
-- ---------------------------------------------------------
CREATE TABLE medical_record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    diagnosis VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- PRESCRIPTION
-- Multiple medicines can belong to one medical record
-- ---------------------------------------------------------
CREATE TABLE prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    medicine_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration_days INT,
    cost DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (record_id) REFERENCES medical_record(record_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- BILL
-- One bill per appointment, auto-calculated from consultation + prescriptions
-- ---------------------------------------------------------
CREATE TABLE bill (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    consultation_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    medicine_charges DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'UNPAID', -- UNPAID, PAID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id) ON DELETE CASCADE
);

-- ============================================================
-- Sample seed data (optional — useful for testing/demo)
-- ============================================================

INSERT INTO admin (username, password_hash, full_name) VALUES
('admin', '$2a$10$C6UzMDM.H6dfI/f/IKcEeO3l0IhBmVn/vG1RptQeqAv3jvWNaFTvi', 'System Administrator');
-- default password for the seeded admin is: admin123

INSERT INTO doctor (name, email, password_hash, specialization, phone, consultation_fee) VALUES
('Dr. Aman Sharma', 'aman.sharma@hospital.com', '$2a$10$C6UzMDM.H6dfI/f/IKcEeO3l0IhBmVn/vG1RptQeqAv3jvWNaFTvi', 'Cardiology', '9876543210', 800.00),
('Dr. Neha Verma', 'neha.verma@hospital.com', '$2a$10$C6UzMDM.H6dfI/f/IKcEeO3l0IhBmVn/vG1RptQeqAv3jvWNaFTvi', 'Orthopedics', '9876543211', 700.00),
('Dr. Rohit Singh', 'rohit.singh@hospital.com', '$2a$10$C6UzMDM.H6dfI/f/IKcEeO3l0IhBmVn/vG1RptQeqAv3jvWNaFTvi', 'General Medicine', '9876543212', 500.00);
-- all seeded doctors also use password: admin123 (change in production)
