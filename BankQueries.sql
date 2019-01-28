use bank
go


--i
select * from CheckDeposit
select max(checkamount) from CheckDeposit
where MONTH(DepositDate)=10

--ii
select * from CheckDeposit
select checknumber from CheckDeposit
where CheckAmount =
(select max(checkamount) from CheckDeposit)

--iii
select * from CheckDeposit
select * from Transactions
select sum(checkamount) as [amount] from CheckDeposit
inner join Deposit on CheckDeposit.CheckDepositID=Deposit.DepositID
inner join Transactions on Transactions.TransactionID=Deposit.DepositID
where AccountID= 45600000


--iv
select * from Transfers
select * from SavingsAccount
select * from CheckingAccount

select count(transferID) as [Amount of Transfers] from Transfers
where TransferFromAccntID not in
(select ChAccountID from CheckingAccount)
and TransferToAccntID not in (select SAccountID from SavingsAccount)



--v
select * from Customer
select * from CustomerAccounts

select custfname+' '+custlname , CustAccntsID from Customer
inner join CustomerAccounts on customer.CustomerID=CustomerAccounts.CustID

--vi
select * from CheckDeposit
select * from Transactions
select checkamount from CheckDeposit
inner join Transactions on CheckDeposit.CheckDepositID=Transactions.TransactionID
where AccountID=12300002 and CheckNumber=3

--vii
select * from AccountFees
select sum(feeamount) as [Total Fees] from Fees
inner join AccountFees on fees.FeeID=AccountFees.FeeID
where AccountID=45600002

--viii
select count(onlinePaymentID) from OnlinePayment
inner join Transactions on Transactions.TransactionID=OnlinePayment.OnlinePaymentID
where CHARINDEX('CableVision', TransactionDesc, 1)>0

--ix
select * from OnlinePayment
select onlinepaymentid, onlinepaymentdate, onlinepaymentamount, 
	transactiondesc from OnlinePayment
inner join Transactions on OnlinePayment.OnlinePaymentID=Transactions.TransactionID
where OnlinePaymentAmount= 
	(select max(onlinePaymentamount) from onlinepayment)

--x
select sum(TransactionAmnt) as [total], TransactionType from Transactions
where AccountID = 45600002
group by TransactionType

--xi
select max(list.amount), list.transactiontype from
(select count(transactiontype)as amount, transactiontype  from Transactions
where AccountID= 45600004
group by TransactionType) as list
group by list.TransactionType

--xii
select count(depositid) as [numDeposits], count(withdrawid) as [numWithdraws] from Deposit
inner join Transactions on Deposit.DepositID=Transactions.TransactionID
inner join Withdraw on Transactions.TransactionID=Withdraw.WithdrawID
where (DepositDate between '2018-09-30' and '2018-11-01' ) 
	--and (WithdrawDate between '2018-09-30' and '2018-11-01')
	and accountid = 12300001
select * from Transactions
select * from Deposit
select * from Withdraw

--xiii
select * from CheckDeposit
select checknumber, depositdate, checkamount from CheckDeposit
where DepositDate between '2018-09-30' and '2018-11-01'

--xiv
select CustFName+CustLName, CustAccntsID, DateOpened from Customer
inner join CustomerAccounts on customer.CustomerID=CustomerAccounts.CustID
inner join SavingsAccount on SavingsAccount.SAccountID=CustomerAccounts.CustAccntsID
where SavingsAccount.DateOpened = (select min(dateopened) from SavingsAccount)

select CustFName+CustLName, CustAccntsID, DateOpened from Customer
inner join CustomerAccounts on customer.CustomerID=CustomerAccounts.CustID
inner join CheckingAccount on CheckingAccount.ChAccountID=CustomerAccounts.CustAccntsID
where CheckingAccount.DateOpened = (select min(dateopened) from CheckingAccount)

--xv
select custfname+' '+custlname, CustDateOfBirth from Customer
where CustDateOfBirth = 
(select min(custdateofbirth) from Customer)