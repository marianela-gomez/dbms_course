USE tienda;

-- Total sales by category product -- 
SELECT 
	p.product_line,
    COALESCE(SUM(ord.quantity_ordered), 0) AS total
FROM order_details AS ord
LEFT JOIN products AS p ON ord.product_code = p.product_code
GROUP BY p.product_line;

-- Average money spent by a customer -- 
SELECT
    c.customer_name,
    COALESCE(AVG(pay.amount), 0) AS average_spent
FROM payments AS pay
LEFT JOIN customers AS c ON pay.customer_number = c.customer_number
GROUP BY pay.customer_number;

-- Bestsellers in descending order -- 
SELECT 
	p.product_name,
    SUM(quantity_ordered) AS total_sales
FROM order_details AS od
INNER JOIN products AS p ON od.product_code = p.product_code
GROUP BY od.product_code
ORDER BY total_sales DESC;


-- Clients without orders -- 
SELECT 
    customer_name
FROM customers
WHERE customer_number NOT IN (
    SELECT customer_number
    FROM orders
);