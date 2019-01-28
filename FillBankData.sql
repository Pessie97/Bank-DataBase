use bank
go

insert into Bank(BankID, BankName, BankStreetAdd, BankStateAdd,BankCityAdd, BankZipAdd,BankPhone) 
values(1, 'Big Bank', '123 Main Street',  'Buffullo','New york' , '12345', '8005562233')
update Bank
set BankStateAdd = 'New York', BankCityAdd='Buffullo'
where bankid=1

select * from Bank

insert into Customer (CustSSN, CustFName, CustLName, CustDateOfBirth, CustCellNum,
	CustPhoneNum, CustStreetAdd, CustCityAdd, CustStateAdd, CustZipAdd, CustLicense, BankID)
	values ('123456788', 'Jane', 'Raje', '1965-05-12', '3475674532','6469807685','2813 Avenue J',
			'Brooklyn', 'New York', '11210', '890765433', 1)
insert into Customer (CustSSN, CustFName, CustLName, CustDateOfBirth, CustCellNum,
	CustPhoneNum, CustStreetAdd, CustCityAdd, CustStateAdd, CustZipAdd, CustLicense, BankID)
	values ('123456789', 'Mark', 'Doe', '1997-03-05', '9178675667','7189078987','2789 Main Street',
			'Newark', 'New Jersey', '09872', '098765432', 1)

insert into Customer (CustSSN, CustFName, CustLName, CustDateOfBirth, CustCellNum,
	CustPhoneNum, CustStreetAdd, CustCityAdd, CustStateAdd, CustZipAdd, CustLicense, BankID)
	values ('123456778', 'Raizel', 'Scwartz', '1973-10-02', '9177477989','7186922267','98 Webster Avenue',
			'Brooklyn', 'New York', '11219', '098767890', 1)

insert into Customer (CustSSN, CustFName, CustLName, CustDateOfBirth, CustCellNum,
	CustPhoneNum, CustStreetAdd, CustCityAdd, CustStateAdd, CustZipAdd, CustLicense, BankID)
	values ('234567890', 'Chaya', 'Link', '1897-09-29', '1234323234','8459786754','800 Miles Avenue',
			'Waterbury', 'Connecticut', '10987', '123321123', 1)
insert into Customer (CustSSN, CustFName, CustLName, CustDateOfBirth, CustCellNum,
	CustPhoneNum, CustStreetAdd, CustCityAdd, CustStateAdd, CustZipAdd, CustLicense, BankID)
	values ('337678987', 'Joe', 'John', '1967-09-23', '9087896576','8009876546','12606 Albers St',
			'Valley Village', 'California', '09878', '198789609', 1)

select * from Customer

select * from transactiontype -- has data

select * from transactions --has data
select * from Customer -- has data
select * from customerTransactions --has data
select * from Fees -- has data
select * from InterestRate -- has data
select * from CheckingAccount -- has data
select * from CheckingPlusAccount --has data
select * from SavingsAccount --has data
select * from CDAccount -- has data





