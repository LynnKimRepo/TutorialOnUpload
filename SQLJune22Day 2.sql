--Select
--Basics of Databases
--System Databases
--Database Types
--Bash (Go)
--Syntax Where, Order By, Joins

--Select Retrieve
--From 
--Where: Filter
--Order By: sort
--Joins: reference other tables

--Group By

Select Count(*) As TotalNumberOfOrders
From Orders

Select * From Orders
Print @@RowCount

Select * FRom Products
Print @@RowCount

Select Sum(UnitPrice) [Sum of all the Product Price]
From Products

Select SupplierID, ProductName, Sum(UnitPrice)
From Products
Group By SupplierID, ProductName
Order By SupplierId

Select CustomerId, ShipCity,  Count(1)
From Orders
Group By CustomerID, ShipCity
Order By CustomerId

--Misc Knowledge
Select CustomerId, ShipCity,  1
From Orders
Group By CustomerID, ShipCity
Order By 1

Select Count(Region)
From Employees

Select Region  From Employees

Select Count(1)
From Employees
Select Count(*)
From Employees

Select c.CustomerId, c.ContactName, c.Country, Count(o.OrderId) [Number of Orders]
From Orders o Inner Join Customers c On c.CustomerID = o.CustomerID
Group by c.CustomerId, c.ContactName, c.Country
Order By [Number of Orders]

select * From orders

--Having?: The ability to filter AFTER Group By
Select c.CustomerId, c.ContactName, c.Country, Count(o.OrderId) [Number of Orders]
From Orders o Inner Join Customers c On c.CustomerID = o.CustomerID
--Where o.Freight >  30
Group by c.CustomerId, c.ContactName, c.Country
Having Count(o.OrderId) > 10
Order By [Number of Orders]


Select EmployeeId, City From Employees
Where EmployeeID > 6


Select Count(EmployeeId), City From Employees
Where EmployeeID > 6
Group By City
Having City != 'London'

Select EmployeeId, City From Employees


--From Where [Group By] Having Select Distinct [Order By]

Select City
From Customers

Select Count(City) as IncludeDuplicates, Count(Distinct City) as CountUnique
From Customers

--Sum, Min, Max, Avg

--Top: Select a specific number or a certain percentage of records
Select Top 5 ProductName, UnitPrice
From Products
Order By UnitPrice Desc

Select Top 10 Percent ProductName, UnitPrice
From Products
Order By UnitPrice Desc

--List top 5 customers who created the most Revenue
Select Top 5 c.ContactName, Sum(od.UnitPrice * od.Quantity) [Sum of Total Revenue]
From [Order Details] od Join Orders o On od.OrderID = o.OrderID Join Customers c On c.CustomerID = o.CustomerID
Group By c.ContactName
Order By [Sum of Total Revenue] Desc

--Sub query: select statement that is embedded in another sql statement
--Find the customers from the same city where Alejandro Camino lives

Select ContactName, City
From Customers
Where City in (
Select City From Customers Where ContactName = 'Victoria Ashworth'
)

Select City, ContactName From Customers --Where ContactName = 'Alejandro Camino'

--Find customers who make any orders
--Join

Select Distinct c.CustomerID, c.ContactName, c.City, c.Country
From Customers c Inner join Orders o on c.CustomerID = o.CustomerID

Select CustomerId, ContactName, City, Country
From Customers 
Where CustomerId in 
(select distinct CustomerId From orders)

--Derived Table
Select CustomerId, ContactName, City, Country
From (Select * From Customers) dt

--List all the order data and coresponding employee who is in charge of the order
--Join
Select o.OrderId, e.FirstName, e.LastName
From Orders o Join Employees e On o.EmployeeID = e.EmployeeID
Order by OrderId


SELECT o.OrderId,
(SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID) AS FirstName,
(SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID) AS LastName
FROM Orders o
WHERE (SELECT e3.City FROM Employees e3 WHERE o.EmployeeID = e3.EmployeeID) = 'London'
ORDER BY o.OrderId,
(SELECT e1.FirstName FROM Employees e1 WHERE o.EmployeeID = e1.EmployeeID) ,
(SELECT e2.LastName FROM Employees e2 WHERE o.EmployeeID = e2.EmployeeID)

--CTE : Common Table Expressions
Select * From Employees

With LimitedEmpCTE(EmpId, FullName, City)
As(
Select EmployeeId, FirstName + ' ' + LAstNAme [Full Name], City
From Employees
),
SecondCTE 
as ( 
Select * From ORders
)
Select * From LimitedEmpCTE l Join SecondCTE o On o.EmployeeID = l.EmpId

Select * from Products


--Unions give the ability to combine result sets vertically
Select City, Country
From Customers
Union 
Select City, Country
From Employees
Order By Country
--Differences: 
--Union will remove duplicate records while union all will not
--Union will sort records from the first column automatically

--Rules for Unions:
--The number of columns and their datatypes respectively must match
Select City [Another Name], Country
From Customers
Union
Select City, Country [Whatever]
From Employees



With empHiearachy
As (
	Select EmployeeId, Firstname, ReportsTo
	From #RecursiveEmployeeTable
	Where ReportsTo is Null
	Union All
	Select e.EmployeeId, e.FirstNAme, e.ReportsTo
	From #RecursiveEmployeeTable e Inner join empHiearachy cte On e.ReportsTo = cte.EmployeeId
)
Select * From EmpHiearachy

Select EmployeeId, FirstName, ReportsTo Into #RecursiveEmployeeTable
From Employees

Select *
From #RecursiveEmployeeTable
Insert #RecursiveEmployeeTable values 
('Riku', 3), ('Gael', 4)


--Corelated subquery:
Select c.ContactName, (Select Count(o.OrderId) From Orders o where c.CustomerId = o.CustomerID) [Num of ORder] 
From Customers c
Order By [Num of ORder]


SELECT c.ContactName,c.CompanyName,c.City, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName,c.CompanyName,c.City, c.Country
ORDER BY NumOfOrders DESC

SELECT c.ContactName, c.CompanyName, C.City, C.Country, ISNULL(DT.NumOrOrders, 0) AS NumOfOrders
FROM Customers c LEFT JOIN (
SELECT CustomerID, COUNT(OrderID) AS NumOrOrders
FROM Orders
GROUP BY CustomerID
) dt ON c.CustomerID = dt.CustomerID
ORDER BY NumOrOrders DESC

--Window functions: Gives a single aggregated value for each row by adding extra columns
Select ProductName, SupplierID, UnitPrice, Sum(UnitPrice) Over() [Total]
From Products
Select * From Products
Select * From Suppliers

Select ProductName, SupplierID, UnitPrice, Sum(UnitPrice) Over(Partition By SupplierId) [Total]
From Products

--Ranking: Rank, Dense_Rank, Row_Number
Select ProductId, ProductName, UnitPrice, Rank() Over(Order By UnitPrice Asc) [Rank],
Dense_Rank() Over(Order By UnitPrice Asc)[DenseRank],
Row_Number() Over(Order By UnitPrice Asc) [Row Number]
From Products