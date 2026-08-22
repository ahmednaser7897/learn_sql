/*
================================================================================
                            SQL VIEWS
================================================================================

MAIN CONCEPT
------------
A VIEW is a virtual table based on the result of a SELECT query.

A view does not normally store a separate copy of the data. Instead, it stores
the query definition, and when we SELECT from the view, the database retrieves
the data from the underlying tables.

WHY USE VIEWS?
--------------
1. Simplify complex queries:
   Instead of writing the same JOINs repeatedly, we can save them inside a view.

2. Reuse queries:
   Once a view is created, we can query it like a normal table.

3. Improve readability:
   A complicated query can be given a simple and meaningful name.

4. Security:
   A view can expose only specific columns or rows from a table instead of
   giving users direct access to all table data.

5. Abstraction:
   Users can work with the view without needing to know how the underlying
   tables are connected.

IMPORTANT VIEW CONCEPTS
-----------------------
- CREATE VIEW:
  Creates a new view.

- SELECT FROM VIEW:
  A view can be queried like a normal table.

- WHERE / ORDER BY:
  We can filter and sort the data returned by a view.

- INSERT / UPDATE / DELETE:
  Some views are updatable, but not every view is.
  A simple view based on one table is usually easier to modify.

  Views that contain things such as JOIN, GROUP BY, DISTINCT, aggregate
  functions, UNION, etc. may not be directly updatable depending on the
  database system and the exact query.

- DROP VIEW:
  Removes the view definition. It does not mean that the underlying tables
  are deleted.

VIEW VS TABLE
-------------
TABLE:
- Stores the actual data.
- Can be created independently.
- Data exists physically in the table.

VIEW:
- Stores a SELECT query definition.
- Usually does not store a separate copy of the data.
- Shows data from the underlying table(s).

NOTE ABOUT INSERTING INTO A VIEW
--------------------------------
An INSERT can work when the view is updatable and the required columns from
the underlying table(s) can be correctly supplied.

For example, a simple view that selects columns directly from one table can
often allow INSERT operations.

A view containing JOINs, calculated columns, GROUP BY, aggregate functions,
DISTINCT, etc. may not allow INSERT operations directly.

The exact rules depend on the database system.

================================================================================
*/


-- ============================================================================
-- 1. USER_BRANDS VIEW
-- ============================================================================
-- Get the brands that users have purchased.
--
-- The query connects:
-- customers -> orders -> order_items -> products -> brands
--
-- This allows us to see which customer bought products belonging to which
-- brands.

create view user_brands
as
select c.customer_id, b.brand_id,  c.first_name || ' ' || last_name as name, b.brand_name
from sales_schema.customers as c
join sales_schema.orders as o  on c.customer_id = o.customer_id
join sales_schema.order_items as oi on o.order_id = oi.order_id
join production_schema.products as p  on oi.product_id = p.product_id
join production_schema.brands as b on p.brand_id = b.brand_id;

-- Display all rows from the view.
select * from user_brands;


-- Filter customers whose name contains the letter "A".
select * from user_brands
where name LIKE '%A%';


-- Filter customers whose name ends with the letter "r" and sort the result by name in ascending order.
select * from user_brands
where name LIKE '%r'order by name ASC;


-- Filter customers whose name ends with the letter "r" and sort the result by name in descending order.
select * from user_brands
where name LIKE '%r'order by name desc;


-- 2. PRODUCT_VIEW
-- Create a simple view containing selected columns from the products table.
create view product_view
as
select p.product_id, p.product_name,  p.category_id, p.list_price, p.brand_id
from production_schema.products as p
;


-- Display all products from the view.
select * from product_view;


-- Get products whose price is between 500 and 2000.
select * from product_view
where list_price BETWEEN 500 and 2000;


-- 3. INSERT DATA THROUGH A VIEW
-- Because product_view is a simple view over the products table, it can be
-- updatable in this case.
-- This INSERT adds a new product to the underlying products table through
-- the view.

insert into product_view
    (product_id, product_name, category_id, list_price, brand_id)
values
    (11, 'new prod', 3, 1456, 5);


-- 4. DROP VIEW
drop view product_view;
 