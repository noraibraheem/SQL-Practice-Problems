-- QUESTION 1
SELECT * FROM shippers

--QUESTION 2
SELECT c.categoryname, c.description FROM categories c

--QUESTION 3
-- select * from Employees
SELECT firstname,lastname,hiredate 
from employees
WHERE title='sales representative'

-- QUESTION 4
SELECT firstname,lastname,hiredate 
FROM employees
WHERE title='sales representative' AND country='USA'

--QUESTION 5

SELECT orderid,orderdate FROM orders WHERE employeeid=5

-- QUESTION 6
SELECT * FROM suppliers
SELECT supplierid,contactname,contacttitle
FROM suppliers
WHERE contacttitle!='marketing manager'

-- QUESTION 7
SELECT productid,productname 
FROM products
WHERE productname like '%queso%'

-- QUESTION 8
SELECT orderid,customerid,shipcountry
FROM orders 
WHERE shipcountry='france'or shipcountry='belgium'

-- QUESTION 9
SELECT orderid,customerid,shipcountry
FROM orders 
WHERE 
shipcountry in ('brazil','mexico','argentina','venezuela')

-- Question 10

SELECT
firstname,lastname,title,birthdate
FROM employees
ORDER BY birthdate 

--QUESTION 11
SELECT
firstname,lastname,title,
convert(date,birthdate)DateOnlyBirthDate
FROM employees
ORDER BY birthdate 

-- Question 12
SELECT firstname,lastname,
concat(firstname,' ',lastname)FullName
FROM employees

-- Question 13
SELECT 
orderid,productid,unitprice,quantity,(unitprice*quantity)totalprice
from [Order Details]
ORDER BY orderid,productid

-- Question 14
SELECT COUNT(customerid) FROM customers

-- QUESTION 15
SELECT min(orderdate) FROM orders

--QUESTION 16
SELECT DISTINCT country FROM customers 

--QUESTION 17
SELECT contacttitle,count(contacttitle)
from customers
group by contacttitle
order by count(contacttitle) desc

------------------JOIN---------------------
--QUESTION 18
SELECT p.productname,p.productid,s.companyname
from suppliers s join products p
on s.supplierid=p.productid
order by productid

--QUESTION 19
SELECT o.orderid,convert(date,o.OrderDate)OrderDate,s.companyname
FROM orders o join shippers s
on s.ShipperID=o.ShipVia
where orderid < 10300
order by orderid



