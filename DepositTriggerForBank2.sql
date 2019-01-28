use bank
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
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER updateDeposit_Teller
   ON  [dbo].[depositTeller]
   AFTER INSERT
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
			select @depNum = DepositID from inserted
			select @depAmount = DepositAmount from inserted
			select @depDate = DepositTellerDate from inserted

			select @deposited = DepositAmount from Deposit
			where DepositID = @depNum

			update Deposit
			set DepositAMount = @depAmount + @deposited
			where depositid = @depnum

			
		end



END

GO
