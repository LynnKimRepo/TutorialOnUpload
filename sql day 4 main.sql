Create Table NewTable(
id int identity(1, 1),
Name varchar(20)
)

insert NewTable(Name) values(
'Sam'),
('Will'),
('Ethan')

Select * From NewTable

Delete From NewTable where Name = 'Ethan'

insert NewTable values(
('Ethan'))

Delete From NewTable

Select * from NewTable

insert NewTable(Name) values(
'Sam'),
('Will'),
('Ethan')

Truncate Table NewTable 

Drop table NewTable

Create table Product(

Id int,
ProductName Varchar(20),
UnitPrice money,
Quantity int)

Insert into product values
( 1, 'Milk Boba', 5, 100),
(2, 'Thai tea', 6, 100),
(3, 'Bottled Water', 1, 100),
(4, 'Gatorade', 3, 100)

read uncommitted
read committed
repeatable read
serializable

--Dirty reads
set transaction isolation level read uncommitted 
Begin Tran
insert product values (5, 'Fermented Mare', 1000, 100), 
(6, 'Iced Latte', 50, 100)

rollback

Select * From Product

--Lost updates

--bt
set transaction isolation level repeatable read
Begin tran
Declare @qty int
select @qty = Quantity from product where id = 1
set @qty = @qty - 5
Waitfor delay '00:00:10'
update product set Quantity = @qty where Id =1 

commit

Select * From product

--non repeatable
Set tran isolation level serializable
begin tran 
select * from product
waitfor delay '00:00:10'
select * From PRoduct
commit

create table newnewtable(
Eid int primary key nonclustered,
FullName varchar(20) unique,
DeptID int foreign key references Department(id)
)
Select * FRom newnewtable

drop table newnewtable

Select * From Product
--Indexes
Create Clustered Index  Clustered_Index_ProductId on Product(id)


Create Index nonclustered_Name on PRoduct(ProductName)
--when to create index:
--Clustered: if not, always the primary key needs clustered (sorts as well as fast lookup tied to entity id)
--non clustered index: where, join, aggregated fields

--PRos: retrieving speed increases
--cons: other dml statements are slower due to extra space and index consideration

--performance Tuning:
--1. Look at the execution plan
--2. choose your indexes wisely
--3. avoid uncessary joins 
--4. AVoid Select *
--5. Join to replace subquery: SQL has a join optimizer. Most cases Joins will outperform subqueries
--6. Derived table can be used to avoid a lot of Group by to optimize speed of your query

select * from ORders o join Employees e on o.EmployeeId = e.EmployeeId