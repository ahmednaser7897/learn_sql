-- ============================================================
-- Table Variables and Table-Valued Functions
-- ============================================================


-- ============================================================
-- 1. Store the Result of a Query in a Variable
-- ============================================================

-- We can store the result of a query in a variable.
DECLARE @product_count INT;

SET @product_count =
(
    SELECT COUNT(*)
    FROM production_schema.products
);


-- Display the product count.
SELECT @product_count AS 'product count';


-- ============================================================
-- 2. What Are Table Variables?
-- ============================================================

-- Table variables are variables that can hold rows of data,
-- similar to temporary tables.

-- Table variables have a limited scope.
-- Similar to local variables, table variables are out of scope at the end of the batch.

-- If you define a table variable inside a stored procedure or user-defined function,
-- the table variable no longer exists after the procedure or function exits.


-- ============================================================
-- 3. Declare a Table Variable
-- ============================================================

-- Declare a table variable with three columns.
DECLARE @product_table TABLE
(
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);


-- ============================================================
-- 4. Insert Data into a Table Variable
-- ============================================================

-- Once declared, the table variable is empty.

-- Insert products from the products table into the table variable.
INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM production_schema.products
WHERE category_id = 1;


-- Display the data stored in the table variable.
SELECT *
FROM @product_table;


-- ============================================================
-- 5. Table Variables in User-Defined Functions
-- ============================================================

-- A table variable can be used in a user-defined function
-- that returns table values instead of a single value.

-- Create a multi-statement table-valued function.
CREATE FUNCTION cOrders(@cid INT)
RETURNS @oTable TABLE
(
    ordern INT,
    orderDate DATE
)
AS
BEGIN
    INSERT INTO @oTable
    SELECT
        order_id,
        order_date
    FROM sales_schema.orders
    WHERE customer_id = @cid;

    RETURN;
END;


-- The function returns a table, so we can work with it like a table.
SELECT *
FROM cOrders(1);


-- Join the returned table with order_items.
SELECT *
FROM cOrders(1) AS o
JOIN sales_schema.order_items AS oi
    ON o.ordern = oi.order_id;


-- ============================================================
-- 6. SQL Server Table-Valued Functions
-- ============================================================

-- A table-valued function is a user-defined function that returns a table.

-- The return type of a table-valued function is a table,
-- so you can use the function like a table.

-- With an inline table-valued function,
-- you do not have to define the table structure manually.


-- Create an inline table-valued function.
CREATE FUNCTION ProductInYear
(
    @model_year INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        product_name,
        model_year,
        list_price
    FROM production_schema.products
    WHERE model_year = @model_year
);


-- ============================================================
-- 7. Execute a Table-Valued Function
-- ============================================================

-- Use the table-valued function in the FROM clause.
SELECT *
FROM ProductInYear(2026);


-- Select specific columns from the returned table.
SELECT
    product_name,
    model_year
FROM ProductInYear(2026);