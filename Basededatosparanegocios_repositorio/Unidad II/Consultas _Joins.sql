use Northwind;
--joins

select * from
Categories
inner join 
Products
on Categories.CategoryID = Products.CategoryID;

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from
Categories
inner join 
Products
on Categories.CategoryID = Products.CategoryID;

select C.CategoryID as [Numero de categoria], CategoryName as [Nombre categoria], ProductName as [Nombre del producto],
UnitsInStock as 'Existencia', UnitPrice as 'Precio' from
Categories as C
inner join 
Products as P
on C.CategoryID = P.CategoryID;


select * from Products;
select * from Categories;
--Seleccionar los productos de la categoria beverages y condiments, donde la existencia este entre 18 y 30

select * from 
Products as P
join
Categories as C
on C.CategoryID = P.CategoryID
where (C.CategoryName in ('beverages', 'condiments'))
and  P.UnitsInStock >= 18 and  P.UnitsInStock <= 30

select * from 
Products as P
join
Categories as C
on C.CategoryID = P.CategoryID
where (C.CategoryName = 'beverages' or C.CategoryName = 'condiments')
and  P.UnitsInStock >= 18 and  P.UnitsInStock <= 30

--seleccionar los productos y sus importes realizados de marzo a junio de 1996, mostrando la fecha de la orden, , id del producto y 
--el importe
select * from [Order Details];

select O.OrderID, O.OrderDate, OD.ProductID, 
(OD.UnitPrice*OD.Quantity) as Importe from 
Orders as O
join
[Order Details] as OD
on O.OrderID = OD.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-31'

select getdate()

--Mostrar el importe total de ventas de la consulta anterior

select concat('$',' ',sum(OD.UnitPrice*OD.Quantity)) as Importe 
from Orders as O
join
[Order Details] as OD
on O.OrderID = OD.OrderID
where O.OrderDate between '1996-07-01' and '1996-10-31'



--Consultas Basicas con inner join 

--1. Obtener los nombres de los clientes y los paises a los que se enviaron 
--sus pedidos

select c.CompanyName as 'Nombre de cliente', O.ShipCountry
from orders as o
inner join Customers as c 
on c.CustomerId= o.CustomerID
order by 2 desc 

select o.CustomerID, O.ShipCountry
from orders as o
inner join Customers as c 
on c.CustomerId= o.CustomerID
order by o.shipCountry desc 

--2. Obtener los productos y sus respectivos proveedores 

select p.ProductName as 'Nombre de procusto' , 
s.CompanyName as 'Nombre de proveedor' 
from Products as p 
inner join 
Suppliers as s
on p.SupplierID = s.SupplierID 


--3. Obtener los pedidos y los empleados que los gestionaron 
select o.OrderID, concat (e.Title, '-', e.FirstName, ' ', e.LastName) as 'Nombre' 
from Orders as O
inner join 
Employees as e
on O.EmployeeID = E.EmployeeID

--4. Listar los productos, junto con sus precios y la categoria a la que pertenecen 
select p.UnitPrice  as 'Nombre de producto' , 
c.CategoryName as 'Nombre de proveedor' 
from Products as p 
inner join 
Categories as c
on p.CategoryID = c.CategoryID


select p.ProductName, p.UnitPrice , c.CategoryName, 
c.CategoryName as 'Nombre del producto' 
from Products as p 
inner join 
Categories as c
on p.CategoryID = c.CategoryID
Where c.CategoryName = 'Fast Food'


--5. Obtener el nombre del cliente, el numero de orden y la fecha de orden 
select c.CompanyName  as 'Nombre del cliente' , 
o.OrderDate as 'fecha de orden', o.OrderID as 'Numero de Orden' 
from Customers as c 
inner join 
Orders as o
on c.CustomerID = o.CustomerID

--6. Listar las ordenes mostrando el numero de orden, el nombre del producto y 
-- la cantidad que se vendio

select od.OrderID , p.ProductName, od.Quantity 
from [Order Details] as od
inner join  Products as p 
on od.ProductID = p.ProductID
order by od.Quantity desc 

select top 5 od.OrderID , p.ProductName, od.Quantity 
from [Order Details] as od
inner join  Products as p 
on od.ProductID = p.ProductID
order by od.Quantity desc 

select od.OrderID as 'Numero de Orden' 
, p.ProductName as 'Nombre del producto' 
, od.Quantity as 'Cantidad Vendida' 
from [Order Details] as od
inner join  Products as p 
on od.ProductID = p.ProductID
where od.OrderID = 11031
order by od.Quantity desc 

select od.OrderID as 'Numero de Orden', count(*) as 'cantidad de productos vendidos'
from [Order Details] as od
inner join  Products as p 
on od.ProductID = p.ProductID
group by od.OrderID
Order by od.OrderID desc 

select * from 
[Order Details]  as od 
where od.OrderID = 11077

--7.Obtener los empleados y sus respectivos jefes 

select concat (e1.FirstName, ' ', e1.lastName )as [Empleado],
concat(j1.FirstName, ' ', j1.LastName) as [jefe]
from Employees as e1
inner join Employees as j1 
on e1.ReportsTo = j1.EmployeeID

 --8. Listar los pedidos  el nombre de la empresa de transporte utilizada 
 select o.OrderID, s.CompanyName
 from Shippers as s 
 inner join Orders as o 
 on o.ShipVia = s.ShipperID

 --Consultas join intemedias 
 --9. Obtener la cantidad totall de productos vendidos por categoria

 select sum(Quantity) from [Order Details]

 select c.CategoryName as 'Nombre Categoria',
 sum(Quantity) as 'Productos Vendidos'
 from Categories as c 
 INNER JOIN Products as p 
 on c.CategoryID =.CategoryID
 INNER JOIN [Order Details] as od 
 on od.ProductID =p.ProductID
 group by c.CategoryName
 order by c.CategoryName

 --10. Obtener el total de ventas por empleado
 
 select concat (e.FirstName, ' ', e.LastName) as Nombre,
 sum((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount)
 as Total 
 from Orders as o 
 inner join Employees as e 
 on o.EmployeeID = e.EmployeeID
 inner join [Order Details] as od 
 on od.OrderID = o.OrderID
 group by e.FirstName, e.LastName 

select count(*)
from Orders as o 
where EmployeeID = 1

select * from 
Orders as o 
where EmployeeID = 1

--full join: Todas las tablas 




