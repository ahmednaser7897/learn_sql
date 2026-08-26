/*
    SQL Server stored procedures are used to group one or more Transact-SQL statements
    into logical units.

    A stored procedure is stored as a named object in the SQL Server database server.

    T-SQL (Transact-SQL) is Microsoft's extension of standard SQL, designed specifically
    for use with Microsoft SQL Server.

    While it includes all the core capabilities of SQL for querying and managing data,
    T-SQL adds procedural programming features that let you write more powerful
    and dynamic database logic.
*/


-- ============================================================
-- 1. Basic Stored Procedure
-- ============================================================

-- Return a list of products from the products table.
SELECT product_name, list_price
FROM production_schema.products
ORDER BY product_name;


-- Create a stored procedure that wraps the query.
CREATE PROCEDURE uspProductList
AS
BEGIN
    SELECT product_name, list_price
    FROM production_schema.products
    ORDER BY product_name;
END;


-- Execute the stored procedure.
EXECUTE uspProductList;
EXEC uspProductList;


-- ============================================================
-- 2. Alter Stored Procedure
-- ============================================================

-- Modify the stored procedure by adding new columns and changing the order.
-- In SSMS: Right-click the procedure -> Modify.
ALTER PROCEDURE uspProductList
AS
BEGIN
    SELECT product_name, list_price, model_year, brand_id
    FROM production_schema.products
    ORDER BY list_price;
END;


-- Execute the updated procedure.
EXEC uspProductList;


-- ============================================================
-- 3. Delete Stored Procedure
-- ============================================================

-- Delete the stored procedure.
DROP PROCEDURE uspProductList;

-- DROP PROC is a shorter version of DROP PROCEDURE.
DROP PROC uspProductList;


-- ============================================================
-- 4. Stored Procedure with Parameters
-- ============================================================

-- Add parameters to filter products by price.
-- @minPrice = minimum price.
-- @maxPrice = maximum price.
CREATE PROCEDURE uspProductListWithPrise
(
    @minPrice AS DECIMAL,
    @maxPrice AS DECIMAL
)
AS
BEGIN
    SELECT product_name, list_price
    FROM production_schema.products
    WHERE list_price >= @minPrice
      AND list_price <= @maxPrice
    ORDER BY list_price;
END;


-- This will cause an error because the required parameters are missing.
-- EXEC uspProductListWithPrise;


-- Pass parameters by position.
EXEC uspProductListWithPrise 500, 1500;


-- Pass parameters by name.
EXEC uspProductListWithPrise
    @minPrice = 500,
    @maxPrice = 1500;


-- ============================================================
-- 5. Stored Procedure with Default Parameters
-- ============================================================

-- Parameters can have default values.
-- Default values are used when the parameters are not provided.
CREATE PROCEDURE uspProductListWithDefaultValues
(
    @minPrice AS DECIMAL = 0,
    @maxPrice AS DECIMAL = NULL,
    @name AS VARCHAR(MAX)
)
AS
BEGIN
    SELECT product_name, list_price
    FROM production_schema.products
    WHERE list_price >= @minPrice
      AND (@maxPrice IS NULL OR list_price <= @maxPrice)
      AND product_name LIKE '%' + @name + '%'
    ORDER BY list_price;
END;


-- Pass all parameters by position.
EXEC uspProductListWithDefaultValues 500, 1500, 'a';


-- Use the default values for @minPrice and @maxPrice.
-- @name is passed by name because it is the required parameter.
EXEC uspProductListWithDefaultValues
    @name = 'a';


-- Use the default value for @maxPrice.
EXEC uspProductListWithDefaultValues
    @name = 'a',
    @minPrice = 1000;


-- Use the default value for @minPrice.
EXEC uspProductListWithDefaultValues
    @name = 'a',
    @maxPrice = 2000;


-- Pass all parameters by name.
EXEC uspProductListWithDefaultValues
    @name = 'a',
    @minPrice = 1000,
    @maxPrice = 2000;


-- ============================================================
-- 6. Stored Procedure with OUTPUT Parameter
-- ============================================================

-- @@ROWCOUNT returns the number of rows affected or returned by the previous statement.
CREATE PROCEDURE uspProductListWithOutput
(
    @minPrice DECIMAL = 0,
    @productCount INT OUTPUT
)
AS
BEGIN
    SELECT product_name, list_price
    FROM production_schema.products
    WHERE list_price >= @minPrice
    ORDER BY list_price;

    -- Store the number of returned rows in the output parameter.
    SELECT @productCount = @@ROWCOUNT;
END;


-- ============================================================
-- 7. Using the OUTPUT Parameter
-- ============================================================

-- Declare a variable to receive the output value.
-- The declaration, execution, and SELECT must run in the same batch.
DECLARE @count INT;

EXEC uspProductListWithOutput
    @minPrice = 500,
    @productCount = @count OUTPUT;


-- Display the number of rows.
SELECT @count;

-- Display the number of rows with a column alias.
SELECT @count AS 'number of rows';