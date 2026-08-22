/* SQL SERVER DQL - BikeStores
SELECT, filtering, sorting and basic expressions
*/

-- 2) BASIC SELECT : SELECT * returns all columns.
SELECT * FROM sales_schema.customers;
GO

-- SELECT specific columns.
SELECT customer_id, first_name, last_name, email FROM sales_schema.customers;
GO

-- SELECT can return a calculated value.
SELECT first_name, last_name, customer_id + 100 AS new_id FROM sales_schema.customers;
GO

-- ============================================================

-- 3) COLUMN ALIAS : AS gives a column a temporary display name.
SELECT first_name AS FirstName, last_name AS LastName, email AS EmailAddress FROM sales_schema.customers;
GO

-- AS is optional for column aliases and you can use [].
SELECT first_name [FirstName], last_name LastName FROM sales_schema.customers;
GO

-- ============================================================

-- 4) TABLE ALIAS : A table alias gives a short name to the table.
SELECT c.customer_id, c.first_name, c.last_name FROM sales_schema.customers  AS c;
GO
-- AS is optional for column aliases and you can use [].
SELECT c.customer_id, c.first_name, c.last_name FROM sales_schema.customers  c;
GO

-- ============================================================

-- 5) DISTINCT : DISTINCT removes duplicate values from the result.
SELECT DISTINCT city FROM sales_schema.customers;
GO

-- DISTINCT works with combinations of columns.
SELECT DISTINCT city, first_name FROM sales_schema.customers;
GO

-- ============================================================

-- 6) TOP : TOP returns the first specified number of rows.
SELECT TOP 3 * FROM sales_schema.customers;
GO

-- TOP with ORDER BY returns the top rows based on sorting.
SELECT TOP 3 * FROM production_schema.products ORDER BY list_price DESC;
GO

-- TOP PERCENT returns a percentage of the rows.
SELECT TOP 40 PERCENT * FROM production_schema.products;
GO

-- ============================================================

-- 7) WHERE : WHERE filters rows based on a condition.
SELECT * FROM sales_schema.customers WHERE city = 'Cairo';
GO

-- WHERE can compare numbers.
SELECT * FROM production_schema.products WHERE list_price > 1000;
GO

-- WHERE can compare dates.
SELECT * FROM sales_schema.orders WHERE order_date >= '2026-08-01';
GO

-- ============================================================

-- 8) COMPARISON OPERATORS : Equal to uses =.
SELECT * FROM production_schema.products WHERE list_price = 1500;
GO

-- Not equal can use <>.
SELECT * FROM production_schema.products WHERE list_price <> 1500;
GO

-- Greater than uses >.
SELECT * FROM production_schema.products WHERE list_price > 1000;
GO

-- Less than uses <.
SELECT * FROM production_schema.products WHERE list_price < 1000;
GO

-- Greater than or equal uses >=.
SELECT * FROM production_schema.products WHERE list_price >= 1000;
GO

-- Less than or equal uses <=.
SELECT * FROM production_schema.products WHERE list_price <= 1000;
GO

-- ============================================================

-- 9) AND : AND requires all conditions to be true.
SELECT * FROM production_schema.products WHERE list_price > 500 AND list_price < 2000;
GO

-- ============================================================

-- 10) OR : OR requires at least one condition to be true.
SELECT * FROM sales_schema.customers WHERE city = 'Cairo' OR city = 'Alex';
GO

-- ============================================================

-- 11) NOT : NOT reverses a condition.
SELECT * FROM sales_schema.customers WHERE NOT city = 'Cairo';
GO

-- ============================================================

-- 12) COMBINING AND / OR : Parentheses control the order of logical conditions.
SELECT * FROM production_schema.products WHERE (category_id = 1 OR category_id = 2) AND list_price > 1400;
GO

-- ============================================================

-- 13) IN : IN checks whether a value exists in a list.
SELECT * FROM sales_schema.customers WHERE city IN ('Cairo', 'Alex');
GO

-- NOT IN excludes values from a list.
SELECT * FROM sales_schema.customers WHERE city NOT IN ('Cairo', 'Alex');
GO

-- ============================================================

-- 14) BETWEEN : BETWEEN checks whether a value is inside a range.
SELECT * FROM production_schema.products WHERE list_price BETWEEN 500 AND 1500;
GO

-- NOT BETWEEN excludes a range.
SELECT * FROM production_schema.products WHERE list_price NOT BETWEEN 500 AND 1500;
GO

-- BETWEEN can be used with dates.
SELECT * FROM sales_schema.orders WHERE order_date BETWEEN '2026-08-01' AND '2026-08-31';
GO

-- ============================================================

-- 15) LIKE : LIKE searches for a text pattern.
SELECT * FROM sales_schema.customers WHERE first_name LIKE 'A%';
GO

-- % means zero or more characters.
SELECT * FROM sales_schema.customers WHERE first_name LIKE '%A%';
GO

-- % at the end means starts with the value.
SELECT * FROM sales_schema.customers WHERE last_name LIKE 'A%';
GO

-- % at the beginning means ends with the value.
SELECT * FROM sales_schema.customers WHERE last_name LIKE '%n';
GO

-- _ represents exactly one character.
SELECT * FROM sales_schema.customers WHERE first_name LIKE '_hmed';
GO

-- NOT LIKE excludes a pattern.
SELECT * FROM sales_schema.customers WHERE first_name NOT LIKE 'A%';
GO

-- ============================================================

-- 16) NULL : NULL means the value is missing or unknown.
SELECT * FROM sales_schema.customers WHERE title IS NULL;
GO

-- IS NOT NULL finds rows that contain a value.
SELECT * FROM sales_schema.customers WHERE title IS NOT NULL;
GO

-- Do not use = NULL.
-- Correct syntax is IS NULL.

-- ============================================================

-- 17) ORDER BY : ORDER BY sorts the result in ascending order , defulte is ASC
SELECT * FROM production_schema.products ORDER BY list_price ASC;
GO

-- DESC sorts the result in descending order.
SELECT * FROM production_schema.products ORDER BY list_price DESC;
GO

-- Multiple columns can be sorted.
SELECT * FROM sales_schema.customers ORDER BY city ASC, first_name ASC;
GO

-- ORDER BY can use a column alias.
SELECT product_name, list_price AS Price FROM production_schema.products ORDER BY Price DESC;
GO

-- ============================================================

-- 18) ORDER BY COLUMN NUMBER : SQL Server allows ordering by the column position.
SELECT product_id, product_name, list_price FROM production_schema.products ORDER BY 3 DESC;
GO

-- Prefer column names because they are easier to understand.

-- ============================================================

-- 19) CALCULATED COLUMNS : Arithmetic operators can be used inside SELECT.
SELECT product_name, list_price, list_price + 100 AS new_price FROM production_schema.products;
GO

-- Multiplication can calculate totals.
SELECT product_name, list_price, list_price * 2 AS price_for_two FROM production_schema.products;
GO

-- Order item total before discount.
SELECT order_id, product_id, quantity, list_price, quantity * list_price AS total_price FROM sales_schema.order_items;
GO

-- Order item total after discount.
SELECT order_id, product_id, quantity, list_price, discount, quantity * list_price * (1 - discount / 100.0) AS final_price FROM sales_schema.order_items;
GO

-- ============================================================
