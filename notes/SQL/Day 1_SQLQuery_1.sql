USE Northwind
GO

--SELECT statement: identify which column to retrieve from the tble
--1. SELECT all columns and rows

SELECT *
FROM Customers

--2. SELECT a list of columns

SELECT c.CompanyName, c.City, c.Country
FROM Customers AS c

--avoid using SELECT *
--1. Unnecessary Data

SELECT *
FROM Employees

--2. Naming Conflict

SELECT * 
FROM Employees
SELECT * 
FROM Customers

SELECT *
FROM Employees e JOIN Orders o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON o.CustomerID = c.CustomerID

--3. SELECT DISTINCT Value: avoid duplicate values

--list all the cities that employees are located at

SELECT DISTINCT City
FROM Employees

SELECT DISTINCT City, Country
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees

SELECT FirstName + ' ' +LastName AS FullName
FROM Employees


--identifiers: 
--1. Regular Identifier:
        --i.First character: a-z, A-Z, @, #
                --@: Declare a variable
                    DECLARE @today DATETIME
                    SELECT @today = GETDATE()
                    PRINT @today

                --#: temp tables
                    --#: local temp table
                    --##: global temp table
        --ii: subsequent character: a-z, A-Z, 0-9, @, #, $, _
        --iii: identifier must not be a sql reserved word both uppercase or lowercase
        --iv: embedded space is not allowed
        
      
--2. Delimited Identifier: [], " "

SELECT FirstName + ' ' +LastName AS [Full Name]
FROM Employees

--WHERE statement: filter the records 

--1. equal =
--Customers who are from Germany

SELECT ContactName, Country
FROM Customers 
WHERE Country = 'Germany'

--Product which price is $18

SELECT ProductName, UnitPrice
FROM Products
WHERE  UnitPrice = 18

--2. Customers who are not from UK

SELECT ContactName, Country
FROM Customers 
WHERE Country != 'UK'

SELECT ContactName, Country
FROM Customers 
WHERE Country <> 'UK'

--IN Operator: 
--E.g: Orders that ship to USA AND Canada

SELECT OrderID, CustomerID, ShipCountry
FROM Orders 
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'

SELECT OrderID, CustomerID, ShipCountry
FROM Orders 
WHERE ShipCountry IN ('USA', 'Canada')

--BETWEEN Operator: 
--1. retreive products whose price is between 20 and 30.

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20 AND UnitPrice <=30

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30

--NOT Operator: 
-- list orders that does not ship to USA or Canada

SELECT OrderID, CustomerID, ShipCountry
FROM Orders 
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderID, CustomerID, ShipCountry
FROM Orders 
WHERE  NOT ShipCountry  IN ('USA', 'Canada')

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice  BETWEEN 20 AND 30


--NULL Value: a field no value
--check which employees' region information is empty

SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS Null

--exclude the employees whose region is null

SELECT EmployeeID, FirstName, LastName, Region
FROM Employees
WHERE Region IS NOT Null

--Null in numerical operation

CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

SELECT * 
FROM TestSalary

SELECT EId, Salary, Comm, IsNull(Salary, 0) + IsNull(Comm, 0)  AS TotalCompensation
FROM TestSalary

--LIKE Operator: create a search expression

--1. Work with % wildcard character: is used to substitue 0 or more characters

--retrieve all the employees whose last name starts with D

SELECT FirstName, LastName
From Employees
WHERE LastName LIKE 'D%'


--2. Work with [] and % to search in ranges: 

--find customers whose postal code starts with number between 0 and 3

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'

--3. Work with NOT: 

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: 

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

--Customer name starting from letter A but not followed by l-n

SELECT ContactName, PostalCode 
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'

--ORDER BY statement: sort the result in ascending or descending manner
--1. retrieve all customers except those in Boston and sort by Name

SELECT ContactName, City
FROM Customers
WHERE City != 'Boston' 
ORDER BY ContactName DESC

--2. retrieve product name and unit price, and sort by unit price in descending order

SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY UnitPrice DESC

--3. Order by multiple columns


SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY  UnitPrice, ProductName DESC

SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY  2 DESC, 1 DESC


--JOIN: is used to combine rows from two or more tables based on the related column between them. 

--1. INNER JOIN: return the records that have matching values in both tables in the related column. 

--find employees who have deal with any orders

SELECT e.FirstName + ' ' + e.LastName AS FullName, o.OrderDate
FROM Employees AS e INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID

--get cusotmers information and corresponding order date

SELECT c.ContactName, c.City, o.OrderDate
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID

--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date

SELECT C.ContactName As CustomerName, e.FirstName + ' ' + e.LastName AS EmployeeName, o.OrderDate
FROM Employees AS e INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON c.CustomerID = o.CustomerID


--add detailed information about quantity and price, join Order details

SELECT C.ContactName As CustomerName, e.FirstName + ' ' + e.LastName AS EmployeeName, o.OrderDate, od.UnitPrice
FROM Employees AS e INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID JOIN Customers c ON c.CustomerID = o.CustomerID 
JOIN [Order Details] od ON od.OrderID = o.OrderID

--2. OUTER JOIN: 

--1) LEFT OUTER JOIN: return all the records from the left table and matchin records from the right table, if we cannot find any matching record, 
--then for that row, we will return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, O.OrderID
FROM Customers AS c LEFT JOIN Orders O ON c.CustomerID = o.CustomerID


--JOIN with WHERE: 

--customers who never placed any order

SELECT C.ContactName, O.OrderID
FROM Customers AS c LEFT JOIN Orders O ON c.CustomerID = o.CustomerID
WHERE o.OrderId IS Null


--2) RIGHT OUTER JOIN: return all the records from the rigth table and matching records from the left table, if we cannot find any matching record, 
--then for that row, we will return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, O.OrderID
FROM Orders O RIGHT JOIN Customers AS c  ON c.CustomerID = o.CustomerID


--3) FULL OUTER JOIN: Return all rows from both left and right table with null values, if we can't find matching records. 

--Match all customers and suppliers by country.

SELECT c.ContactName AS Customer, c.Country AS CustomerCountry, s.Country As SupplierCountry, s.ContactName AS Supplier
FROM Customers c FULL JOIN Suppliers s ON c.Country = s.Country
ORDER BY CustomerCountry, SupplierCountry

--3. CROSS JOIN:  create the cartesian product of two tables. 

--table 1: 10 rows
--table 2: 10 rows
--cross join table 1 and 2: 100 rows

SELECT *
FROM Customers

SELECT *
FROM Orders

SELECT *
FROM Customers Cross join Orders


--* SELF JOIN: join a table with itself. 

SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees

--find emloyees with the their manager name

SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, m.FirstName + ' '+ m.LastName AS Manager
FROM Employees e INNER JOIN Employees m ON  e.ReportsTo = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, m.FirstName + ' '+ m.LastName AS Manager
FROM Employees e LEFT JOIN Employees m ON  e.ReportsTo = m.EmployeeID


--CEO: Andrew
--Managers: Nancy, Janet, Margaret, Laura, Steven
--Employees: Michael, Robert, Anne


--Batch Directives

USE Northwind
GO

CREATE DATABASE NovBatch
GO
USE NovBatch
GO
CREATE TABLE Employee(Id int, EName varchar(20), Salary money)