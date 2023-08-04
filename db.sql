

-----------------------DESCOMENTAR

--\c postgres
DROP DATABASE salon;
CREATE DATABASE salon;
--\c salon;
CREATE TABLE customers(
     customer_id SERIAL PRIMARY KEY,
     phone VARCHAR(20) UNIQUE NOT NULL,
     name varchar(50) NOT NULL
);

CREATE TABLE services(
     service_id SERIAL PRIMARY KEY,
     name varchar(50) NOT NULL
);

CREATE TABLE appointments(
     appointments_id SERIAL PRIMARY KEY,
     customer_id INT NOT NULL,
     service_id INT NOT NULL,
     time VARCHAR(10) NOT NULL,
     CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
     CONSTRAINT fk_services FOREIGN KEY (service_id) REFERENCES services(service_id)
);
 INSERT INTO services (name) VALUES ('cut'),('color'),('perm'),('style'),('trim');
--\c postgres