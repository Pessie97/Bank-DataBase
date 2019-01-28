use bank
go

exec usp_makeDeposit 124, 'Deposit', '2019-01-12', 12, 12300008

go

exec usp_makeWithdrawal 128 , 'Withdraw' ,'2018-02-12', 100,  12300008
go

exec usp_makeWithdrawal 129, 'Withdraw' , '2019-01-12',200, 45600003

exec usp_OnlinePayment 'Online Payment to CableVision', '2016-05-15', 50,'OnlinePayment', 45600000
exec usp_OnlinePayment 131, 'Online Payment', '2018-09-19', 200, 45600006
exec usp_OnlinePayment 132, 'Online Payment', '2018-10-15', 150, 45600008
exec usp_OnlinePayment 133, 'Online Payment', '2017-04-29', 50, 45600002
exec usp_OnlinePayment 134, 'Online Payment', '2014-09-12', 50, 45600000

select * from OnlinePayment
select * from Transactions
insert into OnlinePayment (OnlinePaymentID, OnlinePaymentDate, OnlinePaymentAmount)
	values (104, '2018-01-01', 130)


select * from Transactions
select * from Withdraw
select * from AccountFees
select * from CheckIssued 
select * from Checks
select * from DepositATM
select * from OnlinePayment 
select * from Transfers 

exec usp_Transfers 135, 'Transfer', '2018-09-12',500,12300000,12300001, 12300001
exec usp_Transfers 136, 'Transfer', '2018-01-29',3000,45600003,45600006, 45600006
exec usp_Transfers 137, 'Transfer', '2018-09-12',1500,12300004,12300003, 12300003
exec usp_Transfers 138, 'Transfer', '2017-12-30',2000,12300008,12300007, 12300007
exec usp_Transfers 139, 'Transfer', '2018-09-12',1500,45600008,45600009, 45600009

select * from Transfers
select * from Transactions
