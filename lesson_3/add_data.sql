USE online_store;
GO

-- Inserting data into the products table 

INSERT INTO online_store.products (
	product_ID,
	product_name,
	description,
	stock, 
	price, 
	vendor, 
	productscol) 
VALUES
(1, 'Gaming Laptop', 'High-performance laptop with RTX 4070 GPU', 25, 1800, 'TechWorld', NULL),
(2, 'Wireless Mouse', 'Ergonomic mouse with Bluetooth connectivity', 150, 35, 'PeriphCorp', NULL),
(3, 'Mechanical Keyboard', 'RGB backlit keyboard with blue switches', 80, 90, 'PeriphCorp', NULL),
(4, '27-inch Monitor', '144Hz Full HD monitor with IPS panel', 40, 220, 'DisplayMasters', NULL),
(5, 'External SSD 1TB', 'Portable SSD with USB-C connection', 60, 120, 'StorageX', NULL),
(6, 'Smartphone Stand', 'Adjustable aluminum stand for phones', 100, 20, 'GadgetPro', NULL),
(7, 'Noise Cancelling Headphones', 'Wireless headphones with ANC and mic', 35, 250, 'SoundWave', NULL),
(8, 'USB-C Hub', '7-in-1 hub with HDMI, USB 3.0, and SD reader', 70, 60, 'TechWorld', NULL),
(9, 'Webcam 1080p', 'Full HD webcam with autofocus and microphone', 55, 75, 'OptiCam', NULL),
(10, 'Gaming Chair', 'Ergonomic gaming chair with lumbar support', 20, 300, 'ComfortZone', NULL);


-- Testing update 

UPDATE online_store.products
	SET description = 
	'Durable mechanical keyboard with customizable RGB lighting, blue switches for tactile feedback, 
	and full anti-ghosting support — ideal for gaming and productivity.'
	WHERE product_ID = 3;


SELECT *
FROM online_store.products
WHERE product_ID = 3;

-- Inserting data into the customers table

INSERT INTO online_store.customers (customer_ID, address, postal_code, city, country)
VALUES
(1, '123 Main Street', 10001, 'New York', 'USA'),
(2, '45 Queen Road', 90210, 'Los Angeles', 'USA'),
(3, '78 King Avenue', 75001, 'Paris', 'France'),
(4, '12 Oxford Street', 10115, 'Berlin', 'Germany'),
(5, '200 Gran Vía', 28013, 'Madrid', 'Spain'),
(6, '8 Market Lane', 4000, 'Brisbane', 'Australia'),
(7, '55 Shinjuku', 1600022, 'Tokyo', 'Japan'),
(8, 'Via Roma 23', 00184, 'Rome', 'Italy'),
(9, '5 Regent Street', 2000, 'Sydney', 'Australia'),
(10, 'Av. Paulista 1200', 01310, 'São Paulo', 'Brazil');

SELECT *
FROM online_store.customers;

-- Inserting data into the orders table

INSERT INTO online_store.orders (order_ID, customer_ID, order_date, shipped_date, comments)
VALUES
(1, 1, '2025-09-10', '2025-09-13', 'Delivered on time'),
(2, 3, '2025-09-11', '2025-09-15', 'Requested gift wrap'),
(3, 5, '2025-09-12', '2025-09-16', NULL),
(4, 2, '2025-09-13', '2025-09-17', 'Delayed by customs'),
(5, 7, '2025-09-14', '2025-09-18', 'Customer requested invoice'),
(6, 8, '2025-09-15', '2025-09-20', NULL),
(7, 9, '2025-09-16', '2025-09-19', NULL),
(8, 10, '2025-09-18', '2025-09-21', 'Delivered early'),
(9, 4, '2025-09-20', '2025-09-25', NULL),
(10, 6, '2025-09-22', '2025-09-26', 'Repeat customer');

SELECT *
FROM online_store.orders;

-- Inserting data into the orders details table

INSERT INTO online_store.orders_details (product_ID, order_ID, quantity, total_price)
VALUES
-- Order 1
(1, 1, 1, 1800),
(2, 1, 2, 70),
(3, 1, 1, 90),

-- Order 2
(4, 2, 1, 220),
(5, 2, 2, 240),

-- Order 3
(7, 3, 1, 250),
(8, 3, 1, 60),

-- Order 4
(2, 4, 3, 105),
(9, 4, 1, 75),

-- Order 5
(3, 5, 2, 180),
(10, 5, 1, 300),

-- Order 6
(6, 6, 4, 80),

-- Order 7
(9, 7, 2, 150),
(1, 7, 1, 1800),

-- Order 8
(8, 8, 2, 120),
(5, 8, 1, 120),

-- Order 9
(4, 9, 2, 440),
(2, 9, 3, 105),

-- Order 10
(10, 10, 1, 300),
(3, 10, 1, 90);


