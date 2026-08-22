/* SQL SERVER DQL - BikeStores
DQL reference, examples and final review
*/

-- 93) INFORMATION FROM SYSTEM TABLES : sys.tables contains information about tables.
SELECT name AS table_name FROM sys.tables;
GO

-- sys.columns contains information about columns.
SELECT OBJECT_SCHEMA_NAME(object_id) AS schema_name, OBJECT_NAME(object_id) AS table_name, name AS column_name FROM sys.columns;
GO

-- INFORMATION_SCHEMA.TABLES provides table metadata.
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE FROM INFORMATION_SCHEMA.TABLES;
GO

-- INFORMATION_SCHEMA.COLUMNS provides column metadata.
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS;
GO

-- ============================================================

-- 96) ORDER OF QUERY EXECUTION
/*
SQL Server logically processes a SELECT query approximately in
this order:
1. FROM
2. JOIN
3. ON
4. WHERE
5. GROUP BY
6. HAVING
7. SELECT
8. DISTINCT
9. ORDER BY
10. TOP / OFFSET / FETCH
Example:
SELECT city, COUNT(*) AS total
FROM sales_schema.customers
WHERE city IS NOT NULL
GROUP BY city
HAVING COUNT(*) > 1
ORDER BY total DESC;
*/

-- ============================================================

-- 97) COMMON SELECT TEMPLATE
/*
SELECT
columns
FROM table_name
JOIN another_table
ON condition
WHERE condition
GROUP BY columns
HAVING group_condition
ORDER BY columns
OFFSET number ROWS
FETCH NEXT number ROWS ONLY;
*/

-- ============================================================

-- 98) DQL EXAMPLE - CUSTOMER ORDERS : Show customers with their orders.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.order_id, o.order_status, o.order_date FROM sales_schema.customers AS c LEFT JOIN sales_schema.orders AS o ON c.customer_id = o.customer_id ORDER BY c.customer_id, o.order_date;
GO

-- ============================================================

-- 99) DQL EXAMPLE - PRODUCT DETAILS : Show complete product information.
SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.model_year, p.list_price FROM production_schema.products AS p INNER JOIN production_schema.brands AS b ON p.brand_id = b.brand_id INNER JOIN production_schema.categories AS c ON p.category_id = c.category_id ORDER BY p.list_price DESC;
GO

-- ============================================================

-- 100) DQL EXAMPLE - CUSTOMER SPENDING : Calculate how much each customer spent.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COALESCE ( SUM ( oi.quantity * oi.list_price * (1 - oi.discount / 100.0) ), 0 ) AS total_spent FROM sales_schema.customers AS c LEFT JOIN sales_schema.orders AS o ON c.customer_id = o.customer_id LEFT JOIN sales_schema.order_items AS oi ON o.order_id = oi.order_id GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY total_spent DESC;
GO

-- ============================================================

-- 101) DQL EXAMPLE - BEST PRODUCTS : Calculate total quantity sold for every product.
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_quantity_sold FROM production_schema.products AS p INNER JOIN sales_schema.order_items AS oi ON p.product_id = oi.product_id GROUP BY p.product_id, p.product_name ORDER BY total_quantity_sold DESC;
GO

-- ============================================================

-- 102) DQL EXAMPLE - ORDER SUMMARY : Show the number of orders for every status.
SELECT order_status, COUNT(*) AS order_count FROM sales_schema.orders GROUP BY order_status ORDER BY order_count DESC;
GO

-- ============================================================

-- 103) DQL EXAMPLE - STORE PERFORMANCE : Calculate order count for every store.
SELECT s.store_id, s.store_name, COUNT(o.order_id) AS order_count FROM sales_schema.stores AS s LEFT JOIN sales_schema.orders AS o ON s.store_id = o.store_id GROUP BY s.store_id, s.store_name ORDER BY order_count DESC;
GO

-- ============================================================

-- 104) DQL EXAMPLE - STAFF AND MANAGERS : Show every employee with the manager name.
SELECT e.staff_id, CONCAT(e.first_name, ' ', e.last_name) AS employee_name, CONCAT(m.first_name, ' ', m.last_name) AS manager_name FROM sales_schema.staff AS e LEFT JOIN sales_schema.staff AS m ON e.manager_id = m.staff_id ORDER BY e.staff_id;
GO

-- ============================================================

-- 105) DQL EXAMPLE - STOCK : Show stock with store and product names.
SELECT s.store_name, p.product_name, st.quantity FROM production_schema.stocks AS st INNER JOIN sales_schema.stores AS s ON st.store_id = s.store_id INNER JOIN production_schema.products AS p ON st.product_id = p.product_id ORDER BY s.store_name, p.product_name;
GO

-- ============================================================

-- 106) DQL EXAMPLE - PRODUCTS ABOVE AVERAGE : Find products more expensive than the average product.
SELECT product_id, product_name, list_price FROM production_schema.products WHERE list_price > ( SELECT AVG(list_price) FROM production_schema.products ) ORDER BY list_price DESC;
GO

-- ============================================================

-- 107) DQL EXAMPLE - CUSTOMERS WITH ORDERS : EXISTS finds customers who placed at least one order.
SELECT c.customer_id, c.first_name, c.last_name FROM sales_schema.customers AS c WHERE EXISTS ( SELECT 1 FROM sales_schema.orders AS o WHERE o.customer_id = c.customer_id );
GO

-- ============================================================

-- 108) DQL EXAMPLE - CUSTOMERS WITHOUT ORDERS : NOT EXISTS finds customers who have no orders.
SELECT c.customer_id, c.first_name, c.last_name FROM sales_schema.customers AS c WHERE NOT EXISTS ( SELECT 1 FROM sales_schema.orders AS o WHERE o.customer_id = c.customer_id );
GO

-- ============================================================

-- 109) DQL EXAMPLE - TOP 3 PRODUCTS : TOP can return the three most expensive products.
SELECT TOP 3 product_id, product_name, list_price FROM production_schema.products ORDER BY list_price DESC;
GO

-- ============================================================

-- 110) DQL EXAMPLE - RANK PRODUCTS : RANK can rank products according to their prices.
SELECT product_id, product_name, list_price, RANK() OVER ( ORDER BY list_price DESC ) AS price_rank FROM production_schema.products;
GO

-- ============================================================

-- 111) DQL EXAMPLE - RUNNING SALES TOTAL : Calculate a running sales total.
SELECT oi.order_id, oi.item_id, oi.quantity * oi.list_price AS order_total, SUM(oi.quantity * oi.list_price) OVER ( ORDER BY oi.order_id, oi.item_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS running_total FROM sales_schema.order_items AS oi;
GO

-- ============================================================

-- 112) DQL EXAMPLE - PREVIOUS PRODUCT PRICE : LAG compares the current price with the previous product price.
SELECT product_id, product_name, list_price, LAG(list_price) OVER ( ORDER BY product_id ) AS previous_price, list_price - LAG(list_price) OVER ( ORDER BY product_id ) AS price_difference FROM production_schema.products;
GO

-- ============================================================

-- 113) DQL FINAL REVIEW QUERY : This query combines JOIN, GROUP BY, CASE, aggregate and ORDER BY.
SELECT s.store_name, COUNT(o.order_id) AS total_orders, SUM ( CASE WHEN o.order_status = 'Completed' THEN 1 ELSE 0 END ) AS completed_orders, SUM ( CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END ) AS cancelled_orders FROM sales_schema.stores AS s LEFT JOIN sales_schema.orders AS o ON s.store_id = o.store_id GROUP BY s.store_id, s.store_name ORDER BY total_orders DESC;
GO

-- ============================================================

-- 114) DQL QUICK CHEAT SHEET
/*
SELECT
-> read data
DISTINCT
-> remove duplicate results
TOP
-> return first N rows
WHERE
-> filter rows
AND
-> all conditions must be true
OR
-> at least one condition must be true
NOT
-> reverse a condition
IN
-> match values from a list
BETWEEN
-> match values inside a range
LIKE
-> search text patterns
IS NULL
-> find NULL values
IS NOT NULL
-> find non-NULL values
ORDER BY
-> sort results
GROUP BY
-> create groups
HAVING
-> filter groups
COUNT
-> count rows
SUM
-> calculate total
AVG
-> calculate average
MIN
-> smallest value
MAX
-> largest value
INNER JOIN
-> matching rows from both tables
LEFT JOIN
-> all rows from left + matching rows from right
RIGHT JOIN
-> all rows from right + matching rows from left
FULL OUTER JOIN
-> all matching and non-matching rows
CROSS JOIN
-> every possible combination
SELF JOIN
-> table joined to itself
SUBQUERY
-> query inside another query
EXISTS
-> check whether rows exist
NOT EXISTS
-> check whether rows do not exist
ANY
-> compare with at least one subquery value
ALL
-> compare with every subquery value
UNION
-> combine results and remove duplicates
UNION ALL
-> combine results and keep duplicates
INTERSECT
-> values existing in both queries
EXCEPT
-> values existing in first query but not second
CTE
-> temporary named query result
ROW_NUMBER
-> unique sequential number
RANK
-> ranking with gaps after ties
DENSE_RANK
-> ranking without gaps after ties
NTILE
-> divide rows into groups
LAG
-> previous row value
LEAD
-> next row value
FIRST_VALUE
-> first value in window
LAST_VALUE
-> last value in window
SUM() OVER
-> window total
AVG() OVER
-> window average
COUNT() OVER
-> window count
PERCENT_RANK
-> relative ranking
OFFSET
-> skip rows
FETCH
-> return rows after OFFSET
CASE
-> conditional logic
ISNULL
-> replace NULL with a value
COALESCE
-> return first non-NULL value
CAST
-> convert data type
CONVERT
-> convert data type
*/

-- ============================================================

-- 115) MOST IMPORTANT SELECT TEMPLATE
/*
SELECT
columns
FROM table
JOIN table2
ON condition
WHERE condition
GROUP BY columns
HAVING condition
ORDER BY columns
OFFSET x ROWS
FETCH NEXT y ROWS ONLY;
Logical execution order:
FROM
↓
JOIN / ON
↓
WHERE
↓
GROUP BY
↓
HAVING
↓
SELECT
↓
DISTINCT
↓
ORDER BY
↓
OFFSET / FETCH
↓
TOP
*/

-- ============================================================

-- 116) FINAL DQL CHECK : Check all tables before practicing DQL.
SELECT s.name AS schema_name, t.name AS table_name FROM sys.tables AS t INNER JOIN sys.schemas AS s ON t.schema_id = s.schema_id WHERE s.name IN ( N'sales_schema', N'production_schema' ) ORDER BY s.name, t.name;
GO

/*
============================================================
DQL FINAL SUMMARY
============================================================
BASIC:
SELECT
DISTINCT
TOP
ALIAS
FILTERING:
WHERE
AND
OR
NOT
IN
BETWEEN
LIKE
IS NULL
SORTING:
ORDER BY
OFFSET
FETCH
FUNCTIONS:
STRING FUNCTIONS
NUMERIC FUNCTIONS
DATE FUNCTIONS
NULL FUNCTIONS
CAST
CONVERT
CASE
AGGREGATION:
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
JOINS:
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL OUTER JOIN
CROSS JOIN
SELF JOIN
MULTIPLE JOIN
SUBQUERIES:
SUBQUERY
CORRELATED SUBQUERY
EXISTS
NOT EXISTS
ANY
ALL
SET OPERATORS:
UNION
UNION ALL
INTERSECT
EXCEPT
ADVANCED:
CTE
RECURSIVE CTE
DERIVED TABLE
WINDOW FUNCTIONS
ROW_NUMBER
RANK
DENSE_RANK
NTILE
LAG
LEAD
FIRST_VALUE
LAST_VALUE
PERCENT_RANK
RUNNING TOTAL
MOVING AVERAGE
OTHER:
VIEWS
SYSTEM TABLES
INFORMATION_SCHEMA
============================================================
END OF DQL STUDY FILE
============================================================
*/

i have this file iam using to studie sql dql i want to make it simple keep i want to update this file to reduuse its size so it eaze to read

1- if any thing in many lins can be in 1 make it like this :
-- ============================================================
