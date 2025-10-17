
USE online_store;
GO

-- Average money spent by a customer -- 

/*
First, the total amount spent per order is calculated using a CTE.
Then, this total is used to compute the average money spent by each customer.
*/

WITH total_per_order AS (
SELECT
    SUM(od.total_price) AS total_spent_per_order,
    o.customer_ID
FROM online_store.orders AS o
INNER JOIN online_store.orders_details AS od ON od.order_ID = o.order_ID
GROUP BY od.order_ID, o.customer_ID
)

SELECT 
    customer_ID,
    AVG(total_spent_per_order) AS avg_money_spent
FROM total_per_order
GROUP BY customer_ID; 

-- Automation: Monthly avg spent by customer

/*
This script calculates and stores the average amount of money spent by each customer every month.
The results will be saved in the monthly_avg_spent table, so the first step is to create that table.
*/

CREATE TABLE online_store.monthly_avg_spent (
    id INT IDENTITY(1,1) PRIMARY KEY, -- ID column will start from 1 and increase by 1 for each new row
    month_year CHAR(7) NOT NULL,             
    customer_ID INT NOT NULL,
    avg_money_spent DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_ID) REFERENCES online_store.customers(customer_ID)
);

/*
Next, we test the query that will be automated. 
This query calculates the average amount spent by each customer during a specific month
and inserts the results into the monthly_avg_spent table.
*/

INSERT INTO online_store.monthly_avg_spent (month_year, customer_ID, avg_money_spent)
SELECT 
    FORMAT(GETDATE(), 'yyyy-MM') AS month,
    customer_ID,
    AVG(total_spent_per_order)
FROM (
    SELECT 
        o.customer_ID,
        o.order_ID,
        SUM(od.total_price) AS total_spent_per_order
    FROM online_store.orders AS o
    INNER JOIN online_store.orders_details AS od ON o.order_ID = od.order_ID
    WHERE MONTH(o.order_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) -- Using the previous month since the current one has no orders
      AND YEAR(o.order_date) = YEAR(GETDATE())
    GROUP BY o.customer_ID, o.order_ID
) AS totals
GROUP BY customer_ID;

SELECT *
FROM online_store.monthly_avg_spent; 

