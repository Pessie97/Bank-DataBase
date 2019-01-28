Use master
go 



if exists(
select name from sys.databases 
where name = 'Bank')
begin 
drop database Bank
end
go 

create database Bank
go

use Bank
go

create table InterestRate(
InterestRateID int identity(1,1) not null,
InterestRateCurrent decimal(5,2) not null,
InterestRateDate date not null,
InterestRateInterval varchar(10) not null,
constraint [PK_IRID] primary key (InterestRateID)
)

create table Bank(
BankID int not null,
BankName varchar(45) not null,
BankStreetAdd varchar(45) not null,
BankCityAdd varchar(45) not null,
BankStateAdd varchar(45) not null,
BankZipAdd varchar(10) not null,
BankPhone varchar(10) not null,
constraint [PK_BankId] primary key (BankID),
constraint [UIX_BankPhone] unique (BankPhone)
)

create table Customer (
CustomerID int not null identity(1, 1),
CustSSN varchar(9) not null,
CustFName varchar (45) not null,
CustLName varchar (45) not null,
CustDateOfBirth date not null,
CustLicense varchar(9) ,
CustPhoneNum varchar(10) not null,
CustCellNum varchar(10),
CustStreetAdd varchar(45) not null,
CustCityAdd varchar (45) not null,
CustStateAdd varchar(45) not null,
CustZipAdd varchar(10) not null,
BankID int not null,
constraint [PK_CustomerID] primary key (CustomerID),
constraint [UIX_CustSSN] unique (CustSSN),
constraint [UIX_PhoneNum] unique (CustPhoneNum),
constraint [FK_BankID] foreign key (BankID)	references Bank(BankID)
)

CREATE UNIQUE NONCLUSTERED INDEX [UIX_CustLicense] 
ON Customer(CustLicense)
WHERE custlicense IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX [UIX_CellPhone] 
ON Customer(CustCellNum)
WHERE custcellnum IS NOT NULL;


--done
create table CheckingAccount (
ChAccountID int identity(45600000, 1)not null,
AccountDesc varchar(45) default('Checking Account'),
DateOpened date not null,
InitialBalance decimal(10,2) default(0),
constraint [PK_ChAccountID] primary key (ChAccountID)
)

create table CheckingPlusAccount(
ChkingPlusAccntID int not null,
InterestRateID int not null,
AccountType varchar(45) default('Checking Plus Account'),
constraint [PK_ChkingPlusAccountID]  primary key (ChkingPlusAccntID),
constraint [FK_CustAccntID] foreign key (ChkingPlusAccntID) 
	references CheckingAccount(ChAccountID),
constraint [FK_CIAInterestRate] foreign key (InterestRateID) 
	references InterestRate(InterestRateID)
)

create table SavingsAccount(
SAccountID int identity(12300000, 1) not null,
SADesc varchar(45) not null default('Savings Account'),
DateOpened date not null,
InitialBalance decimal(10,2) default(0),
InterestRateID int not null,
constraint [PK_SAccountID] primary key (SAccountID),
constraint [FK_SAInterestRate] foreign key (InterestRateID) 
	references InterestRate(InterestRateID)
)

create table CDAccount(
CDAccountID int not null,
InterestRateID int not null,
constraint [PK_CDAccountID] primary key (CDAccountID),
constraint [FK_CDInterestRateID] foreign key (InterestRateID)
	references InterestRate(InterestRateID),
constraint [FK_CD_Savings] foreign key (CDaccountID) 
	references SavingsAccount(SAccountid)
)


create table CustomerAccounts(
CustID int not null,
CustAccntsID int not null,
constraint [PK_CustAccntsID] primary key (CustAccntsID),
constraint [FK_Customerid] foreign key (custid) references Customer(customerid),
constraint [FK_CustAccnts] foreign key (CustAccntsID) 
	references CheckingAccount(CHAccountId), 
constraint [FK_CustSAAccount] foreign key (CustAccntsID) 
	references SavingsAccount(SAccountID) 
)
alter table CustomerAccounts
drop constraint [FK_CustSAAccount]
alter table CustomerAccounts
drop constraint [FK_CustAccnts]

create table Fees(
FeeID int identity(1,1)not null,
FeeDesc varchar(45) not null,
FeeAmount decimal(6,2) not null,
constraint [PK_FeeID] primary key (FeeID)
)

create table AccountFees(
AccountID int not null,
AccountType varchar(45) not null,
FeeID int not null,
constraint [FK_AccountID] foreign key (AccountID) 
	references CustomerAccounts(CustAccntsID),
constraint [FK_FeeID] foreign key (FeeID)
	references Fees(FeeID)
)

create table Transactions(
TransactionID int not null,
TransactionDesc varchar(45) not null,
TransactionAmnt decimal(10,2) not null,
AccountID int not null,
constraint [PK_TransID] primary key (TransactionID),
constraint [FK_TransAccountID] foreign key (AccountID)
	references CustomerAccounts(CustAccntsID)
)

alter table Transactions
add TransactionType varchar(45) null

create table Checks(
CheckID int  not null,
CheckNumber int  identity(0001, 1)not null,
CheckAccntFromID int not null,
constraint [PK_CheckID] primary key (CheckID),
constraint [FK_AccountFrom] foreign key (CheckAccntFromID)
	references CheckingAccount(ChAccountID),
constraint [UIX_CheckNum] unique (CheckNumber)
)



create table CheckIssued(
CheckID int not null,
CheckNumber int not null,
CheckAmount decimal(10,2) not null,
constraint [PK_CICheckID] primary key (CheckID),
constraint [FK_CICheckID] foreign key (CheckID) 
	references Checks(CheckID)
)

create table Transfers(
TransferID int  not null,
TransferFromAccntID int not null,
TransferToAccntID int not null,
TransferAmnt decimal(10,2) not null,
constraint [PK_Trns_TransID] primary key (TransferID),
constraint [FK_TransferID_TransID] foreign key (TransferID)
	references Transactions(TransactionID)
)

create table OnlinePayment (
OnlinePaymentID int not null,
OnlinePaymentDate date not null,
OnlinePaymentAmount decimal (10,2) not null,
constraint [PK_OPID] primary key (OnlinePaymentID),
constraint [FK_OnlinePayID_TransID] foreign key (OnlinePaymentID)
	references Transactions(TransactionID)
)

create table Deposit(
DepositID int  not null,
DepositDate date not null,
DepositAmount decimal(10,2) not null,
constraint [PK_DepositID] primary key (DepositID),
constraint [FK_DepID_TransID] foreign key (DepositID)
	references Transactions(TransactionID)
)

create table DepositATM(
DepositATMID int not null,
DepositATMDate date not null,
DepositATMAmount decimal (6,2) not null,
constraint [PK_DATMID] primary key (DepositATMID),
constraint [FK_DepositATMID] foreign key (DepositATMID)
	references Deposit(DepositID)
)

create table CheckDeposit(
CheckDepositID int  not null,
CheckNumber int not null,
CheckStatus varchar(7) not null,
BankRoutingNumber int not null,
CheckingAccntIDFrom int not null,
constraint [PK_CheckDepositID] primary key (CheckDepositID),
constraint [FK_ChkDpID] foreign key (CheckDepositID)
	references Deposit(DepositID)
)
alter table checkDeposit
add CheckAmount decimal(10,2) not null
alter table checkdeposit
add DepositDate date not null

create table Tellers(
TellerID int identity(001,1) not null,
TellerFName varchar(45) not null,
TellerLName varchar(45) not null,
constraint [PK_TellerID] primary key (TellerID)
)

create table DepositTeller(
DepositID int not null,
DepositAmount decimal (10,2) not null,
TellerID int not null,
DepositTellerDate date not null,
constraint [PK_DepositIDTeller] primary key (DepositID),
constraint [FK_TellerID] foreign key (TellerID)
	references Tellers(TellerID),
constraint [FK_DepositID_Deposit] foreign key (DepositID)
	references Deposit(DepositID)
)

create table Withdraw(
WithdrawID int not null,
WithdrawDate date not null,
WithdrawAmount decimal(10,2) not null,
constraint [PK_WithdrawID] primary key (WithdrawID),
constraint [FK_WithdrawID_TransID] foreign key (WithdrawID)
	references Transactions(TransactionID)
)





