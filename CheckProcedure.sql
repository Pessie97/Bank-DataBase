use master
go
use bank
go

-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


create PROCEDURE usp_IssuedChecks
	-- Add the parameters for the stored procedure here
	@TransactionID int,
	@TransactionDesc varchar(45),
	@transactiondate date,
	@transactionamnt decimal(10, 2),
	@CheckNumber int,
	@Accountid int 	
	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	set implicit_transactions on
	begin transaction
	   begin try

	       --try to insert the payment into the payment table
		   insert into transactions(transactionid, transactiondesc, transactionamnt, accountid)
		     values (@transactionid, @TransactionDesc, @transactionamnt, @accountID)

			 insert into checks
			 values(@transactionid, @CheckNumber, @accountid)
			
	    insert into CheckIssued
		    values (@transactionid, @CheckNumber, @transactionamnt, @transactiondate)
		   
			commit transaction


	   end try

	   begin catch
	        DECLARE @error int,
                    @message varchar(4000),
                    @xstate int;

            SELECT
				 @error = ERROR_NUMBER(),
				 @message = ERROR_MESSAGE(),
				 @xstate = XACT_STATE();

		
					ROLLBACK ;   --must be terminated with a semicolon for the throw statement to work
			
               Throw 
			   

	   end catch
END
GO
