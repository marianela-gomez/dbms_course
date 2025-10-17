USE online_store;
GO

CREATE OR ALTER PROCEDURE sp_insert_monthly_avg_spent
AS
BEGIN
    DECLARE @month_year CHAR(7);
    SET @month_year = FORMAT(GETDATE(), 'yyyy-MM'); -- Month when data is inserted.

    -- Check if data for this month already exists
    IF EXISTS (SELECT 1 FROM online_store.monthly_avg_spent WHERE month_year = @month_year)
    BEGIN
        PRINT 'Data for this month already exists. No new rows inserted.';
        RETURN;
    END;

    -- Calculate total spent per order for the previous month using a CTE
    WITH total_per_order AS (
        SELECT 
            o.customer_ID,
            o.order_ID,
            SUM(od.total_price) AS total_spent_per_order
        FROM online_store.orders AS o
        INNER JOIN online_store.orders_details AS od 
            ON o.order_ID = od.order_ID
        WHERE MONTH(o.order_date) = MONTH(DATEADD(MONTH, -1, GETDATE()))
          AND YEAR(o.order_date) = YEAR(DATEADD(MONTH, -1, GETDATE()))
        GROUP BY o.customer_ID, o.order_ID
    )

    -- Insert monthly averages per customer
    INSERT INTO online_store.monthly_avg_spent (month_year, customer_ID, avg_money_spent)
    SELECT 
        @month_year AS month_year,
        customer_ID,
        AVG(total_spent_per_order) AS avg_money_spent
    FROM total_per_order
    GROUP BY customer_ID;

    PRINT 'Monthly averages inserted successfully.';
END;
GO
