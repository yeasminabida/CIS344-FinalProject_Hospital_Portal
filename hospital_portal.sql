CREATE DATABASE hospital_portal;

USE hospital_portal;

CREATE TABLE patients (
    patient_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    admission_date DATE,
    discharge_date DATE
);

   CREATE TABLE doctors (
    doctor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(40) NOT NULL,
    specialization VARCHAR(50) NOT NULL
);

CREATE TABLE appointments (
    appointment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
	FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- DATAS
INSERT INTO patients (patient_name, age, admission_date, discharge_date)
VALUES 
    ('Maria Jozef', 67, '2023-10-01', '2023-11-05'),
    ('Olivia Kai', 40, '2023-02-15', '2023-03-16'),
    ('Mila Ezra', 50, '2023-11-05', '2023-11-11');
    SELECT * FROM patients;

INSERT INTO doctors(doctor_name, specialization)
VALUES 
    ('Dr. Stephen', 'Neurologist'),
    ('Dr. William', 'Pediatrics'),
    ('Dr. Richard', 'Dermatologist');
SELECT * FROM doctors;
    

-- procedures-- 
DELIMITER //
CREATE PROCEDURE ScheduleAppointment (
	IN app_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATE,
    IN p_appointment_time DECIMAL(5,2)
    )
    
BEGIN
	INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time)
    VALUES (app_patient_id, app_doctor_id, app_appointment_date, app_appointment_time);
    
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updatePatientDetails(
    IN p_patient_id INT,
    IN p_patient_name VARCHAR(45),
    IN p_age INT,
    IN p_admission_date DATE,
    IN p_discharge_date DATE
)
BEGIN
    UPDATE patients
    SET
        patient_name = p_patient_name,
        age = p_age,
        admission_date = p_admission_date,
        discharge_date = p_discharge_date
      WHERE patient_id = p_patient_id;
END //
DELIMITER ;

-- PROCEDURE FOR DischargePatient
DELIMITER //
CREATE PROCEDURE DischargePatient(IN app_patient_id INT)
BEGIN
    UPDATE patients
    SET discharge_date = current_date() 
    WHERE patient_id = app_patient_id;
END //
DELIMITER ;



CREATE VIEW viewRecords AS
SELECT
    A.appointment_id,
    A.appointment_date,
    A.appointment_time,
    P.patient_id,
    P.patient_name,
    P.age,
    P.admission_date,
    P.discharge_date,
    D.doctor_id,
    D.doctor_name,
    D.specialization
FROM
    Appointments A
JOIN
    Patients P ON A.patient_id = P.patient_id
JOIN
    Doctors D ON A.doctor_id = D.doctor_id;
    
CALL ScheduleAppointment(65, 3, '2023-01-10', 3.30);

DELETE FROM appointments WHERE patient_id > 1;
DELETE FROM patients WHERE patient_id>3;
-- this deletes the view appointments repeating data
DELETE FROM appointments WHERE patient_id > 0; 

CALL ScheduleAppointment(1, 2, '2023-09-10', 12.20);
SELECT * FROM AppointmentView;
CALL ScheduleAppointment(2, 4, '2023-06-10', '12.30');
SELECT * FROM AppointmentView;
SELECT * FROM appointments;
CALL DischargePatient(1);

SELECT * FROM recordsview;
SELECT * FROM doctors;

CALL ScheduleAppointment(3, 6, '2023-03-10', '1.30');
CALL DischargePatient(3);
CALL DischargePatient(2);
SELECT * FROM doctors;




















