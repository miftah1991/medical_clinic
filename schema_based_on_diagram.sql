-- join table table structure
CREATE TABLE patients (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL REFERENCES patients(id),
	status VARCHAR(100) NOT NULL
);

CREATE TABLE treatments (
  id INT REFERENCES medical_histories(id),
  type VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT NOT NULL,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE invoices (
  id INT REFERENCES invoice_items(invoice_id),
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  PRIMARY KEY(id)
);

CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON treatments_history (medical_history_id);
CREATE INDEX ON treatments_history (treatment_id);
