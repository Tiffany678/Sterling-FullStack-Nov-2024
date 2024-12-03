-- Write queries for following scenarios
-- All scenarios are based on Database NORTHWIND.

-- 1.      List all cities that have both Employees and Customers.
SELECT DISTINCT E.City
FROM Employees E
    INNER JOIN Customers C ON E.City = C.City;

-- 2.      List all cities that have Customers but no Employee.
-- a.      Use sub-query
SELECT Distinct city
from Customers e
WHERE  city not in(
SELECT Distinct city
from Employees
)

-- b.      Do not use sub-query
SELECT DISTINCT C.City
FROM Customers C
    LEFT JOIN Employees E ON C.City = E.City
WHERE E.City IS NULL;

-- 3.      List all products and their total order quantities throughout all orders.
SELECT p.productId, p.productName, sum(od.quantity) AS ProductOrderQuantities
FROM [Order Details] od
    JOIN Products p on od.productID = p.ProductID
Group by p.ProductID, p.ProductName
ORDER BY p.ProductID

-- 4.      List all Customer Cities and total products ordered by that city.
SELECT c.City, sum(od.quantity) AS ProductOrderQuantities
FROM
    Orders o
    JOIN Customers c on c.CustomerID = o.CustomerID
    JOIN [Order Details] od on od.OrderID = o.OrderID
Group by c.City
order by sum(od.Quantity) DESC

-- 5.      List all Customer Cities that have at least two customers.
SELECT City, count(CustomerID) AS TotalCustomers
FROM
    Customers
Group by City
HAVING count(CustomerID)>=2
order by count(CustomerID) DESC

-- 6.      List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, count(DISTinct od.ProductID) AS ProductOrderQuantities
FROM
    Orders o
    JOIN Customers c on c.CustomerID = o.CustomerID
    JOIN [Order Details] od on od.OrderID = o.OrderID
Group by c.City
HAVING COUNT(DISTINCT od.ProductID)>=2
order by ProductOrderQuantities DESC

-- 7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT DISTINCT C.CustomerID, O.ShipCity AS [Ship City], C.City AS CustomerCity
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.City != O.ShipCity;

-- 8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
-- With ProductCTE AS(
--     SELECT Top 5 p.productName AS [Product Name], count(od.productId) AS [Product Count], p.UnitPrice AS [Product Unit Price], p.ProductID AS ProductID FROM products p JOIN [Order Details] od on od.ProductID = p.ProductID Group By p.ProductName, p.UnitPrice, p.ProductID order by [Product Count]
-- )
-- SELECT p.[Product Name], p.[Product Unit Price], COUNT(o.ShipCity) AS [Customer City] from ProductCTE p LEFT JOIN [Order Details] od on p.ProductID = od.ProductID JOIN Orders o on o.OrderID = od.OrderID Group 



-- 9.      List all cities that have never ordered something but we have employees there.
-- a.      Use sub-query
SELECT Concat(LastName,' ', FirstName) AS [Employee Never Order], City From Employees where city not in (select ShipCity from orders)

-- b.      Do not use sub-query
SELECT Concat(e.LastName,' ', e.FirstName) AS [Employee Never Order], e.City From Employees e
LEFT JOIN Orders o ON o.ShipCity = e.city 
WHERE o.ShipCity is null

-- 10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
SELECT Top 1 count(o.OrderID) AS OrderCount, e.city
from employees e 
JOIN orders o ON o.EmployeeID = e.EmployeeID
GROUP By e.City
order by OrderCount DESC

-- 11. How do you remove the duplicates record of a table?
With shippersCTE AS (
    SELECT ShipperId, 
    CompanyName, 
    Phone, 
    ROW_NUMBER() Over (Partition BY ShipperID, CompanyName, phone order BY ShipperId) AS RowNUM
     from shippers)
    DElete from shippersCTE where RowNum >1
