-- Create database online_store 

CREATE DATABASE [online_store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'online_store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\online_store.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'online_store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\online_store_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 WITH LEDGER = OFF
GO

USE online_store;
GO 

/* 
The OBJECT_ID function takes the name of an object as the first argument and the type of object as the second argument. This function
returns an ID number, so if that number does not exist (i.e., is null), the table is created. 
*/

-- Create table products 
IF OBJECT_ID('online_store.products', 'U') IS NULL
BEGIN
    CREATE TABLE online_store.products (
        product_ID INT NOT NULL PRIMARY KEY,
        product_name VARCHAR(45) NOT NULL,
        description VARCHAR(MAX) NULL,
        stock INT NULL,
        price INT NULL,
        vendor VARCHAR(45) NULL,
        productscol VARCHAR(45) NULL
    );
END
GO

-- Create table customers 

IF OBJECT_ID('online_store.customers', 'U') IS NULL
BEGIN
    CREATE TABLE online_store.customers (
        customer_ID INT NOT NULL PRIMARY KEY,
        address VARCHAR(MAX) NOT NULL,
        postal_code INT NOT NULL,
        city VARCHAR(45) NOT NULL,
        country VARCHAR(45) NOT NULL
    );
END
GO

-- Create table orders 
IF OBJECT_ID('online_store.orders', 'U') IS NULL
BEGIN
    CREATE TABLE online_store.orders (
        order_ID INT NOT NULL PRIMARY KEY,
        customer_ID INT NOT NULL,
        order_date DATE NOT NULL,
        shipped_date DATE NULL,
        comments VARCHAR(MAX) NULL,
        CONSTRAINT FK_orders_customers FOREIGN KEY (customer_ID)
            REFERENCES online_store.customers (customer_ID)
    );
END
GO

-- Create table orders_details 
IF OBJECT_ID('online_store.orders_details', 'U') IS NULL
BEGIN
    CREATE TABLE online_store.orders_details (
        product_ID INT NOT NULL,
        order_ID INT NOT NULL,
        quantity INT NOT NULL,
        total_price INT NOT NULL,
        CONSTRAINT PK_order_details PRIMARY KEY (product_ID, order_ID),
        CONSTRAINT FK_orderdetails_products FOREIGN KEY (product_ID)
            REFERENCES online_store.products (product_ID),
        CONSTRAINT FK_orderdetails_orders FOREIGN KEY (order_ID)
            REFERENCES online_store.orders (order_ID)
    );
END
GO
