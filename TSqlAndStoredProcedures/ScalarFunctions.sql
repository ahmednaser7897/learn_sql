-- ============================================================
-- Scalar Functions
-- ============================================================


-- ============================================================
-- 1. Functions vs Stored Procedures
-- ============================================================

-- Functions must return a value.
-- Functions can be used inside SELECT statements and queries.
-- Stored procedures do not have to return a value.


-- ============================================================
-- 2. What Is a Scalar Function?
-- ============================================================

-- A scalar function takes one or more parameters and returns a single value.


-- Create a scalar function to calculate the net salary.
CREATE FUNCTION sales_schema.GetNetSalery
(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;


-- ============================================================
-- 3. Use the Function with a Single Value
-- ============================================================

-- Call the function with specific values.
SELECT sales_schema.GetNetSalery(10, 100, 0.1) AS discountSalary;


-- ============================================================
-- 4. Use the Function Inside a Query
-- ============================================================

-- Use the function to calculate the net amount for each order.
SELECT
    order_id,
    SUM(
        sales_schema.GetNetSalery(
            quantity,
            list_price,
            discount
        )
    ) AS net_amount
FROM sales_schema.order_items
GROUP BY order_id
ORDER BY net_amount DESC;


-- ============================================================
-- 5. Create a Simple Scalar Function
-- ============================================================

-- Create a function that adds two numbers.
CREATE FUNCTION sumNumbers
(
    @a DEC(10,2),
    @b DEC(10,2)
)
RETURNS DEC(10,2)
AS
BEGIN
    RETURN @a + @b;
END;


-- Call the function with two values.
SELECT dbo.sumNumbers(2, 4) AS sum;


-- ============================================================
-- 6. Alter a Function
-- ============================================================

-- Modify the function to accept and add three numbers.
ALTER FUNCTION sumNumbers
(
    @a DEC(10,2),
    @b DEC(10,2),
    @c DEC(10,2)
)
RETURNS DEC(10,2)
AS
BEGIN
    RETURN @a + @b + @c;
END;


-- Call the updated function.
SELECT dbo.sumNumbers(2, 4, 4) AS sum;


-- ============================================================
-- 7. Create or Alter a Function
-- ============================================================

-- CREATE OR ALTER creates the function if it does not exist
-- or updates it if it already exists.
CREATE OR ALTER FUNCTION sumNumbers
(
    @a DEC(10,2),
    @b DEC(10,2),
    @c DEC(10,2),
    @d DEC(10,2)
)
RETURNS DEC(10,2)
AS
BEGIN
    RETURN @a + @b + @c + @d;
END;


-- Call the updated function with four values.
SELECT dbo.sumNumbers(4, 5, 7, 8) AS sum;


-- ============================================================
-- 8. Delete a Function
-- ============================================================

-- Delete the function.
DROP FUNCTION sales_schema.GetNetSalery;