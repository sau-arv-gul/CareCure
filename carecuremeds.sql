-- drop database carecuremeds;
CREATE DATABASE CareCureMeds;
USE CareCureMeds;

-- drop table admin;
CREATE TABLE admin (
admin_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
email VARCHAR(50),
phone_no BIGINT NOT NULL
);

CREATE TABLE del_admin (
admin_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
password VARCHAR(100) NOT NULL,
email VARCHAR(50),
phone_no BIGINT NOT NULL
);

CREATE TABLE customer (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
middle_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
address VARCHAR(255)  NOT NULL,
city VARCHAR(100) NOT NULL,
state VARCHAR(50) NOT NULL,
zip INT NOT NULL,
phone_no BIGINT NOT NULL,
email VARCHAR(50),
date_of_birth DATE,
isPremium BOOLEAN NOT NULL
);

CREATE TABLE medicine (
medicine_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
amount INT NOT NULL,
price DECIMAL(10, 2) NOT NULL,
storage_conditions VARCHAR(255) NOT NULL,
expiry_date DATE NOT NULL ,
type ENUM('Tablet', 'Capsule', 'Liquid', 'Injection', 'Cream', 'Ointment', 'Drops', 'Inhaler', 'Powder', 'Other') NOT NULL,
prescription_required BOOLEAN NOT NULL
);

CREATE TABLE delivery_partner (
delivery_partner_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
Email VARCHAR(50),
Phone BIGINT NOT NULL,
locationLatitude DECIMAL(10, 8),
locationLongitude DECIMAL(11, 8)
);

CREATE TABLE reviews (
ReviewID INT AUTO_INCREMENT PRIMARY KEY,
star INT NOT NULL,
comment VARCHAR(200),
customer_id INT,
delivery_partner_id INT,
FOREIGN KEY (delivery_partner_id) REFERENCES delivery_partner(delivery_partner_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE orders (
order_id INT AUTO_INCREMENT PRIMARY KEY,
quantity INT NOT NULL,
price DECIMAL(10, 2) NOT NULL,
shipping_address VARCHAR(255) NOT NULL,
order_date DATE NOT NULL ,
order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL,
medicine_id INT,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id)
);

CREATE TABLE prescription (
prescription_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE warehouse (
warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
medicine_id INT NOT NULL,
arrival_date DATE NOT NULL,
stock INT NOT NULL,
reorder_level DECIMAL(10, 2),
location VARCHAR(100) NOT NULL,
FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id)
);

CREATE TABLE monthly_subscriptions (
customer_id INT NOT NULL,
medicine_id INT NOT NULL,
subscription_date DATE NOT NULL,
next_delivery_date DATE NOT NULL,
PRIMARY KEY (customer_id, medicine_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id)
);

CREATE TABLE premium_customers (
customer_id INT PRIMARY KEY,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
discount DECIMAL(5,2) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE payments (
transaction_id INT PRIMARY KEY AUTO_INCREMENT,
amount DECIMAL(10, 2) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
order_id INT,
customer_id INT ,
payment_status ENUM('Pending', 'Completed', 'Failed') NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE doctor (
doctor_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
degree VARCHAR(100) NOT NULL,
phone_number VARCHAR(20) NOT NULL,
age INT,
prescription_id INT NOT NULL,
FOREIGN KEY (prescription_id) REFERENCES prescription(prescription_id)
);

CREATE TABLE warehouse_admin(
warehouse_admin_id INT PRIMARY KEY AUTO_INCREMENT,
orders_pending INT NOT NULL,
orders_complete INT NOT NULL,
warehouse_id INT NOT NULL,
customer_id INT NOT NULL,
phone_no BIGINT NOT NULL,
FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);







-- 1. Lets insert 15 entries to the customer table
INSERT INTO customer (first_name, middle_name, last_name, address, city, state, zip, phone_no, email, date_of_birth, isPremium) VALUES
		('Ravi', 'Kumar', 'Sharma', '23/A, Gandhi Nagar', 'Delhi', 'DL', 110001, 9876543210, 'ravi.sharma@gmail.com', '1985-05-15', TRUE),
		('Priya', 'Singh', 'Patel', '56, Nehru Road', 'Mumbai', 'MH', 400001, 9876543211, 'priya.patel@gmail.com', '1988-07-25', FALSE),
		('Amit', 'Suresh', 'Gupta', '789, Rajaji Nagar', 'Bangalore', 'KA', 560001, 9876543212, 'amit.gupta@gmail.com', '1980-11-02', TRUE),
		('Sneha', 'Raj', 'Verma', '34, Gandhi Chowk', 'Kolkata', 'WB', 700001, 9876543213, 'sneha.verma@gmail.com', '2003-09-10', FALSE),
		('Vikram', 'Kumar', 'Singh', '12/B, Patel Lane', 'Chennai', 'TN', 600001, 9876543214, 'vikram.singh@gmail.com', '1982-04-30', TRUE),
		('Anjali', 'Rajesh', 'Rao', '45, Nehru Marg', 'Hyderabad', 'TS', 500001, 9876543215, 'anjali.rao@gmail.com', '2001-12-20', FALSE),
		('Rajesh', 'Mohan', 'Iyer', '78, Gandhi Street', 'Pune', 'MH', 411001, 9876543216, 'rajesh.iyer@gmail.com', '1986-08-05', TRUE),
		('Neha', 'Ramesh', 'Reddy', '90, Patel Nagar', 'Ahmedabad', 'GJ', 380001, 9876543217, 'neha.reddy@gmail.com', '2000-02-15', FALSE),
		('Prakash', 'Srinivas', 'Kumar', '67/A, Gandhi Lane', 'Jaipur', 'RJ', 302001, 9876543218, 'prakash.kumar@gmail.com', '1979-06-25', TRUE),
		('Sunita', 'Manoj', 'Joshi', '45, Nehru Nagar', 'Lucknow', 'UP', 226001, 9876543219, 'sunita.joshi@gmail.com', '2002-10-12', FALSE),
		('Arun', 'Kumar', 'Malhotra', '34, Patel Street', 'Chandigarh', 'CH', 160001, 9876543220, 'arun.malhotra@gmail.com', '1984-03-18', TRUE),
		('Divya', 'Raj', 'Kapoor', '23/B, Nehru Marg', 'Nagpur', 'MH', 440001, 9876543221, 'divya.kapoor@gmail.com', '2005-01-08', TRUE),
		('Manish', 'Kumar', 'Sharma', '56, Patel Lane', 'Indore', 'MP', 452001, 9876543222, 'manish.sharma@gmail.com', '1989-07-30', FALSE),
		('Preeti', 'Ramesh', 'Gandhi', '78, Nehru Street', 'Bhopal', 'MP', 462001, 9876543223, 'preeti.gandhi@gmail.com', '1981-09-22', TRUE),
		('Sanjay', 'Anil', 'Yadav', '90, Patel Chowk', 'Surat', 'GJ', 395001, 9876543224, 'sanjay.yadav@gmail.com', '2000-11-14', FALSE);

-- 2. Lets inset 15 entries to the medicine table
INSERT INTO medicine (name, amount, price, storage_conditions, expiry_date, type, prescription_required) VALUES
		('Paracetamol', 100, 5.99, 'Store in a cool, dry place', '2025-12-31', 'Tablet', FALSE),
		('Amoxicillin', 50, 8.50, 'Store in a cool, dry place', '2025-06-30', 'Capsule', TRUE),
		('Ibuprofen', 80, 7.25, 'Store in a cool, dry place', '2026-09-30', 'Tablet', FALSE),
		('Loratadine', 30, 12.75, 'Store in a cool, dry place', '2025-03-31', 'Tablet', FALSE),
		('Omeprazole', 60, 15.99, 'Store in a cool, dry place', '2025-11-30', 'Capsule', TRUE),
		('Cetirizine', 40, 6.50, 'Store in a cool, dry place', '2025-02-28', 'Tablet', FALSE),
		('Aspirin', 120, 4.99, 'Store in a cool, dry place', '2025-10-31', 'Tablet', FALSE),
		('Metformin', 90, 10.25, 'Store at room temperature', '2026-04-30', 'Tablet', TRUE),
		('Salbutamol', 50, 20.75, 'Store in a cool, dry place', '2025-08-31', 'Inhaler', TRUE),
		('Dexamethasone', 20, 18.99, 'Store in a cool, dry place', '2025-01-31', 'Tablet', TRUE),
		('Hydrocortisone', 25, 9.50, 'Store at room temperature', '2024-07-31', 'Cream', FALSE),
		('Prednisone', 15, 22.99, 'Store in a cool, dry place', '2025-05-31', 'Tablet', TRUE),
		('Ciprofloxacin', 30, 14.75, 'Store at room temperature', '2024-06-30', 'Liquid', TRUE),
		('Insulin', 10, 50.00, 'Store in a cool, dry place', '2025-12-31', 'Injection', TRUE),
		('Lidocaine', 10, 30.50, 'Store in a cool, dry place', '2026-03-31', 'Ointment', FALSE);

-- 3. Lets inset 15 entries to the delivery_partner table
INSERT INTO delivery_partner (name, Email, Phone, locationLatitude, locationLongitude)VALUES 
	   ('Ravi Kumar', 'ravi.kumar@gmail.com', 1234567890, 28.6139, 77.2090),
       ('Akshay Singh', 'akshay.singh@gmail.com', 1234567891, 19.0760, 72.8777),
       ('Suresh Patel', 'suresh.patel@gmail.com', 1234567892, 12.9716, 77.5946),
       ('Rajesh Gupta', 'rajesh.gupta@gmail.com', 1234567893, 22.5726, 88.3639),
       ('Ram Mohan', 'ram.mohan@gmail.com', 1234567894, 20.5937, 78.9629),
       ('Santosh Sharma', 'santosh.sharma@gmail.com', 1234567895, 28.5704, 77.3653),
       ('Gopal Krishna', 'gopal.krishna@gmail.com', 1234567896, 12.9771, 77.5466),
       ('Ashok Kumar', 'ashok.kumar@gmail.com', 1234567897, 19.0760, 72.8777),
       ('Prakash Singh', 'prakash.singh@gmail.com', 1234567898, 12.9716, 77.5946),
       ('Ramesh Patel', 'ramesh.patel@gmail.com', 1234567899, 18.5204, 73.8567),
       ('Rajesh Gupta', 'rajesh.gupta@gmail.com', 1234567800, 22.5726, 88.3639),
       ('Ram Mohan', 'ram.mohan@gmail.com', 1234567801, 20.5937, 77.9629),
       ('Santosh Sharma', 'santosh.sharma@gmail.com', 1234567802, 28.5704, 77.3653),
       ('Gopal Krishna', 'gopal.krishna@gmail.com', 1234567803, 12.9771, 77.5466),
       ('Ashok Kumar', 'ashok.kumar@gmail.com', 1234567804, 19.0760, 72.8777);

-- 4. Lets inset 15 entries to the review table
INSERT INTO reviews (star, comment, customer_id, delivery_partner_id)
VALUES (5, 'Great delivery service, on time and professional.', 1, 6),
       (4, 'Delivery was a bit late, but the delivery partner was very friendly', 2, 12),
       (5, 'Excellent service and very fast delivery', 3, 7),
       (5, 'Delivery partner was very professional and polite', 4, 10),
       (4, 'Delivery was on time and the delivery partner was helpful', 5, 14),
       (3, 'Delivery was a bit late, but the delivery partner was friendly', 6, 15),
       (5, 'Great delivery service, on time and professional.', 8, 9),
       (5, 'Excellent service and very fast delivery', 12, 2),
       (5, 'Delivery partner was very professional and polite', 13, 3),
       (4, 'Delivery was on time and the delivery partner was helpful', 15, 5),
       (3, 'Delivery was a bit late, but the delivery partner was friendly', 10, 1),
       (5, 'Great delivery service, on time and professional.', 7, 11),
       (5, 'Excellent service and very fast delivery', 9, 4),
       (5, 'Delivery partner was very professional and polite', 11, 8),
       (4, 'Delivery was on time and the delivery partner was helpful', 14, 13);
       
-- 5. Lets inset 15 entries to the orders table
INSERT INTO orders (quantity, price, shipping_address, order_date, order_status, medicine_id, customer_id) VALUES
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-01', 'pending', 1, 2),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-02', 'processing', 2, 3),
		(3, 200.00, '789 Main St, Bangalore, India', '2024-02-03', 'shipped', 3, 1),
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-04', 'delivered', 4, 5),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-05', 'cancelled', 5, 6),
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-06', 'pending', 6, 7),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-07', 'processing', 7, 8),
		(3, 200.00, '789 Main St, Bangalore, India', '2024-02-08', 'shipped', 8, 9),
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-09', 'delivered', 9, 10),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-10', 'cancelled', 10, 11),
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-11', 'pending', 11, 12),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-12', 'processing', 12, 13),
		(3, 200.00, '789 Main St, Bangalore, India', '2024-02-13', 'shipped', 13, 14),
		(1, 100.00, '123 Main St, Mumbai, India', '2024-02-14', 'delivered', 14, 15),
		(2, 150.00, '456 Main St, Delhi, India', '2024-02-15', 'cancelled', 15, 1);
        
-- 6. Lets inset 15 entries to the prescription table
INSERT INTO prescription (customer_id, order_id) VALUES
		(1, 2),
		(2, 3),
		(3, 4),
		(4, 5),
		(5, 6),
		(6, 7),
		(7, 8),
		(8, 9),
		(9, 10),
		(10, 11),
		(11, 12),
		(12, 13),
		(13, 14),
		(14, 15),
		(15, 1);

-- 7. Lets inset 15 entries to the warehouse table
INSERT INTO warehouse (medicine_id, arrival_date, stock, reorder_level, location) VALUES
		(1, '2024-02-01', 100, 10.00, 'Mumbai, Maharashtra, India'),
		(2, '2024-02-02', 120, 12.50, 'New Delhi, Delhi, India'),
		(3, '2024-02-03', 80, 8.00, 'Bangalore, Karnataka, India'),
		(4, '2024-02-04', 150, 15.00, 'Hyderabad, Telangana, India'),
		(5, '2024-02-05', 200, 20.00, 'Chennai, Tamil Nadu, India'),
		(6, '2024-02-06', 90, 9.00, 'Kolkata, West Bengal, India'),
		(7, '2024-02-07', 110, 11.00, 'Pune, Maharashtra, India'),
		(8, '2024-02-08', 130, 13.00, 'Ahmedabad, Gujarat, India'),
		(9, '2024-02-09', 140, 14.00, 'Surat, Gujarat, India'),
		(10, '2024-02-10', 180, 18.00, 'Jaipur, Rajasthan, India'),
		(11, '2024-02-11', 170, 17.00, 'Lucknow, Uttar Pradesh, India'),
		(12, '2024-02-12', 160, 16.00, 'Kanpur, Uttar Pradesh, India'),
		(13, '2024-02-13', 190, 19.00, 'Nagpur, Maharashtra, India'),
		(14, '2024-02-14', 175, 17.50, 'Indore, Madhya Pradesh, India'),
		(15, '2024-02-15', 165, 16.50, 'Thane, Maharashtra, India');
        
-- 8. Lets inset 15 entries to the monthly_subscriptions table
INSERT INTO monthly_subscriptions (customer_id, medicine_id, subscription_date, next_delivery_date) VALUES
		(1, 2, '2024-02-01', '2024-02-28'),
		(2, 3, '2024-02-02', '2024-02-29'),
		(3, 4, '2024-02-03', '2024-03-01'),
		(4, 5, '2024-02-04', '2024-03-02'),
		(5, 6, '2024-02-05', '2024-03-03'),
		(6, 7, '2024-02-06', '2024-03-04'),
		(7, 8, '2024-02-07', '2024-03-05'),
		(8, 9, '2024-02-08', '2024-03-06'),
		(9, 10, '2024-02-09', '2024-03-07'),
		(10, 11, '2024-02-10', '2024-03-08'),
		(11, 12, '2024-02-11', '2024-03-09'),
		(12, 13, '2024-02-12', '2024-03-10'),
		(13, 14, '2024-02-13', '2024-03-11'),
		(14, 15, '2024-02-14', '2024-03-12'),
		(15, 1, '2024-02-15', '2024-03-13');

-- 9. Lets inset 15 entries to the premium_customers table
INSERT INTO premium_customers (customer_id, start_date, end_date, discount) VALUES
		(1, '2024-02-01', '2024-02-29', 0.10),
		(2, '2024-02-02', '2024-03-31', 0.15),
		(3, '2024-02-03', '2024-04-30', 0.20),
		(4, '2024-02-04', '2024-05-31', 0.25),
		(5, '2024-02-05', '2024-06-30', 0.30),
		(6, '2024-02-06', '2024-07-31', 0.35),
		(7, '2024-02-07', '2024-08-31', 0.40),
		(8, '2024-02-08', '2024-09-30', 0.45),
		(9, '2024-02-09', '2024-10-31', 0.50),
		(10, '2024-02-10', '2024-11-30', 0.55),
		(11, '2024-02-11', '2024-12-31', 0.60),
		(12, '2024-02-12', '2025-01-31', 0.65),
		(13, '2024-02-13', '2025-02-28', 0.10),
		(14, '2024-02-14', '2025-03-31', 0.15),
		(15, '2024-02-15', '2025-04-30', 0.20);

-- 10 Lets inset 15 entries to the payments table
INSERT INTO payments (amount, payment_method, order_id, customer_id, payment_status) VALUES
    (10.00, 'Credit Card', 1, 1, 'Pending'),
    (20.00, 'PayPal', 2, 2, 'Completed'),
    (5.00, 'Cash', 3, 3, 'Completed'),
    (30.00, 'Credit Card', 4, 4, 'Pending'),
    (15.00, 'PayPal', 5, 5, 'Failed'),
    (25.00, 'Credit Card', 6, 6, 'Completed'),
    (40.00, 'PayPal', 7, 7, 'Pending'),
    (50.00, 'Cash', 8, 8, 'Completed'),
    (7.00, 'Credit Card', 9, 9, 'Completed'),
    (22.00, 'PayPal', 10, 10, 'Failed'),
    (11.00, 'Credit Card', 11, 11, 'Pending'),
    (33.00, 'PayPal', 12, 12, 'Completed'),
    (44.00, 'Cash', 13, 13, 'Pending'),
    (55.00, 'Credit Card', 14, 14, 'Failed'),
    (66.00, 'PayPal', 1, 1, 'Completed');

-- 11. Lets inset 15 entries to the doctor table
INSERT INTO doctor (name, degree, phone_number, age, prescription_id) VALUES
		('Dr. Vikram Patel', 'MD', '123-456-7890', 45, 1),
		('Dr. Jessica Sharma', 'MBBS', '234-567-8901', 38, 2),
		('Dr. Michael Kumar', 'MD', '345-678-9012', 50, 3),
		('Dr. Priya Johnson', 'MBBS', '456-789-0123', 42, 4),
		('Dr. Christopher Reddy', 'MD', '567-890-1234', 55, 5),
		('Dr. Anjali Taylor', 'MBBS', '678-901-2345', 48, 6),
		('Dr. David Gupta', 'MD', '789-012-3456', 47, 7),
		('Dr. Meera Anderson', 'MBBS', '890-123-4567', 41, 8),
		('Dr. Matthew Singh', 'MD', '901-234-5678', 53, 9),
		('Dr. Natasha Patel', 'MBBS', '012-345-6789', 39, 10),
		('Dr. Ethan Kumar', 'MD', '123-456-7890', 44, 11),
		('Dr. Ananya Lopez', 'MBBS', '234-567-8901', 36, 12),
		('Dr. Daniel Kapoor', 'MD', '345-678-9012', 49, 13),
		('Dr. Priyanka Nelson', 'MBBS', '456-789-0123', 37, 14),
		('Dr. Alexander Gupta', 'MD', '567-890-1234', 52, 15);
	
-- 12. Lets inset 15 entries to the warehouse_admin table
INSERT INTO warehouse_admin (orders_pending, orders_complete, warehouse_id, customer_id, phone_no) VALUES
		(5, 10, 1, 2, 1234567890),
		(8, 7, 2, 3, 2345678901),
		(3, 12, 3, 4, 3456789012),
		(6, 9, 4, 5, 4567890123),
		(9, 6, 5, 6, 5678901234),
		(4, 11, 6, 7, 6789012345),
		(7, 8, 7, 8, 7890123456),
		(10, 5, 8, 9, 8901234567),
		(2, 13, 9, 10, 9012345678),
		(11, 4, 10, 11, 1234567890),
		(12, 3, 11, 12, 2345678901),
		(1, 14, 12, 13, 3456789012),
		(13, 2, 13, 14, 4567890123),
		(14, 1, 14, 15, 5678901234),
		(15, 0, 15, 1, 6789012345);

-- 13. insert into admin: there are only two admin for now
INSERT INTO admin (name, password, email, phone_no)VALUES
		('Aarav Patel', 'password@1', 'admin1@gmail.com', 919876543210),
		('Priya Sharma', 'password@2', 'admin2@gmail.com', 919012345678);
    






-- 1. Lists the first name, last name, and email of customers who have placed orders for medicines that are capsules and require a prescription.
SELECT c.first_name, c.last_name,c.phone_no, c.email
FROM customer c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM orders o
    WHERE o.medicine_id IN (
        SELECT medicine_id
        FROM medicine
        WHERE type = 'Capsule'
        AND prescription_required = TRUE
    )
);


-- 2. update the review 
UPDATE reviews
SET star = 5,
    comment = 'Excellent service!'
WHERE ReviewID = 3;

--   3. insert into customer 
INSERT INTO customer (first_name, middle_name, last_name, address, city, state, zip, phone_no, email, date_of_birth, isPremium) VALUES
('Sneha', 'Anand', 'Kumar', '78, Gandhi Road', 'Bangalore', 'Karnataka', 560001, 9876543210, 'sneha.kumar@example.com', '2000-08-10', TRUE);


-- 4.  orders that are currently 'shipped' and belong to customers located in the state of Karnatka
SELECT o.order_id, o.quantity, o.price, o.shipping_address, o.order_date, o.order_status,
       c.first_name, c.last_name, c.email,
       m.name AS medicine_name, m.amount, m.price AS medicine_price
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN medicine m ON o.medicine_id = m.medicine_id
WHERE o.order_status = 'shipped'
AND c.state = 'Karnataka';

-- 5 List all medicines that have crossed their expiration date and need to be removed from the warehouse
SELECT *
FROM medicine
WHERE expiry_date < '2024-03-06';

-- 6. Give the warehouse sequence based on the stock of medicines available there
SELECT w.warehouse_id, w.location, SUM(w.stock) AS total_stock
FROM warehouse w
JOIN medicine m ON w.medicine_id = m.medicine_id
GROUP BY w.warehouse_id, w.location
ORDER BY total_stock DESC;

-- 7. Give the order id where payment is still pending
SELECT order_id
FROM payments
WHERE payment_status = 'Pending';


-- 8 Find revenue generated per month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(price) AS revenue_per_month
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');




-- 9.  Find the average rating of each delivery partner:
SELECT d.name, AVG(r.star) AS average_rating
FROM delivery_partner d
LEFT JOIN reviews r ON d.delivery_partner_id = r.delivery_partner_id
GROUP BY d.delivery_partner_id;

-- 10. Count the number of reviews for each delivery partner:
SELECT d.name, COUNT(r.ReviewID) AS num_reviews
FROM delivery_partner d
LEFT JOIN reviews r ON d.delivery_partner_id = r.delivery_partner_id
GROUP BY d.delivery_partner_id;


-- 11. Find the total amount paid by each customer:
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_amount_paid
FROM customer c
LEFT JOIN payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 12 Find the most common payment method used by customers:
SELECT payment_method, COUNT(*) AS num_transactions
FROM payments
GROUP BY payment_method
ORDER BY num_transactions DESC
LIMIT 1;



-- 13. List customers who have not made any payments yet:
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN payments p ON c.customer_id = p.customer_id
WHERE p.transaction_id IS NULL;




-- Trigger1 :  automatically store the deleted admins to del_admin table
DELIMITER $$
CREATE TRIGGER blocked_admin
BEFORE DELETE 
ON admin
FOR EACH ROW 
BEGIN
INSERT INTO del_admin (name, password, email, phone_no)
VALUE(old.name, old.password, old.email, old.phone_no);
end$$
DELIMITER 

-- check trigger1 
-- select * from admin;
-- delete from admin where admin_id = 1;
-- select * from del_admin;



-- Trigger 2: a trigger that will automatically decrease the stock of the medicine in the warehouse table when the order is marked as 'shipped':
DELIMITER //
CREATE TRIGGER update_warehouse_stock
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_status = 'shipped' THEN
        UPDATE warehouse
        SET stock = stock - NEW.quantity
        WHERE medicine_id = NEW.medicine_id;
    END IF;
END;
//

DELIMITER ;

-- Lets check the 2nd trigger

-- select * from warehouse;
-- INSERT INTO orders (quantity, price, shipping_address, order_date, order_status, medicine_id, customer_id) VALUES
-- 		(3, 100.00, '123 Main St, Mumbai, India', '2024-02-01', 'shipped', 1, 2);
-- select * from warehouse;


















