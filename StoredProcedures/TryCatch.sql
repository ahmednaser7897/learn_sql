/*
SQL Server TRY CATCH

SQL Server TRY CATCH Overview

The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server.

To use the TRY CATCH construct, you first place a group of Transact-SQL statements
that could cause an exception in a BEGIN TRY...END TRY block as follows:

----------------
Syntax 1:

BEGIN TRY
    -- statements that may cause exceptions
END TRY
BEGIN CATCH
    -- statements that handle exceptions
END CATCH
----------------

The CATCH block functions

Inside the CATCH block, you can use the following functions to get detailed information
about the error that occurred:

ERROR_LINE()      returns the line number on which the exception occurred.
ERROR_MESSAGE()   returns the complete text of the generated error message.
ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
ERROR_NUMBER()    returns the number of the error that occurred.
ERROR_SEVERITY()  returns the severity level of the error that occurred.
ERROR_STATE()     returns the state number of the error that occurred.

Note that you only use these functions in the CATCH block.
If you use them outside of the CATCH block, all of these functions will return NULL.
*/


-- Create a procedure without error handling.
CREATE PROC divide
(
    @a DECIMAL,
    @b DECIMAL,
    @c DECIMAL OUTPUT
)
AS
BEGIN
    SET @c = @a / @b;

    -- Print the result inside the procedure.
    PRINT 'Result inside divide is ' + CAST(@c AS VARCHAR);
END;


-- Execute the procedure with valid values.
DECLARE @r1 DECIMAL;

EXEC divide 10, 2, @r1 OUTPUT;

-- Print the result outside the procedure.
PRINT 'Result outside divide is ' + CAST(@r1 AS VARCHAR);


-- This will cause an error.
-- DECLARE @r2 DECIMAL;
-- EXEC divide 10, 0, @r2 OUTPUT;
-- PRINT 'Result outside divide is ' + CAST(@r2 AS VARCHAR);


-- Create a procedure with TRY CATCH error handling.
CREATE PROC usp_divide
(
    @a DECIMAL,
    @b DECIMAL,
    @c DECIMAL OUTPUT
)
AS
BEGIN

    -- Try to execute statements that may cause an error.
    BEGIN TRY

        SET @c = @a / @b;

        -- Print the result inside the procedure.
        PRINT 'Result inside usp_divide is ' + CAST(@c AS VARCHAR);

    END TRY

    -- Handle the error if one occurs.
    BEGIN CATCH

        -- Display detailed information about the error.
        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_STATE() AS ErrorState,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH

END;


-- Execute the procedure with valid values.
DECLARE @r3 DECIMAL;

EXEC usp_divide 10, 2, @r3 OUTPUT;

-- Print the result outside the procedure.
PRINT 'Result outside usp_divide is ' + CAST(@r3 AS VARCHAR);


-- This will not cause an error outside the procedure because TRY CATCH handles it.
DECLARE @r4 DECIMAL;

EXEC usp_divide 10, 0, @r4 OUTPUT;

-- Print the result outside the procedure.
PRINT 'Result outside usp_divide is ' + CAST(@r4 AS VARCHAR);


/*
Nested TRY CATCH Constructs

You can nest a TRY CATCH construct inside another TRY CATCH construct.

However, either a TRY block or a CATCH block can contain a nested TRY CATCH, for example:

BEGIN TRY
    -- statements that may cause exceptions
END TRY
BEGIN CATCH
    -- statements that handle exceptions

    BEGIN TRY
        -- nested TRY block
    END TRY
    BEGIN CATCH
        -- nested CATCH block
    END CATCH

END CATCH
*/
