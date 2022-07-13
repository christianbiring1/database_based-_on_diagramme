CREATE DATABASE clinic;

CREATE TABLE patients(id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL);

CREATE TABLE medical_histories(
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INTEGER NOT NULL,
  status VARCHAR(500) NOT NULL);

CREATE TABLE treatments(id SERIAL PRIMARY KEY,
type VARCHAR(100)NOT NULL,
name VARCHAR(100) NOT NULL);

CREATE TABLE invoices(
	id SERIAL PRIMARY KEY, 
	total_amount decimal, 
	generated_at TIMESTAMP, 
	payed_at TIMESTAMP, 
	medical_history_id INT
);

CREATE TABLE invoice_items(
	id SERIAL PRIMARY KEY, 
	unit_price decimal, 
	quantity INT, 
	total_price DECIMAL, 
	invoice_id INT, 
	treatment_id INT
);

ALTER TABLE medical_histories
ADD FOREIGN KEY(patient_id)
REFERENCES patients(id);

ALTER TABLE invoices
ADD FOREIGN KEY(medical_history_id)
REFERENCES medical_histories(id);

ALTER TABLE invoice_items
ADD FOREIGN KEY(invoice_id)
REFERENCES invoices(id);

ALTER TABLE invoice_items
ADD FOREIGN KEY(treatment_id)
REFERENCES treatments(id);

-- CREATE THE JOINING TABLE FOR THE M-M RELATION TYPE
CREATE TABLE treatments_histories
(medical_history_id INT REFERENCES medical_histories(id),
treatment_id INT REFERENCES treatments(id)
);

CREATE INDEX medical_histories_patient_id ON medical_histories(patient_id);
CREATE INDEX invoices_medical_history_id ON invoices(medical_history_id);
CREATE INDEX invoice_items_treatment_id ON invoice_items(treatment_id);