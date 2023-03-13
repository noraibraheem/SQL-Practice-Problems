---QUESTION 20----
SELECT c.categoryname,COUNT(p.ProductID)AS TotalProducts
FROM products p join categories c
on p.CategoryID=c.CategoryID
group by categoryname
order by COUNT(*) desc

----QUESTION 21-------
SELECT COUNT(customerID)AS TotalCustomers,country,city
FROM Customers
group by country,city
order by  COUNT(customerID) desc

-----QUESTION 22-----
SELECT productname ,UnitsInStock,ReorderLevel from products 
where UnitsInStock<ReorderLevel
order by ProductID 

-----QUESTION 23--------
SELECT productname ,UnitsInStock,ReorderLevel from products 
where (UnitsInStock+UnitsOnOrder)<= ReorderLevel
AND 
Discontinued = 0
order by ProductID

-----QUESTION 24-------
SELECT CustomerID,CompanyName,region
FROM customers
ORDER BY 
(CASE 
	WHEN region IS NULL then 1
	ELSE 0 
END);

------QUESTION25-------
SELECT * FROM shippers
SElECT * FROM orders

SELECT top 3 shipcountry,avg(freight) AverageFlight
FROM orders
GROUP BY shipcountry
ORDER BY avg(freight) desc;

-----QUESTION 26--------

SELECT top 3 shipcountry,avg(freight) AverageFlight
FROM orders
where DATEPART(year, OrderDate)='1998'
GROUP BY shipcountry
ORDER BY avg(freight) desc;

------QUESTION 28-------
SELECT top 3 shipcountry,avg(freight) AverageFlight
FROM orders
where  OrderDate BETWEEN '1/1/1998' and '12/31/1998'
GROUP BY shipcountry
ORDER BY avg(freight) desc;

SELECT MAX(DATEPART(year, OrderDate)) FROM orders

-------QUESTION 29--------
SELECT e.employeeid,e.lastname,o.orderid,d.quantity,p.productname
FROM employees e join orders o
on e.employeeid=o.employeeid
join [Order Details] d
on o.orderid=d.orderid
join products p
on d.productid = p.productid
ORDER BY OrderID;

--------QUESTION 30-----------

SELECT distinct CustomerID
from customers 
EXCEPT
SELECT CustomerID
from orders

--------QUESTION 31---------

Select
Customers.CustomerID
,Orders.CustomerID
From Customers
left join Orders
on Orders.CustomerID = Customers.CustomerID and Orders.EmployeeID = 4
Where
Orders.CustomerID is null
----ANOTHER SOLUTION-------
SELECT customerid FROM customers
EXCEPT
SELECT customerid FROM orders
where EmployeeID=4
