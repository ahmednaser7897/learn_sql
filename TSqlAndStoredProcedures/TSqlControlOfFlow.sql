/*
Overview of the BEGIN...END Statement

The BEGIN...END statement is used to define a statement block.
A statement block consists of a set of SQL statements that execute together.
A statement block is also known as a batch.

----------------
Syntax 1:

BEGIN
    { sql_statement | statement_block }
END
*/


-- In this syntax, you place a set of SQL statements between the BEGIN and END keywords.
BEGIN
    SELECT
        product_id,
        product_name
    FROM production_schema.products
    WHERE list_price > 100000;

    -- Check if the SELECT statement returned no rows.
    IF @@ROWCOUNT = 0
        PRINT 'No product with price greater than 100000 found';
END;


/*
Nesting BEGIN...END

The statement block can be nested.
It simply means that you can place a BEGIN...END statement within another BEGIN...END statement.
*/


-- Example of nesting BEGIN...END statements.
BEGIN
    DECLARE @name VARCHAR(MAX);

    SELECT TOP 1
        @name = product_name
    FROM production_schema.products
    ORDER BY list_price DESC;

    -- Check if a product was found.
    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT 'The most expensive product is ' + @name;
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END;


/*
SQL Server IF...ELSE

The IF...ELSE statement is a control-flow statement that allows you
to execute or skip a statement block based on a specified condition.

----------------
Syntax 1:

IF boolean_expression
BEGIN
    { statement_block }
END

----------------
Syntax 2:

IF Boolean_expression
BEGIN
    -- Statement block executes when the Boolean expression is TRUE
END
ELSE
BEGIN
    -- Statement block executes when the Boolean expression is FALSE
END
*/


-- The IF...ELSE statement.
BEGIN
    DECLARE @sales INT;

    SELECT
        @sales = SUM(list_price * quantity)
    FROM sales_schema.order_items i
    INNER JOIN sales_schema.orders o
        ON o.order_id = i.order_id
    WHERE YEAR(order_date) = 2017;

    SELECT @sales;

    -- Check if the sales amount is greater than 10,000,000.
    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2018 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END;
END;


/*
Nested IF...ELSE
*/


-- Example of nested IF...ELSE statements.
BEGIN
    DECLARE
        @x INT = 10,
        @y INT = 20;

    -- Check if x is greater than zero.
    IF (@x > 0)
    BEGIN

        -- Check if x is less than y.
        IF (@x < @y)
            PRINT 'x > 0 and x < y';
        ELSE
            PRINT 'x > 0 and x >= y';

    END;
END;


/*
SQL Server WHILE

The WHILE statement is a control-flow statement that allows you
to execute a statement block repeatedly as long as a specified condition is TRUE.

----------------
Syntax 1:

WHILE Boolean_expression
    { sql_statement | statement_block }
*/


-- Print numbers from 1 to 5 using the WHILE statement.
BEGIN
    DECLARE @counter INT = 1;

    WHILE @counter <= 5
    BEGIN
        PRINT @counter;

        -- Increase the counter by 1.
        SET @counter = @counter + 1;
    END;
END;


/*
SQL Server BREAK Statement Overview

To exit the current iteration of a loop, you use the BREAK statement.

----------------
Syntax:

WHILE Boolean_expression
BEGIN
    -- statements

    IF condition
        BREAK;

    -- other statements
END
*/


-- Example of using the BREAK statement.
DECLARE @counter2 INT = 0;

WHILE @counter2 <= 5
BEGIN
    -- Increase the counter by 1.
    SET @counter2 = @counter2 + 1;

    -- Stop the loop when the counter reaches 4.
    IF @counter2 = 4
        BREAK;

    PRINT @counter2;
END;


/*
SQL Server CONTINUE

The CONTINUE statement stops the current iteration of the loop
and starts a new one.

----------------
Syntax:

WHILE Boolean_expression
BEGIN
    -- code to be executed

    IF condition
        CONTINUE;

    -- code will be skipped if the condition is met
END
*/


-- Example of using the CONTINUE statement.
DECLARE @counter3 INT = 0;

WHILE @counter3 < 5
BEGIN
    -- Increase the counter by 1.
    SET @counter3 = @counter3 + 1;

    -- Skip the current iteration when the counter reaches 3.
    IF @counter3 = 3
        CONTINUE;

    PRINT @counter3;
END;