CREATE DATABASE IF NOT EXISTS healthcare_analytics;
USE healthcare_analytics;

CREATE TABLE IF NOT EXISTS patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    age_band VARCHAR(10) NOT NULL,
    demographic_group VARCHAR(50) NOT NULL DEFAULT 'not_specified',
    CHECK (age_band IN ('0-17', '18-39', '40-59', '60+', 'unknown'))
);

CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS visits (
    visit_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    department_id INT NOT NULL,
    visit_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE IF NOT EXISTS measurements (
    measurement_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    measurement_date DATE NOT NULL,
    measure_type VARCHAR(40) NOT NULL,
    value DOUBLE NOT NULL,
    unit VARCHAR(20) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    CHECK (value >= 0)
);

CREATE TABLE IF NOT EXISTS risk_indicators (
    indicator_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    rule_code VARCHAR(80) NOT NULL,
    indicator_value DOUBLE NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

INSERT IGNORE INTO departments (department_id, department_name) VALUES
(1, 'General'),
(2, 'Cardiology Demo'),
(3, 'Orthopedics Demo'),
(4, 'Pediatrics Demo');

-- Synthetic sample records only.
INSERT INTO patients (patient_id, age_band, demographic_group) VALUES
(1, '18-39', 'sample_group_a'),
(2, '40-59', 'sample_group_b'),
(3, '60+', 'not_specified'),
(4, '0-17', 'sample_group_a');

INSERT INTO visits (patient_id, department_id, visit_date) VALUES
(1, 1, '2026-10-01'),
(1, 2, '2026-10-07'),
(2, 1, '2026-10-03'),
(3, 3, '2026-10-08'),
(4, 4, '2026-10-10'),
(2, 2, '2026-10-12');

INSERT INTO measurements (patient_id, measurement_date, measure_type, value, unit) VALUES
(1, '2026-10-01', 'demo_score', 45, 'points'),
(1, '2026-10-07', 'demo_score', 68, 'points'),
(2, '2026-10-03', 'demo_score', 83, 'points'),
(2, '2026-10-12', 'demo_score', 76, 'points'),
(3, '2026-10-08', 'demo_score', 91, 'points'),
(4, '2026-10-10', 'demo_score', 32, 'points');
