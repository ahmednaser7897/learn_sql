/* SQL SERVER DQL - BikeStores
Subqueries
*/

-- SUBQUERY : A subquery is a query inside another query.

-- Get customers ids that has orders.
SELECT customer_id  FROM sales_schema.orders

-- Get all customers data .
SELECT customer_id, first_name, last_name
FROM sales_schema.customers ;
-- Get customers who have placed at least one order.
SELECT customer_id, first_name, last_name
FROM sales_schema.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales_schema.orders
);
GO

-- ============================================================

-- SUBQUERY WITH WHERE : A subquery can be used to compare with a value.
-- Get products more expensive than the average product price.
SELECT product_id, product_name, list_price
FROM production_schema.products
WHERE list_price > (
    SELECT AVG(list_price)
    FROM production_schema.products
);
GO

-- ============================================================

-- SUBQUERY WITH IN : IN checks if a value exists in the subquery result.
-- Get customers who placed an order in 2018.
SELECT customer_id, first_name, last_name
FROM sales_schema.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales_schema.orders
    WHERE YEAR(order_date) = 2018
);
GO

-- ============================================================

-- SUBQUERY WITH NOT IN : NOT IN returns values that do not exist in the subquery.
-- Get customers who have never placed an order.
SELECT customer_id, first_name, last_name
FROM sales_schema.customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM sales_schema.orders
);
GO

-- ============================================================

-- EXISTS : EXISTS checks whether the subquery returns at least one row.
-- Get customers who have at least one order.
SELECT c.customer_id, c.first_name, c.last_name
FROM sales_schema.customers AS c
WHERE EXISTS (
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO

-- NOT EXISTS : NOT EXISTS checks that the subquery returns no rows.
-- Get customers who have no orders.
SELECT c.customer_id, c.first_name, c.last_name
FROM sales_schema.customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM sales_schema.orders AS o
    WHERE o.customer_id = c.customer_id
);
GO

-- ============================================================

-- CORRELATED SUBQUERY : The subquery uses a value from the outer query.
-- Get products whose price is higher than the average price of their category.
SELECT p.product_id, p.product_name, p.category_id, p.list_price
FROM production_schema.products AS p
WHERE p.list_price > (
    SELECT AVG(p2.list_price)
    FROM production_schema.products AS p2
    WHERE p2.category_id = p.category_id
);
GO

-- ============================================================

-- SUBQUERY WITH MAX : Get products with the highest price.
SELECT product_id, product_name, list_price
FROM production_schema.products
WHERE list_price = (
    SELECT MAX(list_price)
    FROM production_schema.products
);
GO

-- ============================================================

-- SUBQUERY WITH MIN : Get products with the lowest price.
SELECT product_id, product_name, list_price
FROM production_schema.products
WHERE list_price = (
    SELECT MIN(list_price)
    FROM production_schema.products
);
GO

-- ============================================================

-- SUBQUERY IN SELECT : A subquery can be used as a calculated column.
-- Show each product and the average product price.
SELECT product_id, product_name, list_price,
       (SELECT AVG(list_price) FROM production_schema.products) AS avg_price
FROM production_schema.products;
GO

-- ============================================================

-- SUBQUERY IN FROM : A subquery in FROM creates a temporary result table.
-- Get customers with more than 2 orders.
SELECT customer_id, order_count
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM sales_schema.orders
    GROUP BY customer_id
) AS customer_orders
WHERE order_count > 2;
GO

-- ============================================================

-- ANY : ANY returns TRUE if the condition matches at least one value.
-- Get products more expensive than at least one product in category 1.
SELECT product_id, product_name, list_price
FROM production_schema.products
WHERE list_price > ANY (
    SELECT list_price
    FROM production_schema.products
    WHERE category_id = 1
);
GO

-- ============================================================

-- ALL : ALL returns TRUE if the condition matches every value.
-- Get products more expensive than every product in category 1.
SELECT product_id, product_name, list_price
FROM production_schema.products
WHERE list_price > ALL (
    SELECT list_price
    FROM production_schema.products
    WHERE category_id = 1
);
GO

-- ============================================================

-- SUBQUERY WITH GROUP BY : A subquery can return grouped results.
-- Get customers who have more than 3 orders.
SELECT customer_id, first_name, last_name
FROM sales_schema.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales_schema.orders
    GROUP BY customer_id
    HAVING COUNT(*) > 3
);
GO

-- ============================================================

-- SUBQUERY WITH DISTINCT : DISTINCT can remove duplicate values from a subquery.
-- Get customers who have orders without returning duplicate customer IDs.
SELECT customer_id, first_name, last_name
FROM sales_schema.customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM sales_schema.orders
);
GO
-- ============================================================

-- EXISTS : EXISTS checks whether the subquery returns at least one row.
SELECT * FROM sales_schema.customers AS c 
WHERE EXISTS ( SELECT 1 FROM sales_schema.orders AS o WHERE o.customer_id = c.customer_id );
GO

-- ============================================================

-- NOT EXISTS : NOT EXISTS finds rows without a matching row.
SELECT * FROM sales_schema.customers AS c WHERE 
NOT EXISTS ( SELECT 1 FROM sales_schema.orders AS o WHERE o.customer_id = c.customer_id );
GO

-- ============================================================

-- ANY : ANY compares a value with any value returned by a subquery.
SELECT * FROM production_schema.products 
WHERE list_price > ANY ( SELECT list_price FROM production_schema.products WHERE category_id = 1 );
GO

-- ============================================================

-- ALL : ALL compares a value with every value returned by a subquery.
SELECT * FROM production_schema.products 
WHERE list_price > ALL ( SELECT list_price FROM production_schema.products WHERE category_id = 1 );
GO

-- ============================================================

-- UNION : UNION combines results and removes duplicates.
SELECT city FROM sales_schema.customers 
UNION SELECT city FROM sales_schema.stores;
GO

-- ============================================================

-- UNION ALL : UNION ALL combines results and keeps duplicates.
SELECT city FROM sales_schema.customers UNION ALL SELECT city FROM sales_schema.stores;
GO

-- ============================================================

-- INTERSECT : INTERSECT returns values existing in both result sets.
SELECT city FROM sales_schema.customers INTERSECT SELECT city FROM sales_schema.stores;
GO

-- ============================================================

-- EXCEPT : EXCEPT returns values from the first query not found in the second.
SELECT city FROM sales_schema.customers EXCEPT SELECT city FROM sales_schema.stores;
GO

-- ============================================================

-- RULES FOR SET OPERATORS
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

-- ============================================================

-- CTE : CTE creates a temporary named result for one statement.

WITH ProductData AS ( SELECT product_id, product_name, list_price FROM production_schema.products ) 
SELECT * FROM ProductData;
GO

-- ============================================================

-- CTE WITH FILTER : CTE can make a complex query easier to read.
WITH ExpensiveProducts AS ( SELECT product_id, product_name, list_price FROM production_schema.products WHERE list_price > 1000 ) 
SELECT * FROM ExpensiveProducts ORDER BY list_price DESC;
GO

-- ============================================================

-- CTE WITH GROUP BY : CTE can store an aggregated result.
WITH CustomerOrders AS ( SELECT customer_id, COUNT(*) AS order_count FROM sales_schema.orders GROUP BY customer_id ) 
SELECT * FROM CustomerOrders WHERE order_count > 1;
GO

-- ============================================================

-- RECURSIVE CTE : Recursive CTE can generate a sequence of numbers.
WITH Numbers AS ( SELECT 1 AS number

UNION ALL

SELECT number + 1 FROM Numbers WHERE number < 10 ) SELECT * FROM Numbers OPTION (MAXRECURSION 100);
GO

-- ============================================================

-- SUBQUERY IN SELECT : A scalar subquery can appear inside SELECT.
SELECT p.product_name, p.list_price, ( SELECT AVG(list_price) 
FROM production_schema.products ) AS average_price 
FROM production_schema.products AS p;
GO

-- ============================================================

-- SUBQUERY IN FROM : A subquery in FROM creates a derived table.
SELECT * FROM ( SELECT product_id, product_name, list_price FROM production_schema.products WHERE list_price > 1000 ) AS ExpensiveProducts;
GO

-- ============================================================

-- DERIVED TABLE WITH AGGREGATION : A derived table can contain grouped data.
SELECT * FROM ( SELECT category_id, AVG(list_price) AS average_price FROM production_schema.products GROUP BY category_id ) AS CategoryPrices WHERE average_price > 1000;
GO

-- ============================================================
