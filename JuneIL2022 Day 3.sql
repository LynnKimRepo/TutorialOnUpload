-- CTEs & Recursive CTEs
--Subqueries
-- Window Function & Ranking
--Group By & Aggregate Functions
-- Unions and Union All (Intersect Except)

--Temporary Tables: are a special type of table that we can store data temporarily
-- Created with a #

Create Table #LocalTemp
(
	AnyId Int
)

Select * From #LocalTemp
Declare @variable int = 1
While (@variable <= 10)
Begin
Insert into #LocalTemp values (@variable)
Set @variable = @variable + 1
End 

Create Table ##GlobalTemp
(
	AnyId Int
)



Declare @WeekDays Table (DayNum int, Dayabb varchar(10), WeekName varchar(10))
insert into @WeekDays
Values
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')
Select * From @WeekDays
Go
Select * From tempdb.sys.tables

--1. both temp tables and table variables will be stored in tempdb
--2 Scope: local/global; table variables: Current batch
--3. Size: temptables> 100 rows; tables variables < 100rows
--4. usage: do not use temp tables in SP, user defined functions, but we can use
-- tables variables in SP and functions

--Views
Select * From Employees

Create View vwCondenEmp
As
Select EmployeeId, FirstName + ' ' + LastName [FullName], ReportsTo
From Employees

Select *
From vwCondenEmp

Insert into dbo.vwCondenEmp
values ('HeyNewName', 4)

--Stored Procedures: A prepared sql query that we can save in our db and reuse whenever 
Begin

End

Create Proc spHello
as
Begin
	Select * From Employees
	Select * from Customers
	Print 'Hello From Stored Procedure'
End
Exec spHello
Drop proc spHEllo

--SQL Injection Example
1 Union select Id, Passwords from users

Select Id, username 
From USer
Where id = @string

Declare @string varchar(20)
set @string = '1 Union select Id, Passwords from user'

Execute('Exec spAddNumbers' +  input)



Select * From INFORMATION_SCHEMA.COLUMNS


Create Procedure spAddNumbers
@a int,
@b int
As 
Begin
	print @a + @b
End

Exec spAddNumbers 10, 20

Create Procedure spGetEmpName
@id int,
@EmpName varchar(20) OUT
As 
Begin
	Select @EmpName = LastName + ' ' + FirstNAme From EMployees Where EmployeeID = @id
End

Begin
	Declare @spEmpName varchar(20)
	exec spGetEmpName 2, @spEmpName OUT
	Select @spEmpName
End

--Triggers:
--DML Triggers
--DDL Triggers
--Logon Triggers

--Functions
--Diff sp and functions
--pagination
--constraints

Create Function GetTotalRevenue(@price money, @discount real, @quantity smallint)
returns money
As
Begin
	Declare @revenue Money 
	set @revenue = @price * (1-@discount) * @quantity
	return @revenue
End

Select UnitPrice, Quantity, Discount, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) [Total Revenue]
From [Order Details]

Create Function expensiveProduct(@threshold money)
Returns table
as
return Select * From Products where UnitPrice > @threshold

select *
From dbo.expensiveProduct(50)

--SP vs functions:
--Usage sp for DML, functions are mostly used for calculations
--how to call: sp willl be called by its name with "Exec" and in DML. Functions must be called in a SQL statement
--input/out: SP may or may not have input or output, but functions may or may not have input but must have output
--SP can call functions, but functions cannot call SP
--SP returns only int, but Functions are more flexible with data type but must return what is specified in "returns"

--Pagination
--Offset -> way of skipping rows
--Fetch next row -> like Top but select the following rows after offset
Select customerId, contactname, city
From CUstomers
Order by customerID

Select customerId, contactname, city
From CUstomers
Order by customerID
Offset 82 rows

Select customerId, contactname, city
From CUstomers
Order by customerID
offset 10 rows
Fetch next 10 rows Only

Declare @pageNum int
declare @rowsofPage int
Declare @Maxtablepages float

set @pageNum =1
set @rowsofPage = 10
select @MaxTablepages = count(*) from customers -- 91
set @Maxtablepages = Ceiling(@Maxtablepages / @rowsofPage)

While (@pageNum <= @Maxtablepages)
Begin
Select CustomerId, ContactName, city
From Customers
Order by customerId
Offset (@pageNum -1) * @RowsofPage rows
Fetch next @rowsofpage rows only
set @pageNum = @pageNum + 1
End

Create Function PaginationFunction (@pageNum int, @rowsofPage int)
returns table
As
	Return
		Select CustomerId, ContactName, city
		From Customers
		Order by customerId
		Offset (@pageNum -1) * @RowsofPage rows
		Fetch next @rowsofpage rows only

Create Proc Pagination
@pageNum int,
@rowsofPage int
as 
Begin
	Declare @Maxtablepages float
	select @MaxTablepages = count(*) from customers -- 91
	set @Maxtablepages = Ceiling(@Maxtablepages / @rowsofPage)
	
		Select CustomerId, ContactName, city
		From Customers
		Order by customerId
		Offset (@pageNum -1) * @RowsofPage rows
		Fetch next @rowsofpage rows only
End

Exec Pagination 4, 20

Select *
From dbo.PaginationFunction(1, 10)

--COnstraints
Unique + Not Null
Create Table Employee
(
Id Int Primary Key,
EmpName varchar (20) not null,
Age int,
DId int Foreign Key References Department(Id)
)
Create Table Department(
Id int PRimary key,
DName varchar(20) not null,
loc Varchar(20) Default('N/A')
)
drop table Deaparment

Select * From Employee

Insert Employee Values (1, 'Sam', 53)
Insert Employee values (2, 'Dummy', 100)

Drop table Employee

Create Table Employee
(
Id Int Primary Key,
EmpName varchar (20) not null,
Age int check(Age Between 18 and 65)
)

insert Into Employee(id, EmpName, Age) values(10, 'Della', 60)


--Delete vs Truncate
--Database Concepts Integrities 