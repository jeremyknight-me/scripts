SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRANSACTION main

BEGIN TRY

	-- code here

END TRY
BEGIN CATCH

	-- Close all open cursors
	--IF (SELECT CURSOR_STATUS('global','rsCursor')) >= -1
    --BEGIN
    --    CLOSE rsCursor;
    --    DEALLOCATE rsCursor;
    --END

    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION main;

    THROW;
END CATCH

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION main;
