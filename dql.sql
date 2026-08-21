/*
============================================================
SQL SERVER DQL
Database: BikeStores

DQL = Data Query Language

Main DQL command:
SELECT -> retrieve / read data

Main topics:
SELECT
DISTINCT
TOP
WHERE
AND / OR / NOT
IN
BETWEEN
LIKE
IS NULL
ORDER BY
OFFSET / FETCH
ALIAS
CALCULATIONS
CASE
AGGREGATE FUNCTIONS
GROUP BY
HAVING
JOINS
SUBQUERIES
EXISTS
ANY / ALL
UNION
UNION ALL
INTERSECT
EXCEPT
CTE
WINDOW FUNCTIONS
ROW_NUMBER
RANK
DENSE_RANK
NTILE
LAG
LEAD
SUM OVER
AVG OVER
COUNT OVER
FIRST_VALUE
LAST_VALUE
PERCENT_RANK
VIEWS
SYSTEM INFORMATION
============================================================
*/


-- ============================================================
-- 1) DATABASE
-- ============================================================

-- Select the database that contains our tables.
USE BikeStores;
GO


-- ============================================================
-- 2) BASIC SELECT
-- ============================================================

-- SELECT * returns all columns.
SELECT *
FROM sales_schema.customers;
GO

-- SELECT specific columns.
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM sales_schema.customers;
GO

-- SELECT can return a calculated value.
SELECT
    first_name,
    last_name,
    customer_id + 100 AS new_id
FROM sales_schema.customers;
GO


-- ============================================================
-- 3) COLUMN ALIAS
-- ============================================================

-- AS gives a column a temporary display name.
SELECT
    first_name AS FirstName,
    last_name AS LastName,
    email AS EmailAddress
FROM sales_schema.customers;
GO

-- AS is optional for column aliases.
SELECT
    first_name FirstName,
    last_name LastName
FROM sales_schema.customers;
GO


-- ============================================================
-- 4) TABLE ALIAS
-- ============================================================

-- A table alias gives a short name to the table.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM sales_schema.customers AS c;
GO


-- ============================================================
-- 5) DISTINCT
-- ============================================================

-- DISTINCT removes duplicate values from the result.
SELECT DISTINCT
    city
FROM sales_schema.customers;
GO

-- DISTINCT works with combinations of columns.
SELECT DISTINCT
    city,
    state
FROM sales_schema.customers;
GO


-- ============================================================
-- 6) TOP
-- ============================================================

-- TOP returns the first specified number of rows.
SELECT TOP 3
    *
FROM sales_schema.customers;
GO

-- TOP with ORDER BY returns the top rows based on sorting.
SELECT TOP 3
    *
FROM production_schema.products
ORDER BY list_price DESC;
GO

-- TOP PERCENT returns a percentage of the rows.
SELECT TOP 50 PERCENT
    *
FROM production_schema.products;
GO


-- ============================================================
-- 7) WHERE
-- ============================================================

-- WHERE filters rows based on a condition.
SELECT *
FROM sales_schema.customers
WHERE city = 'Cairo';
GO

-- WHERE can compare numbers.
SELECT *
FROM production_schema.products
WHERE list_price > 1000;
GO

-- WHERE can compare dates.
SELECT *
FROM sales_schema.orders
WHERE order_date >= '2026-08-01';
GO


-- ============================================================
-- 8) COMPARISON OPERATORS
-- ============================================================

-- Equal to uses =.
SELECT *
FROM production_schema.products
WHERE list_price = 1500;
GO

-- Not equal can use <>.
SELECT *
FROM production_schema.products
WHERE list_price <> 1500;
GO

-- Greater than uses >.
SELECT *
FROM production_schema.products
WHERE list_price > 1000;
GO

-- Less than uses <.
SELECT *
FROM production_schema.products
WHERE list_price < 1000;
GO

-- Greater than or equal uses >=.
SELECT *
FROM production_schema.products
WHERE list_price >= 1000;
GO

-- Less than or equal uses <=.
SELECT *
FROM production_schema.products
WHERE list_price <= 1000;
GO


-- ============================================================
-- 9) AND
-- ============================================================

-- AND requires all conditions to be true.
SELECT *
FROM production_schema.products
WHERE list_price > 500
  AND list_price < 2000;
GO


-- ============================================================
-- 10) OR
-- ============================================================

-- OR requires at least one condition to be true.
SELECT *
FROM sales_schema.customers
WHERE city = 'Cairo'
   OR city = 'Alex';
GO


-- ============================================================
-- 11) NOT
-- ============================================================

-- NOT reverses a condition.
SELECT *
FROM sales_schema.customers
WHERE NOT city = 'Cairo';
GO


-- ============================================================
-- 12) COMBINING AND / OR
-- ============================================================

-- Parentheses control the order of logical conditions.
SELECT *
FROM production_schema.products
WHERE
    (category_id = 1 OR category_id = 2)
    AND list_price > 1000;
GO


-- ============================================================
-- 13) IN
-- ============================================================

-- IN checks whether a value exists in a list.
SELECT *
FROM sales_schema.customers
WHERE city IN ('Cairo', 'Alex');
GO

-- NOT IN excludes values from a list.
SELECT *
FROM sales_schema.customers
WHERE city NOT IN ('Cairo', 'Alex');
GO


-- ============================================================
-- 14) BETWEEN
-- ============================================================

-- BETWEEN checks whether a value is inside a range.
SELECT *
FROM production_schema.products
WHERE list_price BETWEEN 500 AND 1500;
GO

-- NOT BETWEEN excludes a range.
SELECT *
FROM production_schema.products
WHERE list_price NOT BETWEEN 500 AND 1500;
GO

-- BETWEEN can be used with dates.
SELECT *
FROM sales_schema.orders
WHERE order_date BETWEEN '2026-08-01' AND '2026-08-31';
GO


-- ============================================================
-- 15) LIKE
-- ============================================================

-- LIKE searches for a text pattern.
SELECT *
FROM sales_schema.customers
WHERE first_name LIKE 'A%';
GO

-- % means zero or more characters.
SELECT *
FROM sales_schema.customers
WHERE first_name LIKE '%a%';
GO

-- % at the end means starts with the value.
SELECT *
FROM sales_schema.customers
WHERE last_name LIKE 'A%';
GO

-- % at the beginning means ends with the value.
SELECT *
FROM sales_schema.customers
WHERE last_name LIKE '%n';
GO

-- _ represents exactly one character.
SELECT *
FROM sales_schema.customers
WHERE first_name LIKE '_hmed';
GO

-- NOT LIKE excludes a pattern.
SELECT *
FROM sales_schema.customers
WHERE first_name NOT LIKE 'A%';
GO


-- ============================================================
-- 16) NULL
-- ============================================================

-- NULL means the value is missing or unknown.
SELECT *
FROM sales_schema.customers
WHERE title IS NULL;
GO

-- IS NOT NULL finds rows that contain a value.
SELECT *
FROM sales_schema.customers
WHERE title IS NOT NULL;
GO

-- Do not use = NULL.
-- Correct syntax is IS NULL.


-- ============================================================
-- 17) ORDER BY
-- ============================================================

-- ORDER BY sorts the result in ascending order.
SELECT *
FROM production_schema.products
ORDER BY list_price ASC;
GO

-- DESC sorts the result in descending order.
SELECT *
FROM production_schema.products
ORDER BY list_price DESC;
GO

-- Multiple columns can be sorted.
SELECT *
FROM sales_schema.customers
ORDER BY city ASC, first_name ASC;
GO

-- ORDER BY can use a column alias.
SELECT
    product_name,
    list_price AS Price
FROM production_schema.products
ORDER BY Price DESC;
GO


-- ============================================================
-- 18) ORDER BY COLUMN NUMBER
-- ============================================================

-- SQL Server allows ordering by the column position.
SELECT
    product_id,
    product_name,
    list_price
FROM production_schema.products
ORDER BY 3 DESC;
GO

-- Prefer column names because they are easier to understand.


-- ============================================================
-- 19) CALCULATED COLUMNS
-- ============================================================

-- Arithmetic operators can be used inside SELECT.
SELECT
    product_name,
    list_price,
    list_price + 100 AS new_price
FROM production_schema.products;
GO

-- Multiplication can calculate totals.
SELECT
    product_name,
    list_price,
    list_price * 2 AS price_for_two
FROM production_schema.products;
GO

-- Order item total before discount.
SELECT
    order_id,
    product_id,
    quantity,
    list_price,
    quantity * list_price AS total_price
FROM sales_schema.order_items;
GO

-- Order item total after discount.
SELECT
    order_id,
    product_id,
    quantity,
    list_price,
    discount,
    quantity * list_price * (1 - discount / 100.0) AS final_price
FROM sales_schema.order_items;
GO


-- ============================================================
-- 20) CONCATENATION
-- ============================================================

-- + can combine text values.
SELECT
    first_name + ' ' + last_name AS full_name
FROM sales_schema.customers;
GO

-- CONCAT is safer when NULL values may exist.
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM sales_schema.customers;
GO


-- ============================================================
-- 21) STRING FUNCTIONS
-- ============================================================

-- LEN returns the number of characters.
SELECT
    first_name,
    LEN(first_name) AS name_length
FROM sales_schema.customers;
GO

-- UPPER converts text to uppercase.
SELECT
    UPPER(first_name) AS upper_name
FROM sales_schema.customers;
GO

-- LOWER converts text to lowercase.
SELECT
    LOWER(first_name) AS lower_name
FROM sales_schema.customers;
GO

-- LEFT returns characters from the left.
SELECT
    first_name,
    LEFT(first_name, 2) AS first_two
FROM sales_schema.customers;
GO

-- RIGHT returns characters from the right.
SELECT
    last_name,
    RIGHT(last_name, 2) AS last_two
FROM sales_schema.customers;
GO

-- SUBSTRING extracts part of a string.
SELECT
    first_name,
    SUBSTRING(first_name, 1, 3) AS first_three
FROM sales_schema.customers;
GO

-- LTRIM removes spaces from the left.
SELECT LTRIM('   Ahmed') AS result;
GO

-- RTRIM removes spaces from the right.
SELECT RTRIM('Ahmed   ') AS result;
GO

-- TRIM removes spaces from both sides.
SELECT TRIM('   Ahmed   ') AS result;
GO

-- REPLACE replaces part of a string.
SELECT
    REPLACE(email, '@gmail.com', '@example.com') AS new_email
FROM sales_schema.customers;
GO

-- CHARINDEX finds the position of text.
SELECT
    email,
    CHARINDEX('@', email) AS at_position
FROM sales_schema.customers;
GO


-- ============================================================
-- 22) NUMERIC FUNCTIONS
-- ============================================================

-- ROUND rounds a number.
SELECT
    ROUND(list_price, 0) AS rounded_price
FROM production_schema.products;
GO

-- CEILING rounds a number upward.
SELECT
    CEILING(list_price / 100.0) AS rounded_up
FROM production_schema.products;
GO

-- FLOOR rounds a number downward.
SELECT
    FLOOR(list_price / 100.0) AS rounded_down
FROM production_schema.products;
GO

-- ABS returns the absolute value.
SELECT
    ABS(-100) AS absolute_value;
GO


-- ============================================================
-- 23) DATE FUNCTIONS
-- ============================================================

-- GETDATE returns the current date and time.
SELECT GETDATE() AS current_datetime;
GO

-- CAST can convert the current datetime to DATE.
SELECT
    CAST(GETDATE() AS DATE) AS current_date;
GO

-- YEAR returns the year.
SELECT
    order_id,
    YEAR(order_date) AS order_year
FROM sales_schema.orders;
GO

-- MONTH returns the month.
SELECT
    order_id,
    MONTH(order_date) AS order_month
FROM sales_schema.orders;
GO

-- DAY returns the day.
SELECT
    order_id,
    DAY(order_date) AS order_day
FROM sales_schema.orders;
GO

-- DATEPART extracts a date part.
SELECT
    order_id,
    DATEPART(YEAR, order_date) AS order_year
FROM sales_schema.orders;
GO

-- DATEADD adds time to a date.
SELECT
    order_date,
    DATEADD(DAY, 7, order_date) AS after_7_days
FROM sales_schema.orders;
GO

-- DATEDIFF calculates the difference between dates.
SELECT
    order_id,
    DATEDIFF(DAY, order_date, shipped_date) AS shipping_days
FROM sales_schema.orders
WHERE shipped_date IS NOT NULL;
GO


-- ============================================================
-- 24) NULL FUNCTIONS
-- ============================================================

-- ISNULL replaces NULL with another value.
SELECT
    customer_id,
    ISNULL(title, 'No Title') AS title
FROM sales_schema.customers;
GO

-- COALESCE returns the first non-NULL value.
SELECT
    customer_id,
    COALESCE(phone, email, 'No Contact') AS contact
FROM sales_schema.customers;
GO


-- ============================================================
-- 25) CAST AND CONVERT
-- ============================================================

-- CAST converts a value to another data type.
SELECT
    CAST(list_price AS INT) AS price_integer
FROM production_schema.products;
GO

-- CONVERT also converts data types.
SELECT
    CONVERT(INT, list_price) AS price_integer
FROM production_schema.products;
GO

-- Convert a date to text.
SELECT
    CONVERT(VARCHAR(10), order_date, 23) AS formatted_date
FROM sales_schema.orders;
GO


-- ============================================================
-- 26) CASE
-- ============================================================

-- CASE creates conditional output.
SELECT
    product_name,
    list_price,
    CASE
        WHEN list_price >= 2000 THEN 'Expensive'
        WHEN list_price >= 1000 THEN 'Medium'
        ELSE 'Cheap'
    END AS price_category
FROM production_schema.products;
GO

-- CASE can work with text values.
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'Completed' THEN 'Finished'
        WHEN order_status = 'Cancelled' THEN 'Stopped'
        ELSE 'In Progress'
    END AS order_group
FROM sales_schema.orders;
GO

-- CASE can be used inside ORDER BY.
SELECT
    order_id,
    order_status
FROM sales_schema.orders
ORDER BY
    CASE
        WHEN order_status = 'Pending' THEN 1
        WHEN order_status = 'Processing' THEN 2
        WHEN order_status = 'Shipped' THEN 3
        WHEN order_status = 'Completed' THEN 4
        ELSE 5
    END;
GO


-- ============================================================
-- 27) AGGREGATE FUNCTIONS
-- ============================================================

-- COUNT counts rows.
SELECT COUNT(*) AS total_customers
FROM sales_schema.customers;
GO

-- COUNT(column) ignores NULL values.
SELECT COUNT(title) AS customers_with_title
FROM sales_schema.customers;
GO

-- SUM calculates the total.
SELECT SUM(list_price) AS total_product_prices
FROM production_schema.products;
GO

-- AVG calculates the average.
SELECT AVG(list_price) AS average_price
FROM production_schema.products;
GO

-- MIN returns the smallest value.
SELECT MIN(list_price) AS cheapest_price
FROM production_schema.products;
GO

-- MAX returns the largest value.
SELECT MAX(list_price) AS highest_price
FROM production_schema.products;
GO


-- ============================================================
-- 28) GROUP BY
-- ============================================================

-- GROUP BY creates one result row for each group.
SELECT
    city,
    COUNT(*) AS customer_count
FROM sales_schema.customers
GROUP BY city;
GO

-- GROUP BY can calculate totals per category.
SELECT
    category_id,
    COUNT(*) AS product_count
FROM production_schema.products
GROUP BY category_id;
GO

-- GROUP BY can calculate average prices.
SELECT
    brand_id,
    AVG(list_price) AS average_price
FROM production_schema.products
GROUP BY brand_id;
GO

-- Multiple columns can be grouped.
SELECT
    city,
    state,
    COUNT(*) AS customer_count
FROM sales_schema.customers
GROUP BY city, state;
GO


-- ============================================================
-- 29) HAVING
-- ============================================================

-- HAVING filters groups after GROUP BY.
SELECT
    city,
    COUNT(*) AS customer_count
FROM sales_schema.customers
GROUP BY city
HAVING COUNT(*) > 1;
GO

-- WHERE filters rows before grouping.
-- HAVING filters groups after grouping.
SELECT
    category_id,
    AVG(list_price) AS average_price
FROM production_schema.products
WHERE list_price > 500
GROUP BY category_id
HAVING AVG(list_price) > 1000;
GO


-- ============================================================
-- 30) WHERE VS HAVING
-- ============================================================

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
-- 31) INNER JOIN
-- ============================================================

-- INNER JOIN returns matching rows from both tables.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_status
FROM sales_schema.customers AS c
INNER JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id;
GO


-- ============================================================
-- 32) LEFT JOIN
-- ============================================================

-- LEFT JOIN returns all rows from the left table.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id;
GO

-- LEFT JOIN can find customers without orders.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
GO


-- ============================================================
-- 33) RIGHT JOIN
-- ============================================================

-- RIGHT JOIN returns all rows from the right table.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sales_schema.customers AS c
RIGHT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id;
GO


-- ============================================================
-- 34) FULL OUTER JOIN
-- ============================================================

-- FULL JOIN returns matched and unmatched rows from both tables.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sales_schema.customers AS c
FULL OUTER JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id;
GO


-- ============================================================
-- 35) CROSS JOIN
-- ============================================================

-- CROSS JOIN creates every possible combination.
SELECT
    c.first_name,
    s.store_name
FROM sales_schema.customers AS c
CROSS JOIN sales_schema.stores AS s;
GO


-- ============================================================
-- 36) SELF JOIN
-- ============================================================

-- SELF JOIN joins a table to itself.
SELECT
    e.staff_id,
    e.first_name AS employee,
    m.first_name AS manager
FROM sales_schema.staff AS e
LEFT JOIN sales_schema.staff AS m
    ON e.manager_id = m.staff_id;
GO


-- ============================================================
-- 37) MULTIPLE JOINS
-- ============================================================

-- Multiple JOINs can connect several related tables.
SELECT
    o.order_id,
    c.first_name,
    s.store_name,
    st.first_name AS staff_name
FROM sales_schema.orders AS o
INNER JOIN sales_schema.customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN sales_schema.stores AS s
    ON o.store_id = s.store_id
LEFT JOIN sales_schema.staff AS st
    ON o.staff_id = st.staff_id;
GO


-- ============================================================
-- 38) JOIN PRODUCTS WITH BRANDS AND CATEGORIES
-- ============================================================

-- JOIN can be used to replace foreign key IDs with names.
SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM production_schema.products AS p
INNER JOIN production_schema.brands AS b
    ON p.brand_id = b.brand_id
INNER JOIN production_schema.categories AS c
    ON p.category_id = c.category_id;
GO


-- ============================================================
-- 39) JOIN WITH CALCULATIONS
-- ============================================================

-- JOIN can be combined with calculated columns.
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.quantity * oi.list_price AS gross_total,
    oi.quantity * oi.list_price * (1 - oi.discount / 100.0) AS final_total
FROM sales_schema.order_items AS oi
INNER JOIN production_schema.products AS p
    ON oi.product_id = p.product_id;
GO


-- ============================================================
-- 40) JOIN WITH GROUP BY
-- ============================================================

-- JOIN and GROUP BY can calculate totals per customer.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;
GO


-- ============================================================
-- 41) SUBQUERY
-- ============================================================

-- A subquery is a query inside another query.
SELECT *
FROM production_schema.products
WHERE list_price >
(
    SELECT AVG(list_price)
    FROM production_schema.products
);
GO


-- ============================================================
-- 42) SUBQUERY WITH IN
-- ============================================================

-- IN can use a subquery as its list.
SELECT *
FROM sales_schema.customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM sales_schema.orders
);
GO


-- ============================================================
-- 43) SUBQUERY WITH NOT IN
-- ============================================================

-- NOT IN finds values that do not appear in the subquery.
SELECT *
FROM sales_schema.customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM sales_schema.orders
);
GO


-- ============================================================
-- 44) CORRELATED SUBQUERY
-- ============================================================

-- A correlated subquery depends on the outer query.
SELECT
    p.product_name,
    p.list_price
FROM production_schema.products AS p
WHERE p.list_price >
(
    SELECT AVG(p2.list_price)
    FROM production_schema.products AS p2
    WHERE p2.category_id = p.category_id
);
GO


-- ============================================================
-- 45) EXISTS
-- ============================================================

-- EXISTS checks whether the subquery returns at least one row.
SELECT *
FROM sales_schema.customers AS c
WHERE EXISTS
(
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO


-- ============================================================
-- 46) NOT EXISTS
-- ============================================================

-- NOT EXISTS finds rows without a matching row.
SELECT *
FROM sales_schema.customers AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO


-- ============================================================
-- 47) ANY
-- ============================================================

-- ANY compares a value with any value returned by a subquery.
SELECT *
FROM production_schema.products
WHERE list_price > ANY
(
    SELECT list_price
    FROM production_schema.products
    WHERE category_id = 1
);
GO


-- ============================================================
-- 48) ALL
-- ============================================================

-- ALL compares a value with every value returned by a subquery.
SELECT *
FROM production_schema.products
WHERE list_price > ALL
(
    SELECT list_price
    FROM production_schema.products
    WHERE category_id = 1
);
GO


-- ============================================================
-- 49) UNION
-- ============================================================

-- UNION combines results and removes duplicates.
SELECT city
FROM sales_schema.customers
UNION
SELECT city
FROM sales_schema.stores;
GO


-- ============================================================
-- 50) UNION ALL
-- ============================================================

-- UNION ALL combines results and keeps duplicates.
SELECT city
FROM sales_schema.customers
UNION ALL
SELECT city
FROM sales_schema.stores;
GO


-- ============================================================
-- 51) INTERSECT
-- ============================================================

-- INTERSECT returns values existing in both result sets.
SELECT city
FROM sales_schema.customers
INTERSECT
SELECT city
FROM sales_schema.stores;
GO


-- ============================================================
-- 52) EXCEPT
-- ============================================================

-- EXCEPT returns values from the first query not found in the second.
SELECT city
FROM sales_schema.customers
EXCEPT
SELECT city
FROM sales_schema.stores;
GO


-- ============================================================
-- 53) RULES FOR SET OPERATORS
-- ============================================================

/*
UNION
UNION ALL
INTERSECT
EXCEPT

The SELECT statements should have:
    same number of columns
    compatible data types
    compatible column positions
*/


-- ============================================================
-- 54) CTE
-- ============================================================

-- CTE creates a temporary named result for one statement.
WITH ProductData AS
(
    SELECT
        product_id,
        product_name,
        list_price
    FROM production_schema.products
)
SELECT *
FROM ProductData;
GO


-- ============================================================
-- 55) CTE WITH FILTER
-- ============================================================

-- CTE can make a complex query easier to read.
WITH ExpensiveProducts AS
(
    SELECT
        product_id,
        product_name,
        list_price
    FROM production_schema.products
    WHERE list_price > 1000
)
SELECT *
FROM ExpensiveProducts
ORDER BY list_price DESC;
GO


-- ============================================================
-- 56) CTE WITH GROUP BY
-- ============================================================

-- CTE can store an aggregated result.
WITH CustomerOrders AS
(
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM sales_schema.orders
    GROUP BY customer_id
)
SELECT *
FROM CustomerOrders
WHERE order_count > 1;
GO


-- ============================================================
-- 57) RECURSIVE CTE
-- ============================================================

-- Recursive CTE can generate a sequence of numbers.
WITH Numbers AS
(
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM Numbers
    WHERE number < 10
)
SELECT *
FROM Numbers
OPTION (MAXRECURSION 100);
GO


-- ============================================================
-- 58) ROW_NUMBER
-- ============================================================

-- ROW_NUMBER gives every row a unique sequential number.
SELECT
    product_id,
    product_name,
    list_price,
    ROW_NUMBER() OVER
    (
        ORDER BY list_price DESC
    ) AS row_number
FROM production_schema.products;
GO


-- ============================================================
-- 59) ROW_NUMBER PARTITION BY
-- ============================================================

-- PARTITION BY restarts the row number for every group.
SELECT
    product_id,
    product_name,
    category_id,
    list_price,
    ROW_NUMBER() OVER
    (
        PARTITION BY category_id
        ORDER BY list_price DESC
    ) AS row_number
FROM production_schema.products;
GO


-- ============================================================
-- 60) RANK
-- ============================================================

-- RANK gives the same rank to tied values and leaves gaps.
SELECT
    product_name,
    list_price,
    RANK() OVER
    (
        ORDER BY list_price DESC
    ) AS price_rank
FROM production_schema.products;
GO


-- ============================================================
-- 61) DENSE_RANK
-- ============================================================

-- DENSE_RANK gives the same rank to ties without gaps.
SELECT
    product_name,
    list_price,
    DENSE_RANK() OVER
    (
        ORDER BY list_price DESC
    ) AS price_rank
FROM production_schema.products;
GO


-- ============================================================
-- 62) NTILE
-- ============================================================

-- NTILE divides rows into a specified number of groups.
SELECT
    product_name,
    list_price,
    NTILE(4) OVER
    (
        ORDER BY list_price DESC
    ) AS price_group
FROM production_schema.products;
GO


-- ============================================================
-- 63) SUM OVER
-- ============================================================

-- SUM OVER calculates a total without grouping the rows.
SELECT
    product_id,
    product_name,
    list_price,
    SUM(list_price) OVER () AS total_price
FROM production_schema.products;
GO


-- ============================================================
-- 64) SUM OVER PARTITION
-- ============================================================

-- SUM OVER PARTITION calculates a total for every group.
SELECT
    product_id,
    product_name,
    category_id,
    list_price,
    SUM(list_price) OVER
    (
        PARTITION BY category_id
    ) AS category_total
FROM production_schema.products;
GO


-- ============================================================
-- 65) AVG OVER
-- ============================================================

-- AVG OVER calculates an average without collapsing rows.
SELECT
    product_id,
    product_name,
    list_price,
    AVG(list_price) OVER () AS average_price
FROM production_schema.products;
GO


-- ============================================================
-- 66) AVG OVER PARTITION
-- ============================================================

-- AVG OVER PARTITION calculates an average per group.
SELECT
    product_id,
    product_name,
    category_id,
    list_price,
    AVG(list_price) OVER
    (
        PARTITION BY category_id
    ) AS category_average
FROM production_schema.products;
GO


-- ============================================================
-- 67) COUNT OVER
-- ============================================================

-- COUNT OVER counts rows without grouping them.
SELECT
    product_id,
    product_name,
    COUNT(*) OVER () AS total_products
FROM production_schema.products;
GO


-- ============================================================
-- 68) MIN OVER
-- ============================================================

-- MIN OVER returns the minimum value while keeping every row.
SELECT
    product_name,
    list_price,
    MIN(list_price) OVER () AS minimum_price
FROM production_schema.products;
GO


-- ============================================================
-- 69) MAX OVER
-- ============================================================

-- MAX OVER returns the maximum value while keeping every row.
SELECT
    product_name,
    list_price,
    MAX(list_price) OVER () AS maximum_price
FROM production_schema.products;
GO


-- ============================================================
-- 70) LAG
-- ============================================================

-- LAG accesses a value from a previous row.
SELECT
    product_id,
    product_name,
    list_price,
    LAG(list_price) OVER
    (
        ORDER BY product_id
    ) AS previous_price
FROM production_schema.products;
GO


-- ============================================================
-- 71) LEAD
-- ============================================================

-- LEAD accesses a value from the next row.
SELECT
    product_id,
    product_name,
    list_price,
    LEAD(list_price) OVER
    (
        ORDER BY product_id
    ) AS next_price
FROM production_schema.products;
GO


-- ============================================================
-- 72) FIRST_VALUE
-- ============================================================

-- FIRST_VALUE returns the first value in the window.
SELECT
    product_name,
    list_price,
    FIRST_VALUE(list_price) OVER
    (
        ORDER BY list_price DESC
    ) AS highest_price
FROM production_schema.products;
GO


-- ============================================================
-- 73) LAST_VALUE
-- ============================================================

-- LAST_VALUE returns the last value in the window frame.
SELECT
    product_name,
    list_price,
    LAST_VALUE(list_price) OVER
    (
        ORDER BY list_price DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_price
FROM production_schema.products;
GO


-- ============================================================
-- 74) PERCENT_RANK
-- ============================================================

-- PERCENT_RANK returns the relative rank from 0 to 1.
SELECT
    product_name,
    list_price,
    PERCENT_RANK() OVER
    (
        ORDER BY list_price
    ) AS percent_rank
FROM production_schema.products;
GO


-- ============================================================
-- 75) WINDOW FRAME
-- ============================================================

-- Window frames control which rows participate in the calculation.
SELECT
    product_id,
    product_name,
    list_price,
    SUM(list_price) OVER
    (
        ORDER BY product_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM production_schema.products;
GO


-- ============================================================
-- 76) RUNNING TOTAL
-- ============================================================

-- Running total adds the current row to all previous rows.
SELECT
    product_id,
    product_name,
    list_price,
    SUM(list_price) OVER
    (
        ORDER BY product_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM production_schema.products;
GO


-- ============================================================
-- 77) MOVING AVERAGE
-- ============================================================

-- Moving average calculates an average over nearby rows.
SELECT
    product_id,
    product_name,
    list_price,
    AVG(list_price) OVER
    (
        ORDER BY product_id
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_average
FROM production_schema.products;
GO


-- ============================================================
-- 78) TOP N PER GROUP
-- ============================================================

-- ROW_NUMBER can find the top products inside every category.
WITH RankedProducts AS
(
    SELECT
        product_id,
        product_name,
        category_id,
        list_price,
        ROW_NUMBER() OVER
        (
            PARTITION BY category_id
            ORDER BY list_price DESC
        ) AS rn
    FROM production_schema.products
)
SELECT *
FROM RankedProducts
WHERE rn <= 2;
GO


-- ============================================================
-- 79) OFFSET
-- ============================================================

-- OFFSET skips a specified number of rows.
SELECT *
FROM production_schema.products
ORDER BY product_id
OFFSET 2 ROWS;
GO


-- ============================================================
-- 80) OFFSET + FETCH
-- ============================================================

-- FETCH returns a specific number of rows after OFFSET.
SELECT *
FROM production_schema.products
ORDER BY product_id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;
GO


-- ============================================================
-- 81) PAGINATION
-- ============================================================

-- OFFSET and FETCH are commonly used for pagination.
DECLARE @PageNumber INT = 1;
DECLARE @PageSize INT = 2;

SELECT *
FROM production_schema.products
ORDER BY product_id
OFFSET (@PageNumber - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY;
GO


-- ============================================================
-- 82) DISTINCT WITH FUNCTIONS
-- ============================================================

-- DISTINCT can be combined with functions.
SELECT DISTINCT
    YEAR(order_date) AS order_year
FROM sales_schema.orders;
GO


-- ============================================================
-- 83) DISTINCT WITH JOIN
-- ============================================================

-- DISTINCT can remove duplicate values produced by a JOIN.
SELECT DISTINCT
    c.customer_id,
    c.first_name
FROM sales_schema.customers AS c
INNER JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id;
GO


-- ============================================================
-- 84) AGGREGATE WITH JOIN
-- ============================================================

-- Aggregate functions can be used across joined tables.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.list_price) AS total_spent
FROM sales_schema.customers AS c
INNER JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN sales_schema.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;
GO


-- ============================================================
-- 85) HAVING WITH JOIN
-- ============================================================

-- HAVING can filter aggregated JOIN results.
SELECT
    c.customer_id,
    c.first_name,
    COUNT(o.order_id) AS order_count
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name
HAVING COUNT(o.order_id) >= 1;
GO


-- ============================================================
-- 86) CONDITIONAL AGGREGATION
-- ============================================================

-- CASE can be used inside aggregate functions.
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Completed' THEN 1 ELSE 0 END)
        AS completed_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled_orders,
    SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END)
        AS pending_orders
FROM sales_schema.orders;
GO


-- ============================================================
-- 87) COUNT DISTINCT
-- ============================================================

-- COUNT DISTINCT counts unique values.
SELECT
    COUNT(DISTINCT city) AS unique_cities
FROM sales_schema.customers;
GO


-- ============================================================
-- 88) GROUP BY WITH CASE
-- ============================================================

-- CASE can create custom groups before aggregation.
SELECT
    CASE
        WHEN list_price >= 2000 THEN 'Expensive'
        WHEN list_price >= 1000 THEN 'Medium'
        ELSE 'Cheap'
    END AS price_group,
    COUNT(*) AS product_count
FROM production_schema.products
GROUP BY
    CASE
        WHEN list_price >= 2000 THEN 'Expensive'
        WHEN list_price >= 1000 THEN 'Medium'
        ELSE 'Cheap'
    END;
GO


-- ============================================================
-- 89) SUBQUERY IN SELECT
-- ============================================================

-- A scalar subquery can appear inside SELECT.
SELECT
    p.product_name,
    p.list_price,
    (
        SELECT AVG(list_price)
        FROM production_schema.products
    ) AS average_price
FROM production_schema.products AS p;
GO


-- ============================================================
-- 90) SUBQUERY IN FROM
-- ============================================================

-- A subquery in FROM creates a derived table.
SELECT *
FROM
(
    SELECT
        product_id,
        product_name,
        list_price
    FROM production_schema.products
    WHERE list_price > 1000
) AS ExpensiveProducts;
GO


-- ============================================================
-- 91) DERIVED TABLE WITH AGGREGATION
-- ============================================================

-- A derived table can contain grouped data.
SELECT *
FROM
(
    SELECT
        category_id,
        AVG(list_price) AS average_price
    FROM production_schema.products
    GROUP BY category_id
) AS CategoryPrices
WHERE average_price > 1000;
GO


-- ============================================================
-- 92) VIEWS
-- ============================================================

-- A VIEW stores a SELECT query as a virtual table.
-- Creating a view is DDL, but querying a view is DQL.
GO

/*
CREATE OR ALTER VIEW production_schema.product_details
AS
SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM production_schema.products AS p
INNER JOIN production_schema.brands AS b
    ON p.brand_id = b.brand_id
INNER JOIN production_schema.categories AS c
    ON p.category_id = c.category_id;
GO
*/

-- Query the view after creating it.
-- SELECT *
-- FROM production_schema.product_details;
-- GO


-- ============================================================
-- 93) INFORMATION FROM SYSTEM TABLES
-- ============================================================

-- sys.tables contains information about tables.
SELECT
    name AS table_name
FROM sys.tables;
GO

-- sys.columns contains information about columns.
SELECT
    OBJECT_SCHEMA_NAME(object_id) AS schema_name,
    OBJECT_NAME(object_id) AS table_name,
    name AS column_name
FROM sys.columns;
GO

-- INFORMATION_SCHEMA.TABLES provides table metadata.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;
GO

-- INFORMATION_SCHEMA.COLUMNS provides column metadata.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS;
GO


-- ============================================================
-- 94) SELECT INTO
-- ============================================================

-- SELECT INTO creates a new table from a SELECT result.
-- This is technically DDL + query functionality.
-- Use carefully because it creates a physical table.

/*
SELECT
    product_id,
    product_name,
    list_price
INTO production_schema.products_backup
FROM production_schema.products;
GO
*/


-- ============================================================
-- 95) INSERT INTO SELECT
-- ============================================================

-- INSERT INTO SELECT copies query results into an existing table.
-- This is DML, shown here because it is commonly used with DQL.

/*
INSERT INTO production_schema.products_backup
(
    product_id,
    product_name,
    list_price
)
SELECT
    product_id,
    product_name,
    list_price
FROM production_schema.products;
GO
*/


-- ============================================================
-- 96) ORDER OF QUERY EXECUTION
-- ============================================================

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
-- ============================================================

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
-- 98) DQL EXAMPLE - CUSTOMER ORDERS
-- ============================================================

-- Show customers with their orders.
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_status,
    o.order_date
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
ORDER BY
    c.customer_id,
    o.order_date;
GO


-- ============================================================
-- 99) DQL EXAMPLE - PRODUCT DETAILS
-- ============================================================

-- Show complete product information.
SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM production_schema.products AS p
INNER JOIN production_schema.brands AS b
    ON p.brand_id = b.brand_id
INNER JOIN production_schema.categories AS c
    ON p.category_id = c.category_id
ORDER BY
    p.list_price DESC;
GO


-- ============================================================
-- 100) DQL EXAMPLE - CUSTOMER SPENDING
-- ============================================================

-- Calculate how much each customer spent.
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COALESCE
    (
        SUM
        (
            oi.quantity
            * oi.list_price
            * (1 - oi.discount / 100.0)
        ),
        0
    ) AS total_spent
FROM sales_schema.customers AS c
LEFT JOIN sales_schema.orders AS o
    ON c.customer_id = o.customer_id
LEFT JOIN sales_schema.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_spent DESC;
GO


-- ============================================================
-- 101) DQL EXAMPLE - BEST PRODUCTS
-- ============================================================

-- Calculate total quantity sold for every product.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM production_schema.products AS p
INNER JOIN sales_schema.order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_quantity_sold DESC;
GO


-- ============================================================
-- 102) DQL EXAMPLE - ORDER SUMMARY
-- ============================================================

-- Show the number of orders for every status.
SELECT
    order_status,
    COUNT(*) AS order_count
FROM sales_schema.orders
GROUP BY
    order_status
ORDER BY
    order_count DESC;
GO


-- ============================================================
-- 103) DQL EXAMPLE - STORE PERFORMANCE
-- ============================================================

-- Calculate order count for every store.
SELECT
    s.store_id,
    s.store_name,
    COUNT(o.order_id) AS order_count
FROM sales_schema.stores AS s
LEFT JOIN sales_schema.orders AS o
    ON s.store_id = o.store_id
GROUP BY
    s.store_id,
    s.store_name
ORDER BY
    order_count DESC;
GO


-- ============================================================
-- 104) DQL EXAMPLE - STAFF AND MANAGERS
-- ============================================================

-- Show every employee with the manager name.
SELECT
    e.staff_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM sales_schema.staff AS e
LEFT JOIN sales_schema.staff AS m
    ON e.manager_id = m.staff_id
ORDER BY
    e.staff_id;
GO


-- ============================================================
-- 105) DQL EXAMPLE - STOCK
-- ============================================================

-- Show stock with store and product names.
SELECT
    s.store_name,
    p.product_name,
    st.quantity
FROM production_schema.stocks AS st
INNER JOIN sales_schema.stores AS s
    ON st.store_id = s.store_id
INNER JOIN production_schema.products AS p
    ON st.product_id = p.product_id
ORDER BY
    s.store_name,
    p.product_name;
GO


-- ============================================================
-- 106) DQL EXAMPLE - PRODUCTS ABOVE AVERAGE
-- ============================================================

-- Find products more expensive than the average product.
SELECT
    product_id,
    product_name,
    list_price
FROM production_schema.products
WHERE list_price >
(
    SELECT AVG(list_price)
    FROM production_schema.products
)
ORDER BY list_price DESC;
GO


-- ============================================================
-- 107) DQL EXAMPLE - CUSTOMERS WITH ORDERS
-- ============================================================

-- EXISTS finds customers who placed at least one order.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM sales_schema.customers AS c
WHERE EXISTS
(
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO


-- ============================================================
-- 108) DQL EXAMPLE - CUSTOMERS WITHOUT ORDERS
-- ============================================================

-- NOT EXISTS finds customers who have no orders.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM sales_schema.customers AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO


-- ============================================================
-- 109) DQL EXAMPLE - TOP 3 PRODUCTS
-- ============================================================

-- TOP can return the three most expensive products.
SELECT TOP 3
    product_id,
    product_name,
    list_price
FROM production_schema.products
ORDER BY
    list_price DESC;
GO


-- ============================================================
-- 110) DQL EXAMPLE - RANK PRODUCTS
-- ============================================================

-- RANK can rank products according to their prices.
SELECT
    product_id,
    product_name,
    list_price,
    RANK() OVER
    (
        ORDER BY list_price DESC
    ) AS price_rank
FROM production_schema.products;
GO


-- ============================================================
-- 111) DQL EXAMPLE - RUNNING SALES TOTAL
-- ============================================================

-- Calculate a running sales total.
SELECT
    oi.order_id,
    oi.item_id,
    oi.quantity * oi.list_price AS order_total,
    SUM(oi.quantity * oi.list_price) OVER
    (
        ORDER BY oi.order_id, oi.item_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM sales_schema.order_items AS oi;
GO


-- ============================================================
-- 112) DQL EXAMPLE - PREVIOUS PRODUCT PRICE
-- ============================================================

-- LAG compares the current price with the previous product price.
SELECT
    product_id,
    product_name,
    list_price,
    LAG(list_price) OVER
    (
        ORDER BY product_id
    ) AS previous_price,
    list_price
        - LAG(list_price) OVER
        (
            ORDER BY product_id
        ) AS price_difference
FROM production_schema.products;
GO


-- ============================================================
-- 113) DQL FINAL REVIEW QUERY
-- ============================================================

-- This query combines JOIN, GROUP BY, CASE, aggregate and ORDER BY.
SELECT
    s.store_name,
    COUNT(o.order_id) AS total_orders,
    SUM
    (
        CASE
            WHEN o.order_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders,
    SUM
    (
        CASE
            WHEN o.order_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders
FROM sales_schema.stores AS s
LEFT JOIN sales_schema.orders AS o
    ON s.store_id = o.store_id
GROUP BY
    s.store_id,
    s.store_name
ORDER BY
    total_orders DESC;
GO


-- ============================================================
-- 114) DQL QUICK CHEAT SHEET
-- ============================================================

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
-- ============================================================

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
-- 116) FINAL DQL CHECK
-- ============================================================

-- Check all tables before practicing DQL.
SELECT
    s.name AS schema_name,
    t.name AS table_name
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
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