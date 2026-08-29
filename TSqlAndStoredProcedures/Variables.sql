-- ============================================================
-- Variables
-- ============================================================


/*
    A variable is a named location in memory used to store a value.

    In SQL Server, variables are declared using DECLARE
    and their values can be assigned using SET or SELECT.

    Variables are commonly used inside stored procedures,
    functions, scripts, and batches.
*/


-- ============================================================
-- Declare and Assign a Variable
-- ============================================================

-- Declare an integer variable.
DECLARE @number INT;
-- Assign a value to the variable.
SET @number = 10;
-- Display the variable value.
SELECT @number AS number;

-- Declare a variable and assign a value at the same time.
DECLARE @price DECIMAL(10,2) = 500.50;
-- Display the variable value.
SELECT @price AS price;

-- Assign a value to a variable using SELECT.
DECLARE @productName VARCHAR(100);
SELECT @productName = 'Mountain Bike';
-- Display the variable value.
SELECT @productName AS productName;

-- SET assigns one value to a variable.
DECLARE @x INT;
SET @x = 10;
SELECT @x AS x;

-- SELECT can also assign a value to a variable.
DECLARE @y INT;
SELECT @y = 20;
SELECT @y AS y;


-- ============================================================
-- Assign a Value from a Table
-- ============================================================

-- Get a product name from the products table.
DECLARE @name VARCHAR(100);
SELECT @name = product_name
FROM production_schema.products
WHERE product_id = 1;
-- Display the product name.
SELECT @name AS productName;


-- ============================================================
-- Variable Data Types
-- ============================================================

-- Variables can use different SQL Server data types.
DECLARE @id INT = 10;
DECLARE @name2 VARCHAR(100) = 'John';
DECLARE @price2 DECIMAL(10,2) = 1500.50;
DECLARE @discount DECIMAL(4,2) = 0.10;
DECLARE @isActive BIT = 1;
DECLARE @date DATE = '2026-08-26';
-- Display the variables.
SELECT
    @id AS id,
    @name2 AS name,
    @price2 AS price,
    @discount AS discount,
    @isActive AS isActive,
    @date AS date;


-- ============================================================
-- Use Variables in a Query
-- ============================================================

-- Use a variable to filter products by price.
DECLARE @minPrice DECIMAL(10,2) = 500;

SELECT
    product_name,
    list_price
FROM production_schema.products
WHERE list_price >= @minPrice
ORDER BY list_price;

-- ============================================================
-- Variables with Calculations
-- ============================================================

-- Use variables to perform calculations.
DECLARE @quantity INT = 10;
DECLARE @listPrice DECIMAL(10,2) = 100;
DECLARE @discount2 DECIMAL(4,2) = 0.10;
DECLARE @total DECIMAL(10,2);

-- Calculate the total price.
SET @total = @quantity * @listPrice * (1 - @discount2);

-- Display the result.
SELECT @total AS total;

-- ============================================================
-- Variables with IF
-- ============================================================

-- Declare a price variable.
DECLARE @productPrice2 DECIMAL(10,2) = 1200;

-- Check the price using IF.
IF @productPrice2 >= 1000
BEGIN
    SELECT 'Expensive' AS priceStatus;
END
ELSE
BEGIN
    SELECT 'Affordable' AS priceStatus;
END;

-- ============================================================
-- Variables with CASE
-- ============================================================

-- Use CASE to classify the product price.
DECLARE @productPrice3 DECIMAL(10,2) = 1200;

SELECT
    CASE
        WHEN @productPrice3 >= 1000 THEN 'Expensive'
        ELSE 'Affordable'
    END AS priceStatus;

-- ============================================================
-- Variable Scope
-- ============================================================

-- A variable is available only inside the current batch.
DECLARE @message VARCHAR(100) = 'Hello SQL Server';
SELECT @message AS message;

-- ============================================================
-- NULL Variables
-- ============================================================

-- A variable can contain NULL.
DECLARE @value INT = NULL;
-- Check if the variable is NULL.
SELECT @value AS value;
-- Use ISNULL to replace NULL with another value.
SELECT ISNULL(@value, 0) AS value;

-- ============================================================
-- COALESCE with Variables
-- ============================================================

-- COALESCE returns the first non-NULL value.
DECLARE @firstValue INT = NULL;
DECLARE @secondValue INT = 20;
SELECT COALESCE(@firstValue, @secondValue, 0) AS result;

-- ============================================================
-- Variables Inside a Loop
-- ============================================================

-- Declare a counter variable.
DECLARE @counter INT = 1;

-- Repeat the code while the counter is less than or equal to 5.
WHILE @counter <= 5
BEGIN
    SELECT @counter AS counter;

    SET @counter = @counter + 1;
END;


-- ============================================================
-- Printing Variables
-- ============================================================

DECLARE @myname VARCHAR(100) = 'Ahmed';
SELECT @myname as name;
-- This prints in the messages tap
PRINT @myname ;
PRINT 'my name is ' + @myname;


