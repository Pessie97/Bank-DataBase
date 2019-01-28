use Bank
go
-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pessie Schuster
-- Create date: January 18, 2019
-- Description:	Updates the deposit amount with the same id
-- =============================================
CREATE TRIGGER updateDeposit 
   ON  [dbo]. [DepositATM]
   AFTER  INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	declare @depDate date;
	declare @depAmount smallmoney;
	declare @depNum int;
	declare @deposited smallmoney

	if exists (select * from inserted)
		begin
			select @depNum = depositatmID from inserted
			select @depAmount = DepositATMAmount from inserted
			select @depDate = depositATMDate from inserted

			select @deposited = DepositAmount from Deposit
			where DepositID = @depNum

			update Deposit
			set DepositAMount = @depAmount + @deposited
			where depositid = @depnum

			
		end



END
GO
