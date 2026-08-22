/* SQL SERVER DQL - BikeStores
Joins and join-based queries
*/

-- 31) INNER JOIN : INNER JOIN returns matching rows from both tables.
-- INNER JOIN using the old-style (implicit) join syntax.
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_status 
FROM sales_schema.customers AS c , sales_schema.orders AS o 
WHERE c.customer_id = o.customer_id;
GO
-- INNER JOIN.
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_status 
FROM sales_schema.customers AS c INNER JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id;
GO
-- JOIN.
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_status 
FROM sales_schema.customers AS c JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id;
GO

-- ============================================================

-- 32) LEFT JOIN : LEFT JOIN returns all rows from the left table.
-- even its not conected to any row of the RIGHT table so the values will be null
--THIS GET EACH ORDER ITEM THAT HAS AN ORDER
SELECT * 
FROM sales_schema.orders AS o JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id;
GO
-- THIS GETS ALL ORDERS AND ITS ORDER ITEMS AND IF THIS ORDER HAS NO ITEMS SHOW ITEM DATA WITH NULLS
SELECT * 
FROM sales_schema.orders AS o LEFT JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id;
GO


-- LEFT JOIN can find ORDERS without ITEMS.
SELECT * 
FROM sales_schema.orders AS o LEFT JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id WHERE oi.item_id IS NULL ;
GO

-- ============================================================
-- 33) RIGHT JOIN : RIGHT JOIN returns all rows from the RIGHT table.
-- even its not conected to any row of the left table so the values will be null
--THIS GET EACH ORDER ITEM THAT HAS AN ORDER
SELECT * 
FROM sales_schema.orders AS o JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id;
GO

-- THIS GETS ALL ORDER ITEMS AND THEIR ORDERS.
-- If an order item has no matching order, the order data will be NULL.
SELECT * 
FROM sales_schema.orders AS o RIGHT JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id;
GO


-- RIGHT JOIN can find ORDER ITEMS without ORDERS.
SELECT * 
FROM sales_schema.orders AS o RIGHT JOIN  sales_schema.order_items AS oi
ON oi.order_id = o.order_id WHERE oi.item_id IS NULL ;
GO

-- ============================================================

-- 34) FULL OUTER JOIN : FULL JOIN returns matched and unmatched rows from both tables.
-- so all valuse of the tow tables must be exist even its not connected to the other table and the other table data will be null
SELECT * 
FROM sales_schema.customers AS c FULL OUTER JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id;
GO

-- ============================================================

-- 35) CROSS JOIN : CROSS JOIN creates every possible combination.
SELECT * FROM sales_schema.customers AS c CROSS JOIN sales_schema.stores AS s;
GO

-- ============================================================

-- 36) SELF JOIN : SELF JOIN joins a table to itself.
SELECT e.staff_id, e.first_name AS employee, m.manager_id , m.first_name AS manager 
FROM sales_schema.staff AS e RIGHT JOIN sales_schema.staff AS m 
ON e.manager_id = m.staff_id;
GO

-- ============================================================

-- 37) MULTIPLE JOINS : Multiple JOINs can connect several related tables.
SELECT o.order_id, c.first_name, s.store_name, st.first_name AS staff_name 
FROM sales_schema.orders AS o INNER JOIN sales_schema.customers AS c ON o.customer_id = c.customer_id 
JOIN sales_schema.stores AS s ON o.store_id = s.store_id 
LEFT JOIN sales_schema.staff AS st ON o.staff_id = st.staff_id;
GO

-- ============================================================




-- 39) JOIN WITH CALCULATIONS : JOIN can be combined with calculated columns.
SELECT oi.order_id, p.product_name, oi.quantity, oi.list_price, oi.discount, 
oi.quantity * oi.list_price AS gross_total, oi.quantity * oi.list_price * (1 - oi.discount / 100.0) AS final_total 
FROM sales_schema.order_items AS oi INNER JOIN production_schema.products AS p 
ON oi.product_id = p.product_id;
GO
-- ============================================================

-- 40) JOIN WITH GROUP BY : JOIN and GROUP BY can calculate totals per customer.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count 
FROM sales_schema.customers AS c LEFT JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name;
GO

-- ============================================================

-- 83) DISTINCT WITH JOIN : DISTINCT can remove duplicate values produced by a JOIN.
SELECT  c.customer_id, c.first_name 
FROM sales_schema.customers AS c INNER JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id;
GO

SELECT DISTINCT c.customer_id, c.first_name 
FROM sales_schema.customers AS c INNER JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id;
GO



-- ============================================================

-- 85) HAVING WITH JOIN : HAVING can filter aggregated JOIN results.
SELECT c.customer_id, c.first_name, COUNT(o.order_id) AS order_count 
FROM sales_schema.customers AS c LEFT JOIN sales_schema.orders AS o 
ON c.customer_id = o.customer_id GROUP BY c.customer_id, c.first_name HAVING COUNT(o.order_id) >= 1;
GO

-- ============================================================
