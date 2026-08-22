/* SQL SERVER DQL - BikeStores
Window functions, ranking and pagination
*/

-- 58) ROW_NUMBER : ROW_NUMBER gives every row a unique sequential number.
SELECT product_id, product_name, list_price, ROW_NUMBER() OVER ( ORDER BY list_price DESC ) AS row_number FROM production_schema.products;
GO

-- ============================================================

-- 59) ROW_NUMBER PARTITION BY : PARTITION BY restarts the row number for every group.
SELECT product_id, product_name, category_id, list_price, ROW_NUMBER() OVER ( PARTITION BY category_id ORDER BY list_price DESC ) AS row_number FROM production_schema.products;
GO

-- ============================================================

-- 60) RANK : RANK gives the same rank to tied values and leaves gaps.
SELECT product_name, list_price, RANK() OVER ( ORDER BY list_price DESC ) AS price_rank FROM production_schema.products;
GO

-- ============================================================

-- 61) DENSE_RANK : DENSE_RANK gives the same rank to ties without gaps.
SELECT product_name, list_price, DENSE_RANK() OVER ( ORDER BY list_price DESC ) AS price_rank FROM production_schema.products;
GO

-- ============================================================

-- 62) NTILE : NTILE divides rows into a specified number of groups.
SELECT product_name, list_price, NTILE(4) OVER ( ORDER BY list_price DESC ) AS price_group FROM production_schema.products;
GO

-- ============================================================

-- 63) SUM OVER : SUM OVER calculates a total without grouping the rows.
SELECT product_id, product_name, list_price, SUM(list_price) OVER () AS total_price FROM production_schema.products;
GO

-- ============================================================

-- 64) SUM OVER PARTITION : SUM OVER PARTITION calculates a total for every group.
SELECT product_id, product_name, category_id, list_price, SUM(list_price) OVER ( PARTITION BY category_id ) AS category_total FROM production_schema.products;
GO

-- ============================================================

-- 65) AVG OVER : AVG OVER calculates an average without collapsing rows.
SELECT product_id, product_name, list_price, AVG(list_price) OVER () AS average_price FROM production_schema.products;
GO

-- ============================================================

-- 66) AVG OVER PARTITION : AVG OVER PARTITION calculates an average per group.
SELECT product_id, product_name, category_id, list_price, AVG(list_price) OVER ( PARTITION BY category_id ) AS category_average FROM production_schema.products;
GO

-- ============================================================

-- 67) COUNT OVER : COUNT OVER counts rows without grouping them.
SELECT product_id, product_name, COUNT(*) OVER () AS total_products FROM production_schema.products;
GO

-- ============================================================

-- 68) MIN OVER : MIN OVER returns the minimum value while keeping every row.
SELECT product_name, list_price, MIN(list_price) OVER () AS minimum_price FROM production_schema.products;
GO

-- ============================================================

-- 69) MAX OVER : MAX OVER returns the maximum value while keeping every row.
SELECT product_name, list_price, MAX(list_price) OVER () AS maximum_price FROM production_schema.products;
GO

-- ============================================================

-- 70) LAG : LAG accesses a value from a previous row.
SELECT product_id, product_name, list_price, LAG(list_price) OVER ( ORDER BY product_id ) AS previous_price FROM production_schema.products;
GO

-- ============================================================

-- 71) LEAD : LEAD accesses a value from the next row.
SELECT product_id, product_name, list_price, LEAD(list_price) OVER ( ORDER BY product_id ) AS next_price FROM production_schema.products;
GO

-- ============================================================

-- 72) FIRST_VALUE : FIRST_VALUE returns the first value in the window.
SELECT product_name, list_price, FIRST_VALUE(list_price) OVER ( ORDER BY list_price DESC ) AS highest_price FROM production_schema.products;
GO

-- ============================================================

-- 73) LAST_VALUE : LAST_VALUE returns the last value in the window frame.
SELECT product_name, list_price, LAST_VALUE(list_price) OVER ( ORDER BY list_price DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS lowest_price FROM production_schema.products;
GO

-- ============================================================

-- 74) PERCENT_RANK : PERCENT_RANK returns the relative rank from 0 to 1.
SELECT product_name, list_price, PERCENT_RANK() OVER ( ORDER BY list_price ) AS percent_rank FROM production_schema.products;
GO

-- ============================================================

-- 75) WINDOW FRAME : Window frames control which rows participate in the calculation.
SELECT product_id, product_name, list_price, SUM(list_price) OVER ( ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS running_total FROM production_schema.products;
GO

-- ============================================================

-- 76) RUNNING TOTAL : Running total adds the current row to all previous rows.
SELECT product_id, product_name, list_price, SUM(list_price) OVER ( ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS running_total FROM production_schema.products;
GO

-- ============================================================

-- 77) MOVING AVERAGE : Moving average calculates an average over nearby rows.
SELECT product_id, product_name, list_price, AVG(list_price) OVER ( ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) AS moving_average FROM production_schema.products;
GO

-- ============================================================

-- 78) TOP N PER GROUP : ROW_NUMBER can find the top products inside every category.
WITH RankedProducts AS ( SELECT product_id, product_name, category_id, list_price, ROW_NUMBER() OVER ( PARTITION BY category_id ORDER BY list_price DESC ) AS rn FROM production_schema.products ) SELECT * FROM RankedProducts WHERE rn <= 2;
GO

-- ============================================================

-- 79) OFFSET : OFFSET skips a specified number of rows.
SELECT * FROM production_schema.products ORDER BY product_id OFFSET 2 ROWS;
GO

-- ============================================================

-- 80) OFFSET + FETCH : FETCH returns a specific number of rows after OFFSET.
SELECT * FROM production_schema.products ORDER BY product_id OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;
GO

-- ============================================================

-- 81) PAGINATION : OFFSET and FETCH are commonly used for pagination.
DECLARE @PageNumber INT = 1; DECLARE @PageSize INT = 2;

SELECT * FROM production_schema.products ORDER BY product_id OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;
GO

-- ============================================================
