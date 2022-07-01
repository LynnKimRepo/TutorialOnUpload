--t2 

Set transaction isolation level read committed
Select * From Product

--Lost Up
--Saulo
set transaction isolation level repeatable read
Begin tran
Declare @qty int
select @qty = Quantity from product where id = 1
set @qty = @qty - 4
update product set Quantity = @qty where id = 1

commit


--non repeat

Set tran isolation level serializable
begin tran 
insert into product values (9, 'Juice', 2, 100)
commit