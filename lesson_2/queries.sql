USE tienda;

-- Total sales by category product -- 

/* 
The tables products and order_details are related through the product_code column, 
which is the primary key in the products table and a foreign key in order_details.
A LEFT JOIN is performed between these tables using that shared column.
Since we need to calculate the total sales by product category, 
the SELECT statement provides the product line along with the total quantity ordered for each category.
To aggregate the quantities, a GROUP BY clause is applied on the product_line column.
*/

SELECT 
	p.product_line,
    SUM(ord.quantity_ordered) AS total
FROM order_details AS ord
LEFT JOIN products AS p ON ord.product_code = p.product_code
GROUP BY p.product_line;

-- Average money spent by a customer -- 

/*
The information about customer spending is stored in the payments table. 
Since we also need to get the customer names, a LEFT JOIN is performed 
between the payments and customers tables.
Both tables share the customer_number column, which is the primary key.
The GROUP BY clause is used to aggregate the payment amounts by customer.
The COALESCE function ensures that customers with no payments show a value of 0 instead of NULL.
*/

SELECT
    c.customer_name,
    COALESCE(AVG(pay.amount), 0) AS average_spent
FROM payments AS pay
LEFT JOIN customers AS c ON pay.customer_number = c.customer_number
GROUP BY pay.customer_number;

-- Bestsellers in descending order -- 

/*
The order_details and products tables share the product_code column. 
This column is the primary key in the products table and a foreign key 
in the order_details table, where it is also part of the composite primary key.
An INNER JOIN is performed to include only those products that appear 
in the order_details table.
The GROUP BY clause is used to aggregate the total quantity ordered for each product,
and the results are sorted in descending order of total sales.
*/

SELECT 
	p.product_name,
    SUM(quantity_ordered) AS total_sales
FROM order_details AS od
INNER JOIN products AS p ON od.product_code = p.product_code
GROUP BY od.product_code
ORDER BY total_sales DESC;


-- Clients without orders -- 

/*
The customers and orders tables share the customer_number column. 
All customers are stored in the customers table, while only those who have made orders 
appear in the orders table.
The query provides customers who do not have any orders by using a 
WHERE NOT IN clause to exclude customer numbers that exist in the orders table.
*/

SELECT 
    customer_name
FROM customers
WHERE customer_number NOT IN (
    SELECT customer_number
    FROM orders
);