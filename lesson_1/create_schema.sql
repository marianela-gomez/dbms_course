CREATE SCHEMA IF NOT EXISTS online_store;
USE online_store ;

CREATE TABLE IF NOT EXISTS online_store.products (
  'product_ID' INT NOT NULL,
  'product_name' VARCHAR(45) NOT NULL,
  'description' TEXT NULL,
  'stock' INT NULL,
  'price' INT NULL,
  'vendor' VARCHAR(45) NULL,
  'productscol' VARCHAR(45) NULL,
  PRIMARY KEY ('product_ID'));


CREATE TABLE IF NOT EXISTS online_store.customers (
  'customer_ID' INT NOT NULL,
  'address' TEXT NOT NULL,
  'postal_code' INT NOT NULL,
  'city' VARCHAR(45) NOT NULL,
  'country' VARCHAR(45) NOT NULL,
  PRIMARY KEY ('customer_ID'));


CREATE TABLE IF NOT EXISTS online_store.orders (
  'order_ID' INT NOT NULL,
  'customer_ID' INT NOT NULL,
  'order_date' DATE NOT NULL,
  'shipped_date' DATE NOT NULL,
  'comments' TEXT NULL,
  PRIMARY KEY ('order_ID'),
  CONSTRAINT 'customer_ID'
    FOREIGN KEY ('customer_ID')
    REFERENCES online_store.customers ('customer_ID')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS online_store.order_details (
  'product_ID' INT NOT NULL,
  'order_ID' INT NOT NULL,
  'quantity' INT NOT NULL,
  'total_price' INT NOT NULL,
  PRIMARY KEY ('product_ID', 'order_ID'),
  CONSTRAINT 'product_ID'
    FOREIGN KEY ('product_ID')
    REFERENCES online_store.products ('product_ID')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'order_ID'
    FOREIGN KEY ('order_ID')
    REFERENCES online_store.orders ('order_ID')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
