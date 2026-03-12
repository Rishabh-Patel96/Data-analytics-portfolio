/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics'.
    If the database already exists, it is dropped and recreated.
    It also creates the schema 'gold' and the required tables.
    
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics'
    database if it exists.
*/

-- Drop database if it exists
DROP DATABASE IF EXISTS "DataWarehouseAnalytics";

-- Create database
CREATE DATABASE "DataWarehouseAnalytics";

-- Connect to the database
-- (In psql you would run: \c DataWarehouseAnalytics)

-- Create schema
CREATE SCHEMA gold;

-- =============================================================
-- Create Dimension Tables
-- =============================================================

CREATE TABLE gold.dim_customers(
    customer_key INT,
    customer_id INT,
    customer_number TEXT,
    first_name TEXT,
    last_name TEXT,
    country TEXT,
    marital_status TEXT,
    gender TEXT,
    birthdate DATE,
    create_date DATE
);

CREATE TABLE gold.dim_products(
    product_key INT,
    product_id INT,
    product_number TEXT,
    product_name TEXT,
    category_id TEXT,
    category TEXT,
    subcategory TEXT,
    maintenance TEXT,
    cost INT,
    product_line TEXT,
    start_date DATE
);

-- =============================================================
-- Create Fact Table
-- =============================================================

CREATE TABLE gold.fact_sales(
    order_number TEXT,
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity SMALLINT,
    price INT
);

-- =============================================================
-- Load CSV Data
-- =============================================================

COPY gold.dim_customers
FROM '/absolute/path/gold.dim_customers.csv'
DELIMITER ','
CSV HEADER;

COPY gold.dim_products
FROM '/absolute/path/gold.dim_products.csv'
DELIMITER ','
CSV HEADER;

COPY gold.fact_sales
FROM '/absolute/path/gold.fact_sales.csv'
DELIMITER ','
CSV HEADER;