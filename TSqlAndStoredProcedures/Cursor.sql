/*
SQL Server CURSOR

SQL works based on sets. For example, a SELECT statement returns a set of rows,
which is called a result set.

However, sometimes you may want to process a data set on a row-by-row basis.
This is where cursors come into play.


What is a database cursor?

A database cursor is an object that enables traversal over the rows of a result set.
It allows you to process individual rows returned by a query.


SQL Server cursor life cycle:

DECLARE -> OPEN -> FETCH -> CLOSE -> DEALLOCATE
*/


-- View all products before using the cursor.
SELECT *
FROM production_schema.products;


BEGIN

    -- Declare variables to store the current product data.
    DECLARE
        @product_id INT,
        @product_name VARCHAR(MAX),
        @list_price DECIMAL(10,2);


    -- Declare a cursor to go through all products.
    DECLARE cursor_product CURSOR
    FOR
        SELECT
            product_id,
            product_name,
            list_price
        FROM production_schema.products;


    -- Open the cursor to start fetching rows.
    OPEN cursor_product;


    -- Fetch the first product from the cursor.
    FETCH NEXT FROM cursor_product
    INTO
        @product_id,
        @product_name,
        @list_price;


    -- Continue processing while FETCH successfully returns a row.
    -- @@FETCH_STATUS = 0 means that a row was successfully fetched.
    WHILE @@FETCH_STATUS = 0
    BEGIN

        -- Increase the current product price by 10.
        UPDATE production_schema.products
        SET list_price = @list_price + 10
        WHERE product_id = @product_id;


        -- Print the product name, old price, and new price.
        PRINT @product_name
            + ' - Old Price: '
            + CAST(@list_price AS VARCHAR)
            + ' - New Price: '
            + CAST(@list_price + 10 AS VARCHAR);


        -- Fetch the next product.
        FETCH NEXT FROM cursor_product
        INTO
            @product_id,
            @product_name,
            @list_price;

    END;


    -- Close the cursor after processing all rows.
    CLOSE cursor_product;


    -- Deallocate the cursor and remove it from memory.
    DEALLOCATE cursor_product;

END;


-- View all products after using the cursor.
SELECT *
FROM production_schema.products;
