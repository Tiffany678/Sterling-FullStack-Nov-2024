-- 1.      How many products can you find in the Production.Product table?
SELECT COUNT(ProductID)
FROM Production.Product

-- 2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(ProductID) AS [Product Count]
from Production.Product
Where  ProductSubcategoryID IS NOT NULL

-- 3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.
-- ProductSubcategoryID CountedProducts
-- -------------------- ---------------
SELECT ProductSubcategoryID, Count(ProductSubcategoryID) AS CountedProducts
from Production.Product
GROUP BY ProductSubcategoryID

-- 4.      How many products that do not have a product subcategory.
SELECT COUNT(Name) AS NoSubcategoryProducts
FROM Production.Product
Where ProductSubcategoryID IS NULL

-- 5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity) as [sum of products quantity]
FROM Production.ProductInventory

-- 6.    Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
--               ProductID    TheSum
--               -----------        ----------
SELECT ProductID, Sum(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID =40
GROUP BY ProductID
Having  Sum(Quantity) <100

-- 7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
--     Shelf      ProductID    TheSum
--     ----------   -----------        -----------
SELECT Shelf, ProductID, Sum(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID =40
GROUP BY Shelf, ProductID
Having  Sum(Quantity) <100

-- 8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT ProductID, Avg(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE LocationID =10
GROUP BY ProductID

-- 9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
--     ProductID   Shelf      TheAvg
--     ----------- ---------- -----------
SELECT ProductID, Shelf, Avg(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

-- 10.  Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
--     ProductID   Shelf      TheAvg
--     ----------- ---------- -----------
SELECT ProductID, Shelf, Avg(Quantity) AS TheAvg
FROM Production.ProductInventory
Where shelf is not NULL
GROUP BY ProductID, Shelf

-- 11.  List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
--     Color                        Class              TheCount          AvgPrice
--     -------------- - -----    -----------            ---------------------
-- Joins:
SELECT
    Color, class,
    COUNT(*) AS TheCount,
    AVG(ListPrice) AS AvgPrice
FROM
    Production.Product
WHERE 
    Color IS NOT NULL AND Class IS NOT NULL
GROUP BY 
    Color, Class

-- 12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
--     Country                        Province
--     ---------                          ----------------------
SELECT
    cr.Name AS CountryName,
    sp.Name AS StateProvinceName
FROM
    person.CountryRegion cr
    JOIN
    person.StateProvince sp
    ON 
    cr.CountryRegionCode = sp.CountryRegionCode
ORDER BY 
    CountryName, StateProvinceName

-- 13.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
--     Country                        Province
--     ---------                          ----------------------
SELECT
    cr.Name AS Country,
    sp.Name AS Province
FROM
    person.CountryRegion cr
    JOIN
    person.StateProvince sp
    ON 
    cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name IN ('Germany', 'Canada')
ORDER BY 
    Country, Province

--  Using Northwnd Database: (Use aliases for all the Joins)
-- 14.  List all Products that has been sold at least once in last 27 years.
SELECT DISTINCT P.ProductID, P.ProductName
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE O.OrderDate >= DATEADD(YEAR, -27, GETDATE())
ORDER BY ProductID

-- 15.  List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 O.ShipPostalCode AS ZipCode, SUM(OD.Quantity) AS TotalQuantitySold
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.ShipPostalCode
ORDER BY TotalQuantitySold DESC

-- 16.  List top 5 locations (Zip Code) where the products sold most in last 27 years.
SELECT TOP 5 o.ShipPostalCode AS ZipCode, SUM(od.Quantity) AS TotalQuantitySole
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
Where o.OrderDate > DATEADD(Year, -27, GETDATE())
GROUP BY o.ShipPostalCode
Order by TotalQuantitySole DESC

-- 17.   List all city names and number of customers in that city.    
SELECT city, COUNT(o.CustomerID) AS [number of customers]
FROM Customers c
JOIN Orders o on c.CustomerID = o.CustomerID
Group by city 
ORDER BY [number of customers] DESC

-- 18.  List city names which have more than 2 customers, and number of customers in that city
SELECT city, COUNT(o.CustomerID) AS [number of customers]
FROM Customers c
JOIN Orders o on c.CustomerID = o.CustomerID
Group by city 
HAVING COUNT(o.CustomerID) >2
ORDER BY [number of customers] DESC

-- 19.  List the names of customers who placed orders after 1/1/98 with order date.
SELECT c.CompanyName, o.OrderDate
FROM Customers c
JOIN Orders o on c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'
Order by o.OrderDate

-- 20.  List the names of all customers with most recent order dates
SELECT C.CompanyName, MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
ORDER BY MostRecentOrderDate DESC


-- 21.  Display the names of all customers  along with the  count of products they bought
SELECT C.CompanyName, COUNT(O.OrderID) AS TotalProducts
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
ORDER BY TotalProducts DESC


-- 22.  Display the customer ids who bought more than 100 Products with count of products.
SELECT c.CompanyName, sum(Quantity) AS customerWithOver100Products
FROM Orders o 
JOIN Customers c on c.CustomerID = o.CustomerID
JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY CompanyName
HAVING SUM(Quantity) >100
order by customerWithOver100Products 

-- 23.  List all of the possible ways that suppliers can ship their products. Display the results as below
--     Supplier Company Name                Shipping Company Name
--     ---------------------------------            ----------------------------------
SELECT ShipperID AS [Supplier Company Name], CompanyName AS [Shipping Company Name]
FROM Shippers
ORDER BY ShipperID

-- 24.  Display the products order each day. Show Order date and Product Name.
SELECT OrderDate, ProductName
from Products p
JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON o.OrderID = od.OrderID
order by orderDate DESC

-- 25.  Displays pairs of employees who have the same job title.
SELECT e1.Title, CONCAT(e2.LastName, ' ', e2.FirstName) AS EmployeeName1, 
       CONCAT(e1.LastName, ' ', e1.FirstName) AS EmployeeName2
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title, EmployeeName1, EmployeeName2;

-- 26.  Display all the Managers who have more than 2 employees reporting to them.
SELECT CONCAT(E.LastName, ' ', E.FirstName) AS ManagerName, COUNT(E.EmployeeID) AS NumberOfReports
FROM Employees E
JOIN Employees M ON E.EmployeeID = M.ReportsTo
GROUP BY E.LastName, E.FirstName
HAVING COUNT(E.EmployeeID) > 2
ORDER BY NumberOfReports DESC;


-- 27.  Display the customers and suppliers by city. The results should have the following columns
-- City
-- Name
-- Contact Name,
-- Type (Customer or Supplier)
SELECT 
    City, 
    CompanyName AS Name,
    ContactName, 
    'Customer' AS Type
FROM Customers
UNION ALL
SELECT 
    City, 
    CompanyName AS Name,
    ContactName, 
    'Supplier' AS Type
FROM Suppliers
ORDER BY City, Type;

