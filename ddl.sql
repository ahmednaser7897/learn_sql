/*
============================================================
SQL SERVER DDL
Database: BikeStores

DDL:
CREATE    -> create database / schema / table
ALTER     -> change table / column / constraint
DROP      -> delete database / table / constraint
TRUNCATE  -> delete all rows but keep table
============================================================
*/


-- ============================================================
-- 1) DATABASE
-- ============================================================

USE master;
GO

-- Create database if it does not exist
IF DB_ID(N'BikeStores') IS NULL
BEGIN
    CREATE DATABASE BikeStores;
END;
GO

-- Move to BikeStores database
USE BikeStores;
GO


/*
-- Delete and create database again
-- WARNING: this deletes all data

USE master;
GO

IF DB_ID(N'BikeStores') IS NOT NULL
BEGIN
    ALTER DATABASE BikeStores SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BikeStores;
END;
GO

CREATE DATABASE BikeStores;
GO

USE BikeStores;
GO
*/


-- ============================================================
-- 2) SCHEMAS
-- ============================================================

-- Schema = group of related tables

IF SCHEMA_ID(N'sales_schema') IS NULL
    EXEC(N'CREATE SCHEMA sales_schema');
GO

IF SCHEMA_ID(N'production_schema') IS NULL
    EXEC(N'CREATE SCHEMA production_schema');
GO


/*
-- Delete schema
-- Schema must be empty first

DROP SCHEMA sales_schema;
DROP SCHEMA production_schema;
*/


-- ============================================================
-- 3) IF OBJECT_ID(...) IS NULL
-- ============================================================

/*
IF OBJECT_ID(N'schema.table', N'U') IS NULL

OBJECT_ID() -> checks if the object exists
N'schema.table' -> schema + table name
N'U' -> User Table
IS NULL -> table does not exist
BEGIN ... END -> code to run if it does not exist

Simple meaning:
"Create the table only if it does not already exist."

GO -> ends the SQL batch
*/


-- ============================================================
-- 4) TABLES
-- ============================================================


-- ============================================================
-- 4.1 CUSTOMERS
-- ============================================================

IF OBJECT_ID(N'sales_schema.customers', N'U') IS NULL
BEGIN

    CREATE TABLE sales_schema.customers
    (
        customer_id INT PRIMARY KEY, -- PRIMARY KEY = unique + not null

        first_name VARCHAR(20) NOT NULL, -- NOT NULL = value is required

        last_name VARCHAR(20) NOT NULL,

        title VARCHAR(20) NULL,

        email VARCHAR(100) NOT NULL UNIQUE, -- UNIQUE = no duplicate values

        phone VARCHAR(15) UNIQUE, -- Phone is saved as text

        street VARCHAR(50) NOT NULL,

        city VARCHAR(30)
            CHECK (city IN ('Cairo', 'Alex')), -- CHECK = controls allowed values

        state VARCHAR(30) NULL,

        zip_code VARCHAR(10) NOT NULL
    );

END;
GO


-- ============================================================
-- 4.2 STORES
-- ============================================================

IF OBJECT_ID(N'sales_schema.stores', N'U') IS NULL
BEGIN

    CREATE TABLE sales_schema.stores
    (
        store_id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY = automatic numbers

        store_name VARCHAR(50) NOT NULL UNIQUE,

        phone VARCHAR(20) NOT NULL,

        email VARCHAR(100) NULL,

        street VARCHAR(50) NULL,

        city VARCHAR(30) NOT NULL,

        state VARCHAR(30) NULL,

        zip_code VARCHAR(10) NULL
    );

END;
GO


-- ============================================================
-- 4.3 STAFF
-- ============================================================

IF OBJECT_ID(N'sales_schema.staff', N'U') IS NULL
BEGIN

    CREATE TABLE sales_schema.staff
    (
        staff_id INT PRIMARY KEY,

        first_name VARCHAR(20) NOT NULL,

        last_name VARCHAR(20) NOT NULL,

        email VARCHAR(100) UNIQUE,

        phone VARCHAR(20) NULL,

        active BIT NOT NULL DEFAULT 1, -- DEFAULT = value used if no value is given

        store_id INT
            REFERENCES sales_schema.stores(store_id), -- FOREIGN KEY = value must exist in parent table

        manager_id INT
            REFERENCES sales_schema.staff(staff_id) -- Self-reference to staff table
    );

END;
GO


-- ============================================================
-- 4.4 ORDERS
-- ============================================================

IF OBJECT_ID(N'sales_schema.orders', N'U') IS NULL
BEGIN

    CREATE TABLE sales_schema.orders
    (
        order_id INT PRIMARY KEY,

        customer_id INT NOT NULL
            REFERENCES sales_schema.customers(customer_id),

        order_status VARCHAR(20) NOT NULL
            DEFAULT 'Pending'
            CHECK
            (
                order_status IN
                (
                    'Pending',
                    'Processing',
                    'Shipped',
                    'Completed',
                    'Cancelled'
                )
            ),

        -- Gets today's date
        order_date DATE NOT NULL
            DEFAULT CONVERT(DATE, GETDATE()),

        required_date DATE NULL,

        shipped_date DATE NULL,

        store_id INT NOT NULL
            REFERENCES sales_schema.stores(store_id),

        staff_id INT NULL
            REFERENCES sales_schema.staff(staff_id),

        -- Uses more than one column
        CONSTRAINT orders_ck_dates
            CHECK
            (
                shipped_date IS NULL
                OR required_date IS NULL
                OR shipped_date >= order_date
            )
    );

END;
GO


-- ============================================================
-- 4.5 CATEGORIES
-- ============================================================

IF OBJECT_ID(N'production_schema.categories', N'U') IS NULL
BEGIN

    CREATE TABLE production_schema.categories
    (
        category_id INT PRIMARY KEY,

        category_name VARCHAR(50) NOT NULL UNIQUE
    );

END;
GO


-- ============================================================
-- 4.6 BRANDS
-- ============================================================

IF OBJECT_ID(N'production_schema.brands', N'U') IS NULL
BEGIN

    CREATE TABLE production_schema.brands
    (
        brand_id INT PRIMARY KEY,

        brand_name VARCHAR(50) NOT NULL UNIQUE
    );

END;
GO


-- ============================================================
-- 4.7 PRODUCTS
-- ============================================================

IF OBJECT_ID(N'production_schema.products', N'U') IS NULL
BEGIN

    CREATE TABLE production_schema.products
    (
        product_id INT PRIMARY KEY,

        product_name VARCHAR(100) NOT NULL,

        brand_id INT NOT NULL
            REFERENCES production_schema.brands(brand_id),

        category_id INT NOT NULL
            REFERENCES production_schema.categories(category_id),

        model_year INT
            CHECK
            (
                model_year IS NULL
                OR model_year BETWEEN 1900 AND 2100
            ),

        list_price DECIMAL(10,2) NOT NULL
            CHECK (list_price >= 0)
    );

END;
GO


-- ============================================================
-- 4.8 ORDER ITEMS
-- ============================================================

IF OBJECT_ID(N'sales_schema.order_items', N'U') IS NULL
BEGIN

    CREATE TABLE sales_schema.order_items
    (
        order_id INT NOT NULL,

        item_id INT NOT NULL,

        product_id INT NOT NULL
            REFERENCES production_schema.products(product_id),

        quantity INT NOT NULL
            CHECK (quantity > 0),

        list_price DECIMAL(10,2) NOT NULL
            CHECK (list_price >= 0),

        discount DECIMAL(5,2) NOT NULL
            DEFAULT 0
            CHECK (discount BETWEEN 0 AND 100),

        -- Composite primary key = more than one column
        CONSTRAINT order_items_pk
            PRIMARY KEY (order_id, item_id),

        CONSTRAINT order_items_order_fk
            FOREIGN KEY (order_id)
            REFERENCES sales_schema.orders(order_id)
    );

END;
GO


-- ============================================================
-- 4.9 STOCKS
-- ============================================================

IF OBJECT_ID(N'production_schema.stocks', N'U') IS NULL
BEGIN

    CREATE TABLE production_schema.stocks
    (
        store_id INT NOT NULL
            REFERENCES sales_schema.stores(store_id),

        product_id INT NOT NULL
            REFERENCES production_schema.products(product_id),

        quantity INT NOT NULL
            DEFAULT 0
            CHECK (quantity >= 0),

        -- Composite primary key
        CONSTRAINT stocks_pk
            PRIMARY KEY (store_id, product_id)
    );

END;
GO

-- ============================================================
-- 4.10 FOREIGN KEY - ON DELETE
-- ============================================================

/*
ON DELETE controls what happens to child rows
when the parent row is deleted.

Example:

customers
    |
    | customer_id
    v
orders

customers = parent
orders    = child
*/


/*
------------------------------------------------------------
1) ON DELETE NO ACTION
------------------------------------------------------------

This is the default.

The parent row cannot be deleted
if child rows still reference it.

Example:
*/

-- customer_id INT
--     REFERENCES sales_schema.customers(customer_id)
--     ON DELETE NO ACTION;


/*
Example:

Customer 1 has orders.

DELETE FROM sales_schema.customers
WHERE customer_id = 1;

Result:
-> Customer 1 will NOT be deleted.
-> Orders for customer 1 stay.

SQL Server gives a FOREIGN KEY error.
*/


/*
------------------------------------------------------------
2) ON DELETE CASCADE
------------------------------------------------------------

Delete the parent row
AND automatically delete related child rows.

Example:
*/

-- customer_id INT
--     REFERENCES sales_schema.customers(customer_id)
--     ON DELETE CASCADE;


/*
Example:

DELETE FROM sales_schema.customers
WHERE customer_id = 1;

Result:
-> Customer 1 is deleted.
-> Orders belonging to customer 1 are also deleted.

Be careful with CASCADE because it can delete
many related rows automatically.
*/


/*
------------------------------------------------------------
3) ON DELETE SET NULL
------------------------------------------------------------

Delete the parent row
but keep the child rows.

The FOREIGN KEY value in the child becomes NULL.

Example:
*/

-- customer_id INT NULL
--     REFERENCES sales_schema.customers(customer_id)
--     ON DELETE SET NULL;


/*
Example:

DELETE FROM sales_schema.customers
WHERE customer_id = 1;

Result:
-> Customer 1 is deleted.
-> Orders stay.
-> orders.customer_id becomes NULL.

The child FOREIGN KEY column must allow NULL.
*/


/*
------------------------------------------------------------
QUICK SUMMARY
------------------------------------------------------------

NO ACTION
    -> Do not delete parent if child exists.

CASCADE
    -> Delete parent + related child rows.

SET NULL
    -> Delete parent + keep child rows.
    -> Child FOREIGN KEY becomes NULL.

NO ACTION is the default.
*/

-- ============================================================
-- 5) ALTER TABLE
-- ============================================================

/*
ALTER TABLE -> change an existing table

1. ADD column
2. ALTER COLUMN
3. ADD constraint
4. DROP COLUMN
5. DROP constraint
*/


-- 1) Add column

-- ALTER TABLE sales_schema.stores
-- ADD fax VARCHAR(20) NULL;


-- 2) Change column

-- ALTER TABLE sales_schema.stores
-- ALTER COLUMN city VARCHAR(50) NOT NULL;


-- 3) Drop column

-- ALTER TABLE sales_schema.stores
-- DROP COLUMN fax;


-- 4) Add constraint

-- ALTER TABLE sales_schema.stores
-- ADD CONSTRAINT stores_uq_phone UNIQUE(phone);


-- 5) Drop constraint

-- ALTER TABLE sales_schema.stores
-- DROP CONSTRAINT stores_uq_phone;


-- ============================================================
-- 6) RENAME
-- ============================================================

-- Rename table

-- EXEC sp_rename
--     N'sales_schema.staff',
--     N'workers';


-- Rename column

-- EXEC sp_rename
--     N'production_schema.categories.category_name',
--     N'category_name_new',
--     N'COLUMN';


-- ============================================================
-- 7) TRUNCATE
-- ============================================================

/*
TRUNCATE -> delete all rows
            but keep the table

Example:

TRUNCATE TABLE sales_schema.order_items;
*/


-- ============================================================
-- 8) DROP TABLE
-- ============================================================

/*
DROP TABLE -> delete table + data

Example:

DROP TABLE sales_schema.order_items;
*/


-- ============================================================
-- 9) DROP DATABASE
-- ============================================================

/*
DROP DATABASE -> delete the whole database

Example:

USE master;
DROP DATABASE BikeStores;
*/


-- ============================================================
-- 10) QUICK DDL CHEAT SHEET
-- ============================================================

-- CREATE DATABASE
-- CREATE DATABASE BikeStores;


-- CREATE SCHEMA
-- CREATE SCHEMA sales_schema;


-- CREATE TABLE
/*
CREATE TABLE example_table
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
*/


-- ADD COLUMN
-- ALTER TABLE example_table
-- ADD email VARCHAR(100);


-- CHANGE COLUMN
-- ALTER TABLE example_table
-- ALTER COLUMN name VARCHAR(100) NOT NULL;


-- ADD CONSTRAINT
-- ALTER TABLE example_table
-- ADD CONSTRAINT example_uq_email UNIQUE(email);


-- DROP CONSTRAINT
-- ALTER TABLE example_table
-- DROP CONSTRAINT example_uq_email;


-- DROP COLUMN
-- ALTER TABLE example_table
-- DROP COLUMN email;


-- RENAME TABLE
-- EXEC sp_rename N'example_table', N'example_table_new';


-- RENAME COLUMN
-- EXEC sp_rename
--     N'example_table_new.name',
--     N'full_name',
--     N'COLUMN';


-- TRUNCATE TABLE
-- TRUNCATE TABLE example_table_new;


-- DROP TABLE
-- DROP TABLE example_table_new;


-- DROP DATABASE
-- DROP DATABASE BikeStores;


-- ============================================================
-- 11) FINAL SCHEMA CHECK
-- ============================================================

SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables AS t
JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE s.name IN
(
    N'sales_schema',
    N'production_schema'
)
ORDER BY
    s.name,
    t.name;
GO


/*
============================================================
EXPECTED TABLES

sales_schema
    customers
    order_items
    orders
    staff
    stores

production_schema
    brands
    categories
    products
    stocks

RELATIONSHIPS

customers  1 ---- many orders
stores     1 ---- many staff
stores     1 ---- many orders
staff      1 ---- many orders
staff      1 ---- many staff
categories 1 ---- many products
brands     1 ---- many products
orders     1 ---- many order_items
products   1 ---- many order_items
stores     many ---- many products
           through stocks
============================================================
*/