/*
============================================================
SQL SERVER DML
Database: BikeStores

DML:
INSERT -> add new rows
UPDATE -> change existing rows
DELETE -> remove rows

SELECT is used only to check the data.
============================================================
*/


-- ============================================================
-- 1) DATABASE
-- ============================================================

USE BikeStores;
GO


-- ============================================================
-- 2) INSERT CUSTOMERS
-- ============================================================

INSERT INTO sales_schema.customers
(
    customer_id,
    first_name,
    last_name,
    title,
    email,
    phone,
    street,
    city,
    state,
    zip_code
)
--use output to show valuse in the same inserting statment
output inserted.customer_id, inserted.city
VALUES
(1, 'Ahmed', 'Ali', 'Mr', 'ahmed@gmail.com', '01011111111',
 'Nasr City', 'Cairo', 'Cairo', '11765'),

(2, 'Mona', 'Hassan', 'Ms', 'mona@gmail.com', '01022222222',
 'Smouha', 'Alex', 'Alex', '21526'),

(3, 'Omar', 'Mahmoud', 'Mr', 'omar@gmail.com', '01033333333',
 'Heliopolis', 'Cairo', 'Cairo', '11341'),

(4, 'Sara', 'Ibrahim', 'Ms', 'sara@gmail.com', '01044444444',
 'Miami', 'Alex', 'Alex', '21611'),

(5, 'Youssef', 'Samir', 'Mr', 'youssef@gmail.com', '01055555555',
 'Maadi', 'Cairo', 'Cairo', '11742');

GO

-- Show customers
SELECT *
FROM sales_schema.customers;
GO

-- Clear customers
-- TRUNCATE TABLE sales_schema.customers;
GO


-- ============================================================
-- 3) INSERT STORES
-- ============================================================

INSERT INTO sales_schema.stores
(
    store_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
)
VALUES
('Cairo Bike Store', '0223456781', 'cairo@bikestore.com',
 'Nasr City', 'Cairo', 'Cairo', '11765'),

('Alex Bike Store', '034567821', 'alex@bikestore.com',
 'Smouha', 'Alex', 'Alex', '21526'),

('Maadi Bike Store', '0228765432', 'maadi@bikestore.com',
 'Maadi', 'Cairo', 'Cairo', '11742'),

('Heliopolis Bike Store', '0223456123', 'heliopolis@bikestore.com',
 'Heliopolis', 'Cairo', 'Cairo', '11341'),

('Miami Bike Store', '035551234', 'miami@bikestore.com',
 'Miami', 'Alex', 'Alex', '21611');
GO

-- Show stores
SELECT *
FROM sales_schema.stores;
GO

-- Clear stores
-- TRUNCATE TABLE sales_schema.stores;
GO


-- ============================================================
-- 4) INSERT STAFF
-- ============================================================

INSERT INTO sales_schema.staff
(
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    active,
    store_id,
    manager_id
)
VALUES
(1, 'Mohamed', 'Ali', 'mohamed@bikestore.com',
 '01111111111', 1, 1, NULL),

(2, 'Hany', 'Hassan', 'hany@bikestore.com',
 '01122222222', 1, 2, 1),

(3, 'Nour', 'Omar', 'nour@bikestore.com',
 '01133333333', 1, 3, 1),

(4, 'Mai', 'Ahmed', 'mai@bikestore.com',
 '01144444444', 1, 4, 2),

(5, 'Khaled', 'Samir', 'khaled@bikestore.com',
 '01155555555', 0, 5, 2);
GO

-- Show staff
SELECT *
FROM sales_schema.staff;
GO

-- Clear staff
-- TRUNCATE TABLE sales_schema.staff;
GO


-- ============================================================
-- 5) INSERT CATEGORIES
-- ============================================================

INSERT INTO production_schema.categories
(
    category_id,
    category_name
)
VALUES
(1, 'Mountain Bikes'),
(2, 'Road Bikes'),
(3, 'Electric Bikes'),
(4, 'Kids Bikes'),
(5, 'Accessories');
GO

-- Show categories
SELECT *
FROM production_schema.categories;
GO

-- Clear categories
-- TRUNCATE TABLE production_schema.categories;
GO


-- ============================================================
-- 6) INSERT BRANDS
-- ============================================================

INSERT INTO production_schema.brands
(
    brand_id,
    brand_name
)
VALUES
(1, 'Trek'),
(2, 'Giant'),
(3, 'Specialized'),
(4, 'Cannondale'),
(5, 'Scott');
GO

-- Show brands
SELECT *
FROM production_schema.brands;
GO

-- Clear brands
-- TRUNCATE TABLE production_schema.brands;
GO


-- ============================================================
-- 7) INSERT PRODUCTS
-- ============================================================

INSERT INTO production_schema.products
(
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
)
VALUES
(1, 'Trek Marlin 7', 1, 1, 2025, 1200.00),

(2, 'Giant Contend AR', 2, 2, 2025, 1500.00),

(3, 'Specialized Turbo', 3, 3, 2026, 2500.00),

(4, 'Cannondale Kids', 4, 4, 2025, 500.00),

(5, 'Scott Helmet', 5, 5, 2026, 150.00);
GO

-- Show products
SELECT *
FROM production_schema.products;
GO

-- Clear products
-- TRUNCATE TABLE production_schema.products;
GO


-- ============================================================
-- 8) INSERT ORDERS
-- ============================================================

INSERT INTO sales_schema.orders
(
    order_id,
    customer_id,
    order_status,
    required_date,
    shipped_date,
    store_id,
    staff_id
)
VALUES
(1, 1, 'Completed', null, '2026-08-08', 1, 1),

(2, 2, 'Shipped', null, '2026-08-13', 2, 2),

(3, 3, 'Processing', '2026-08-20', NULL, 3, 3),

(4, 4, 'Pending', '2026-08-25', NULL, 4, 4),

(5, 5, 'Cancelled', '2026-08-18', NULL, 5, 5);
GO

-- Show orders
SELECT *
FROM sales_schema.orders;
GO

-- Clear orders
-- TRUNCATE TABLE sales_schema.orders;
GO


-- ============================================================
-- 9) INSERT ORDER ITEMS
-- ============================================================

INSERT INTO sales_schema.order_items
(
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
)
VALUES
(1, 1, 1, 2, 1200.00, 10),

(2, 1, 2, 1, 1500.00, 5),

(3, 1, 3, 1, 2500.00, 0),

(4, 1, 4, 2, 500.00, 15),

(5, 1, 5, 3, 150.00, 20);
GO

-- Show order items
SELECT *
FROM sales_schema.order_items;
GO

-- Clear order items
-- TRUNCATE TABLE sales_schema.order_items;
GO


-- ============================================================
-- 10) INSERT STOCKS
-- ============================================================

INSERT INTO production_schema.stocks
(
    store_id,
    product_id,
    quantity
)
VALUES
(1, 1, 20),

(2, 2, 15),

(3, 3, 10),

(4, 4, 25),

(5, 5, 50);
GO

-- Show stocks
SELECT *
FROM production_schema.stocks;
GO

-- Clear stocks
-- TRUNCATE TABLE production_schema.stocks;
GO


-- ============================================================
-- 11) INSERT EXAMPLES
-- ============================================================

/*
-- Insert one row

INSERT INTO production_schema.categories
(
    category_id,
    category_name
)
VALUES
(6, 'BMX');


-- Insert without column names

INSERT INTO production_schema.categories
VALUES
(6, 'BMX');


-- Insert multiple rows

INSERT INTO production_schema.categories
VALUES
(6, 'BMX'),
(7, 'Gravel');
*/


-- ============================================================
-- 12) UPDATE
-- ============================================================

/*
UPDATE -> changes existing data.

WHERE -> chooses which rows to update.

Without WHERE -> all rows are updated.
*/


-- Update one row

UPDATE sales_schema.customers
SET first_name = 'Ali'
WHERE customer_id = 1;

SELECT *
FROM sales_schema.customers ;
GO


-- Update more than one column

UPDATE sales_schema.customers
SET
    first_name = 'Ahmed',
    last_name = 'Naser'
WHERE customer_id = 1;

SELECT *
FROM sales_schema.customers WHERE customer_id = 1 ;
GO

-- Update more than one row

/*
UPDATE production_schema.products
SET list_price = list_price + 100
WHERE category_id = 1;
*/


-- Update all rows
-- Be careful: there is no WHERE.

/*
UPDATE production_schema.products
SET list_price = list_price + 100;
*/


-- Check updated data

/*
SELECT *
FROM production_schema.products;
*/


-- ============================================================
-- 13) DELETE
-- ============================================================

/*
DELETE -> removes rows.

WHERE -> chooses which rows to delete.

Without WHERE -> all rows are deleted.
*/


-- Delete one row

/*
DELETE FROM production_schema.categories
WHERE category_id = 5;
*/


-- Delete more than one row

/*
DELETE FROM sales_schema.staff
WHERE active = 0;
*/


-- Delete all rows
-- Be careful: there is no WHERE.

/*
DELETE FROM production_schema.categories;
*/


-- Check deleted data

/*
SELECT *
FROM production_schema.categories;
*/


-- ============================================================
-- 14) DML QUICK CHEAT SHEET
-- ============================================================

/*
-- INSERT

INSERT INTO table_name
(
    column1,
    column2
)
VALUES
(
    value1,
    value2
);


-- UPDATE

UPDATE table_name
SET column1 = value1
WHERE condition;


-- DELETE

DELETE FROM table_name
WHERE condition;


-- SELECT

SELECT *
FROM table_name;


-- TRUNCATE

TRUNCATE TABLE table_name;
*/


/*
============================================================
IMPORTANT
============================================================

INSERT   -> add data
UPDATE   -> change data
DELETE   -> remove data
SELECT   -> show data
TRUNCATE -> remove all rows

WHERE -> chooses which rows are affected.

UPDATE without WHERE -> updates ALL rows.

DELETE without WHERE -> deletes ALL rows.

TRUNCATE removes all rows but keeps the table.

TRUNCATE cannot be used on a table referenced
by a FOREIGN KEY.

For this database, child tables must be cleared first.
============================================================
*/