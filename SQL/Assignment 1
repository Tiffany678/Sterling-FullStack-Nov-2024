-- Write queries for following scenarios - Using AdventureWorks Database
-- Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
SELECT ProductID, Name, Color, ListPrice
from Production.Product

-- Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
from Production.Product
Where color is null

-- Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
from Production.Product
Where color is NOT null

-- Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT ProductID, Name, Color, ListPrice
from Production.Product
Where color is NOT null AND ListPrice >0

-- Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
SELECT Name, Color
FRom Production.Product
Where color is not null

-- Write a query that generates the following result set  from Production.Product:
-- NAME: LL Crankarm  --  COLOR: Black
-- NAME: ML Crankarm  --  COLOR: Black
-- NAME: HL Crankarm  --  COLOR: Black
-- NAME: Chainring Bolts  --  COLOR: Silver
-- NAME: Chainring Nut  --  COLOR: Silver
-- NAME: Chainring  --  COLOR: Black
SELECT Name, Color
FROM Production.Product
WHERE Name like '%Crankarm' OR Name Like 'Chainring%'

-- Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

-- Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and black
SELECT ProductID, Name, color
FROM Production.Product
WHERE color IN  ('black', 'black')

-- Write a query to get a result set on products that begins with the letter S. 
SELECT *
FROM Production.Product
WHERE Name LIKE 's%'

-- Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
-- Name                                               ListPrice
-- Seat Lug                                              0,00
-- Seat Post                                             0,00
-- Seat Stays                                            0,00
-- Seat Tube                                            0,00
-- Short-Sleeve Classic Jersey, L           53,99
-- Short-Sleeve Classic Jersey, M          53,99
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'Seat%' OR Name LIKE 'Short-Sleeve Classic Jersey, [L-M]%'
ORDER BY 1 ASC, 2 ASC

--  Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
-- Name                                               ListPrice
-- Adjustable Race                                   0,00
-- All-Purpose Bike Stand                       159,00
-- AWC Logo Cap                                      8,99
-- Seat Lug                                                 0,00
-- Seat Post                                                0,00
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%'
    OR Name LIKE 'S%'
ORDER BY Name

-- Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'SPO[^K][a-z,A-Z]%'
ORDER BY Name

-- Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner.
SELECT DISTINCT Color
from Production.Product
ORDER BY color DESC