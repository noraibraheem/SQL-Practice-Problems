 ---------QUESTION 35--------
SELECT orderid,
employeeid,
datepart(day,orderdate)lastday,
datepart(month,orderdate)[month]
FROM Orders
WHERE datepart(day,OrderDate) in (
SELECT MAX(datepart(day,orderdate)) maxday
FROM orders
GROUP BY datepart(month,orderdate)
)
ORDER BY EmployeeID,OrderID;

---------QUESTION 36--------
-- the most line items --> more quantitty
SELECT top 10 o.orderid ,count(d.quantity)
FROM orders o join [Order Details] d
ON o.OrderID=d.OrderID
GROUP BY o.OrderID
ORDER BY count(d.quantity) desc;

-------------QUESTION 37----------
SELECT  TOP (2) PERCENT orderid , 
RandomValue=Rand()
FROM Orders

--------------QUESTION 38-------------
SELECT OrderID
FROM [Order Details]
where Quantity >=60
GROUP BY OrderID,Quantity
having count(*)>1 
--- She thinks that she accidentally double-entered a line item on an order

--------QUESTION 39--------

SELECT 
o.orderid,
productid,
unitPrice,
quantity
FROM Orders o join [Order Details] d
on o.OrderID=d.OrderID
WHERE o.OrderID in
( SELECT OrderID
FROM [Order Details]
where Quantity >=60
GROUP BY OrderID,Quantity
having count(*)>1 );

------QUESTION 41--------

SELECT orderid,
RequiredDate,
ShippedDate
FROM orders
Where ShippedDate > RequiredDate
Order by RequiredDate;

-------QUESTION 42--------
SELECT (FirstName+' '+lastname) as salesname,
count(orderid) as lateOrders
FROM employees e join orders o
on e.EmployeeID=o.EmployeeID 
and ShippedDate > RequiredDate
group by (FirstName+' '+lastname)
order by count(orderid) desc;

----------QUESTION 43--------

SELECT e.EmployeeID,LastName, 
count(OrderID) lateorders
FROM employees e join orders o
on e.EmployeeID=o.EmployeeID
group by e.EmployeeID,LastName

SELECT e.EmployeeID,lastname , count(OrderID) allorders
FROM employees e join orders o
on e.EmployeeID=o.EmployeeID
and ShippedDate >= RequiredDate
group by e.EmployeeID,LastName
order by count(OrderID)

--------Question 44,45,46------
with lateorders as
(
SELECT 
	e.EmployeeID,
	count(orderid) lostorders
FROM 
	Employees e join orders o
on 
	e.EmployeeID=o.EmployeeID
group by 
	e.EmployeeID,e.LastName
)
,allorders as (
SELECT 
	e.EmployeeID,
	count(OrderID) allorders
FROM 
	employees e join orders o
on 
	e.EmployeeID=o.EmployeeID
and 
	ShippedDate >= RequiredDate
group by 
	e.EmployeeID,LastName
)
select 
	lastname,
	lateorders.lostorders,
	allorders=isnull(allorders.allorders,0),
	PercentLateOrders =
			Convert(
			Decimal (10,2)
			,(IsNull(lateorders.lostorders, 0) * 1.00) /
			allorders.allorders)
FROM 
	Employees
join
	lateorders
on 
	Employees.EmployeeID=lateorders.EmployeeID
left join
	allorders
on 
	lateorders.EmployeeID=allorders.EmployeeID;


--------QUESTION 48,49-----------
SELECT * FROM orders
SELECT * FROM Customers

SELECT
	C.customerid,
	C.CompanyName,
	isnull(ROUND(SUM(D.Quantity*D.UnitPrice),-1),0)totalAmount,
	CASE 
	WHEN SUM(D.Quantity*D.UnitPrice) <1000 
		then 'low'
	WHEN SUM(D.Quantity*D.UnitPrice) > 1000 AND SUM(D.Quantity*D.UnitPrice)<5000
		THEN 'MIDIUM'
	WHEN SUM(D.Quantity*D.UnitPrice)>5000 AND SUM(D.Quantity*D.UnitPrice)<10000
		THEN 'HIGH'
	ELSE 'OVER HIGH'
	END AS state
FROM 
	Customers C JOIN Orders O
	ON C.CustomerID=O.CustomerID
	join
	[Order Details] D
	ON O.OrderID=D.OrderID
WHERE OrderDate between '1-1-1998' and '1-1-1999' 
GROUP BY C.customerid,c.CompanyName
ORDER BY C.customerid 


-----------QUESTION 49---------
SELECT
	C.customerid,
	C.CompanyName,
	isnull(ROUND(SUM(D.Quantity*D.UnitPrice),-1),0)totalAmount,
	CASE 
	WHEN SUM(D.Quantity*D.UnitPrice) <1000 
		then 'low'
	WHEN SUM(D.Quantity*D.UnitPrice) > 1000 AND SUM(D.Quantity*D.UnitPrice)<5000
		THEN 'MIDIUM'
	WHEN SUM(D.Quantity*D.UnitPrice)>5000 AND SUM(D.Quantity*D.UnitPrice)<10000
		THEN 'HIGH'
	ELSE 'OVER HIGH'
	END AS state
FROM 
	Customers C JOIN Orders O
	ON C.CustomerID=O.CustomerID
	join
	[Order Details] D
	ON O.OrderID=D.OrderID
WHERE OrderDate between '1-1-1998' and '1-1-1999' 
AND C.CustomerID='MAISD'
GROUP BY C.customerid,c.CompanyName
ORDER BY C.customerid 

-------Question 50---------
with grou as (
SELECT
	C.customerid,
	C.CompanyName,
	isnull(ROUND(SUM(D.Quantity*D.UnitPrice),-1),0)totalAmount,
	CASE 
	WHEN SUM(D.Quantity*D.UnitPrice) <1000 
		then 'low'
	WHEN SUM(D.Quantity*D.UnitPrice) > 1000 AND SUM(D.Quantity*D.UnitPrice)<5000
		THEN 'MIDIUM'
	WHEN SUM(D.Quantity*D.UnitPrice)>5000 AND SUM(D.Quantity*D.UnitPrice)<10000
		THEN 'HIGH'
	ELSE 'OVER HIGH'
	END AS CustomerGroup
FROM 
	Customers C JOIN Orders O
	ON C.CustomerID=O.CustomerID
	join
	[Order Details] D
	ON O.OrderID=D.OrderID
WHERE OrderDate between '1-1-1998' and '1-1-1999' 
GROUP BY C.customerid,c.CompanyName
)

SELECT CustomerGroup,
	COUNT(CUSTOMERID)TOTALInGroup,
	PercentageInGroup=COUNT(*)*1.0/(SELECT COUNT(*) FROM GROU)
FROM grou
group by CustomerGroup
order by COUNT(CUSTOMERID) desc;

-----------QUESTION 52--------
-- counties of customers
-- countries of suppliers
Select Country From Customers
Union
Select Country From Suppliers
Order by Country;

--------Question 53--------

WITH tableone as
(
SELECT distinct country as CustomerCountry FROM Customers 
)
,tabletwo as
(
SELECT distinct country as SupplierCountry From Suppliers 
)
SELECT * FROM
tabletwo full join tableone
ON CustomerCountry=SupplierCountry


---------QUESTION 54--------

WITH tableone as
(
SELECT country as CustomerCountry FROM Customers 
)
,tabletwo as
(
SELECT country as SupplierCountry From Suppliers 
)
SELECT country=isnull(customercountry,0),
	count(CustomerCountry) totalCustomers,
	count(SupplierCountry)totalsuppliers
FROM
tabletwo full join tableone
ON CustomerCountry=SupplierCountry
group by customercountry
order by customercountry

-------------QUESTION 55------------
with num as(
SELECT ShipCountry, 
orderid,
CustomerID,
orderDate=convert(date,OrderDate)
,RowNumberPerCountry =
	Row_Number()
	over (Partition by ShipCountry Order by ShipCountry, OrderID)
FROM Orders 
)
SELECT ShipCountry, 
	orderid,
	CustomerID
FROM num
WHERE RowNumberPerCountry= 1
order by ShipCountry,
		orderid; 

------------QUESTION 57-----------
WITH num AS(
SELECT c.CustomerID,
		OrderID,	
		CONVERT(date,o.OrderDate)OrderDate,
		period=DATEDIFF(day,convert(date,o.OrderDate),
							lag(orderdate)over(partition by c.customerid order by orderid desc))
FROM Orders o join Customers c
ON o.CustomerID=c.CustomerID
)
SELECT CustomerID,
		OrderID,
		period
FROM num
WHERE period<=5
ORDER BY customerid,OrderDate
