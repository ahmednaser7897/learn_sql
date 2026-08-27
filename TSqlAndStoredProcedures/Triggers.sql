/*
Introduction to SQL Server CREATE TRIGGER statement

The CREATE TRIGGER statement allows you to create a new trigger that is fired automatically
whenever an event such as INSERT, DELETE, or UPDATE occurs against a table.

The following illustrates the syntax of the CREATE TRIGGER statement:
-------------------
CREATE TRIGGER [schema_name.]trigger_name
ON table_name
AFTER {[INSERT], [UPDATE], [DELETE]}
[NOT FOR REPLICATION]
AS
{sql_statements}
-------------------

In this syntax:

The schema_name is the name of the schema to which the new trigger belongs. The schema name is optional.
The trigger_name is the user-defined name for the new trigger.
The table_name is the table to which the trigger applies.
The event is listed in the AFTER clause. The event could be INSERT, UPDATE, or DELETE.
A single trigger can fire in response to one or more actions against the table.
The NOT FOR REPLICATION option instructs SQL Server not to fire the trigger when data modification
is made as part of a replication process.
The sql_statements is one or more Transact-SQL statements used to carry out actions once an event occurs.
---------------------

“Virtual” tables for triggers: INSERTED and DELETED

SQL Server provides two virtual tables that are available specifically for triggers called INSERTED and DELETED tables.
SQL Server uses these tables to capture the data of the modified rows before and after the event occurs.

The following table shows the content of the INSERTED and DELETED tables before and after each event:

DML event        INSERTED table holds                  DELETED table holds
INSERT       ->  rows to be inserted                ->  empty
UPDATE       ->  new rows modified by the update    ->  existing rows modified by the update
DELETE       ->  empty                              ->  rows to be deleted
*/


-- Create a table for logging the changes.

-- This table records information when an INSERT or DELETE event occurs on products.
CREATE TABLE production_schema.product_audits
(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK (operation = 'INS' OR operation = 'DEL')
);


-- View all audit records.
SELECT *
FROM production_schema.product_audits;


-- Create or update an AFTER DML trigger.
CREATE OR ALTER TRIGGER production_schema.trg_product_audit
ON production_schema.products

-- Run the trigger after INSERT or DELETE.
AFTER INSERT, DELETE
AS
BEGIN

    -- Prevent messages such as "(1 row affected)".
    SET NOCOUNT ON;

    -- Insert the changes into the audit table.
    INSERT INTO production_schema.product_audits
    (
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price,
        updated_at,
        operation
    )

    -- Get the inserted rows from the INSERTED virtual table.
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        i.model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM inserted AS i

    UNION ALL

    -- Get the deleted rows from the DELETED virtual table.
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        d.model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM deleted AS d;

END;


-- Insert a test product.
INSERT INTO production_schema.products
(
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
)
VALUES
(
    10,
    'Test product',
    1,
    1,
    2018,
    599
);


-- View the audit record created by the trigger.
SELECT *
FROM production_schema.product_audits;
