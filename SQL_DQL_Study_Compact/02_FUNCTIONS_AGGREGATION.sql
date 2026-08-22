/* SQL SERVER DQL - BikeStores
Functions, CASE and aggregation
*/

-- CONCATENATION : + can combine text values.
SELECT first_name + ' ' + last_name AS full_name FROM sales_schema.customers;
GO

-- CONCAT is safer when NULL values may exist.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM sales_schema.customers;
GO

-- ============================================================

-- STRING FUNCTIONS : LEN returns the number of characters.
SELECT first_name, LEN(first_name) AS name_length FROM sales_schema.customers;
GO

-- UPPER converts text to uppercase.
SELECT UPPER(first_name) AS upper_name FROM sales_schema.customers;
GO

-- LOWER converts text to lowercase.
SELECT LOWER(first_name) AS lower_name FROM sales_schema.customers;
GO

-- LEFT returns characters from the left.
SELECT first_name, LEFT(first_name, 2) AS first_two FROM sales_schema.customers;
GO

-- RIGHT returns characters from the right.
SELECT last_name, RIGHT(last_name, 2) AS last_two FROM sales_schema.customers;
GO

-- SUBSTRING extracts part of a string.
SELECT first_name, SUBSTRING(first_name, 1, 3) AS first_three FROM sales_schema.customers;
GO

-- LTRIM removes spaces from the left.
SELECT LTRIM(' Ahmed') AS result;
GO

-- RTRIM removes spaces from the right.
SELECT RTRIM('Ahmed ') AS result;
GO

-- TRIM removes spaces from both sides.
SELECT TRIM(' Ahmed ') AS result;
GO

-- REPLACE replaces part of a string.
SELECT REPLACE(email, '@gmail.com', '@example.com') AS new_email FROM sales_schema.customers;
GO

-- CHARINDEX finds the position of text.
SELECT email, CHARINDEX('@', email) AS at_position FROM sales_schema.customers;
GO

-- ============================================================

-- NUMERIC FUNCTIONS : ROUND rounds a number.
SELECT ROUND(list_price, 0) AS rounded_price FROM production_schema.products;
GO

-- CEILING rounds a number upward.
SELECT CEILING(list_price / 100.0) AS rounded_up FROM production_schema.products;
GO

-- FLOOR rounds a number downward.
SELECT FLOOR(list_price / 100.0) AS rounded_down FROM production_schema.products;
GO

-- ABS returns the absolute value.
SELECT ABS(-100) AS absolute_value;
GO

-- ============================================================

-- DATE FUNCTIONS : GETDATE returns the current date and time.
SELECT GETDATE() AS current_datetime;
GO

-- CAST can convert the current datetime to DATE.
SELECT CAST(GETDATE() AS DATE) AS current_datee;
GO

-- YEAR returns the year.
SELECT order_id, YEAR(order_date) AS order_year FROM sales_schema.orders;
GO

-- MONTH returns the month.
SELECT order_id, MONTH(order_date) AS order_month FROM sales_schema.orders;
GO

-- DAY returns the day.
SELECT order_id, DAY(order_date) AS order_day FROM sales_schema.orders;
GO

-- DATEPART extracts a date part.
SELECT order_id, DATEPART(YEAR, order_date) AS order_year FROM sales_schema.orders;
GO

-- DATEADD adds time to a date.
SELECT order_date, DATEADD(DAY, 7, order_date) AS after_7_days FROM sales_schema.orders;
GO

-- DATEDIFF calculates the difference between dates.
SELECT order_id, DATEDIFF(DAY, order_date, shipped_date) AS shipping_days FROM sales_schema.orders WHERE shipped_date IS NOT NULL;
GO

-- ============================================================

-- NULL FUNCTIONS : ISNULL replaces NULL with another value.
SELECT customer_id, ISNULL(title, 'No Title') AS title FROM sales_schema.customers;
GO

-- COALESCE returns the first non-NULL value.
SELECT customer_id, COALESCE(phone, email, 'No Contact') AS contact FROM sales_schema.customers;
GO

-- ============================================================

-- CAST AND CONVERT : CAST converts a value to another data type.
SELECT CAST(list_price AS INT) AS price_integer FROM production_schema.products;
GO

-- CONVERT also converts data types.
SELECT CONVERT(INT, list_price) AS price_integer FROM production_schema.products;
GO

-- Convert a date to text.
SELECT CONVERT(VARCHAR(10), order_date, 23) AS formatted_date FROM sales_schema.orders;
GO

-- ============================================================

-- CASE : CASE creates conditional output.
SELECT product_name, list_price, CASE WHEN list_price >= 2000 THEN 'Expensive' WHEN list_price >= 1000 THEN 'Medium' ELSE 'Cheap' END AS price_category FROM production_schema.products;
GO

-- CASE can work with text values.
SELECT order_id, order_status, CASE WHEN order_status = 'Completed' THEN 'Finished' WHEN order_status = 'Cancelled' THEN 'Stopped' ELSE 'In Progress' END AS order_group FROM sales_schema.orders;
GO

-- CASE can be used inside ORDER BY.
SELECT order_id, order_status FROM sales_schema.orders ORDER BY CASE WHEN order_status = 'Pending' THEN 1 WHEN order_status = 'Processing' THEN 2 WHEN order_status = 'Shipped' THEN 3 WHEN order_status = 'Completed' THEN 4 ELSE 5 END;
GO

-- ============================================================

-- AGGREGATE FUNCTIONS : COUNT counts rows.
SELECT COUNT(*) AS total_customers FROM sales_schema.customers;
GO

-- COUNT(column) ignores NULL values.
SELECT COUNT(title) AS customers_with_title FROM sales_schema.customers;
GO

-- SUM calculates the total.
SELECT SUM(list_price) AS total_product_prices FROM production_schema.products;
GO

-- AVG calculates the average.
SELECT AVG(list_price) AS average_price FROM production_schema.products;
GO

-- MIN returns the smallest value.
SELECT MIN(list_price) AS cheapest_price FROM production_schema.products;
GO

-- MAX returns the largest value.
SELECT MAX(list_price) AS highest_price FROM production_schema.products;
GO

-- ============================================================

-- GROUP BY : GROUP BY creates one result row for each group.
-- so this gets the count of each city
SELECT city, COUNT(*) AS customer_count FROM sales_schema.customers GROUP BY city;
GO

-- GROUP BY can calculate totals per category.
-- get the number of products in each cat
SELECT category_id, COUNT(*) AS product_count FROM production_schema.products GROUP BY category_id;
GO

-- GROUP BY can calculate average prices.
-- get the avg price of the proudcts in each brand
SELECT brand_id, AVG(list_price) AS average_price FROM production_schema.products GROUP BY brand_id;
GO

-- Multiple columns can be grouped.
SELECT city, state, COUNT(*) AS customer_count FROM sales_schema.customers GROUP BY city, state;
GO

-- ============================================================

-- HAVING : HAVING filters groups after GROUP BY.
SELECT city, COUNT(*) AS customer_count FROM sales_schema.customers GROUP BY city HAVING COUNT(*) > 1;
GO

-- WHERE filters rows before grouping.
-- HAVING filters groups after grouping.
SELECT category_id, AVG(list_price) AS average_price FROM production_schema.products WHERE list_price > 500 GROUP BY category_id HAVING AVG(list_price) > 1000;
GO

-- ============================================================

-- WHERE VS HAVING
/*
WHERE:
Filters individual rows.
HAVING:
Filters groups.
Execution idea:
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
*/

-- ============================================================

-- DISTINCT WITH FUNCTIONS : DISTINCT can be combined with functions.
SELECT DISTINCT YEAR(order_date) AS order_year FROM sales_schema.orders;
GO

-- ============================================================

-- CONDITIONAL AGGREGATION : CASE can be used inside aggregate functions.
SELECT COUNT(*) AS total_orders, SUM(CASE WHEN order_status = 'Completed' THEN 1 ELSE 0 END) AS completed_orders, SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders, SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders FROM sales_schema.orders;
GO

-- ============================================================

-- COUNT DISTINCT : COUNT DISTINCT counts unique values.
SELECT COUNT(DISTINCT city) AS unique_cities FROM sales_schema.customers;
GO

-- ============================================================

-- GROUP BY WITH CASE : CASE can create custom groups before aggregation.
SELECT CASE WHEN list_price >= 2000 THEN 'Expensive' WHEN list_price >= 1000 THEN 'Medium' ELSE 'Cheap' END AS price_group, COUNT(*) AS product_count FROM production_schema.products GROUP BY CASE WHEN list_price >= 2000 THEN 'Expensive' WHEN list_price >= 1000 THEN 'Medium' ELSE 'Cheap' END;
GO

-- ============================================================
