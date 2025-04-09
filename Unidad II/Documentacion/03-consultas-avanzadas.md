# Consultas Avanzadas 

``` sql

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

--11. Listar los clientes y la cantidad de pedidos que han realizado 
 select c.CompanyName, 
 count(o.OrderID) as 'Numero de Ordenes'
 from Customers as c 
 inner join Orders as o 
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by [Numero de Ordenes] desc 

 select c.CompanyName, 
 count(*) as 'Numero de Ordenes'
 from Customers as c 
 inner join Orders as o 
 on c.CustomerID = o.CustomerID
 group by c.CompanyName
 order by 2 desc 

--12. Obtener los empleados que han gestionado pedidos enviados a alemania 

select * from Orders

 select  distinct concat (e.FirstName, ' ', e.LastName) as [Nombre]
 from Employees as e
 inner join Orders as o 
 on e.EmployeeID = o.EmployeeID
 where ShipCountry = 'Germany' 

 select  concat (e.FirstName, ' ', e.LastName) as [Nombre]
 from Employees as e
 inner join Orders as o 
 on e.EmployeeID = o.EmployeeID
 where ShipCountry = 'Germany' 


--13. Listar los productos junto con el nombre del 
--proveedor y el pais de origen 
 Select p.ProductName as [Nombre Producto],
 s.CompanyName as [Proveedor],
 s.Country as [Pais de Origen] 
 from  Products as p 
 inner join Suppliers as s 
 on p.SupplierID = s.SupplierID
 order by 1 asc 

 --14. Obtener los pedidos agrupados por pais de envio 
Select o.ShipCountry as [Pais de Envio], 
count (o.OrderID) as [Numero de Ordenes]
from Orders as o
group by o.ShipCountry
order by 2 desc 

 --15. Obtener los empleados y la cantidad de territorios 
 -- en los que trabajan 

 select concat (e.FirstName ,' ', e.LastName) as [Nombre],
count (et.TerritoryID) as [Cantidad Territorio],
t.TerritoryDescription as [Descripcion]
from
Employees as e
join
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
join
Territories as t 
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by 1 asc, t.TerritoryDescription desc
 

 
 --16. Listar las categorias y la cantidad de productos 
 --que contienen 
 select c.CategoryName as [Categoria],
 count (p.ProductID) as 'Cantidad de productos' 
 from Categories as c 
 inner join Products as p 
 on c.CategoryID = p.CategoryID
 group by c.CategoryName 
 order by 2 desc 

 --17.Obtener la cantidad total de productos vendidos por 
 --proveedor 

 select  s.CompanyName as [Provedor]
 from Suppliers as s 
 inner join Products as p 
 on s.SupplierID = p.SupplierID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
group by s.CompanyName


 --18. Obtener la cantidad de pedidos enviados por cada 
 --empresa de tranporte 

 select s.CompanyName as [Transportista], count(*) as [Total de Pedidos]
 from Orders as o 
 inner join Shippers as s 
 on o.ShipVia = s.ShipperID
 group by s.CompanyName


select * from Orders 

select count(*) from Orders 

select count(OrderID) from Orders 

select count(ShipReligion) from Orders 

--19. Obtener  los clientes que han realizado pedidos de productos distintos
select distinct count  (distinct ProductID) as 'Numero productos'  
from 
Customers as c 
INNER JOIN Orders as o 
on c.CustomerID = o.CustomerID 
Inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.CompanyName
Order by 1 desc 


select distinct (ProductID) as 'Numero productos'  
from 
Customers as c 
INNER JOIN Orders as o 
on c.CustomerID = o.CustomerID 
Inner join [Order Details] as od 
on od.OrderID = o.OrderID
Order by 1 desc 

--20. Listar los empleados o la cantidad total de pedidos que han gestionado
--y a que clientes les han vendido, agrupandolos por nombre completo y dentro de este nombre por 
--cliente, ordenadolos por la cantidad de mayor de pedidos.

Select concat (e.FirstName, ' ', e.LastName) as 'Nombre' ,
c.CompanyName as [Cliente],
count (OrderID)  as [Numero de clientes]
from Employees as e
inner join  Orders as o 
on o.EmployeeID = e.EmployeeID
inner join Customers as  c
on o.CustomerID =c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by [Nombre] asc, [Cliente] 

--Consutas Avanzadas 

--EJEMPLO DE LA CONSULTA DE LA OTRA BASE 
/*select pr.Descripcion, pr.Precio, pr.Id_fab, p.Fab, pr.Id_producto, p.Producto 
from Pedidos as p 
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto */

--21. Listar las categorias con el total de ingresos generados por sus productos
select c.CategoryName, sum(od.Quantity *od.UnitPrice) as [Total]
from Products as p
inner join  Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
group by c.CategoryName 

--22. Listar los clientes con el total ($) gastado en pedidos
select c.CompanyName, sum (od. Quantity * od.UnitPrice) as [Total]
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.CompanyName

--23.Listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y 
--mostrar el total en dinero
select o.OrderID, sum (od.Quantity * od.UnitPrice) as [total]
from Orders as o 
inner join [Order Details] as od 
on o.OrderDate = od.OrderID
where OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate


--24. Listar los productos con las categorias Beverages, seafood, confections 
select p.ProductName , c.CategoryName 
from Categories as c 
inner join Products as p 
on c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages', 'seafood', 'confections')

--25. Listar los clientes ubicados en Alemania y que hayan 
--realizado pedidos antes del 1 de enero de 1997 
select c.CompanyName, c. Country, o.OrderDate
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
where country = 'Germany'
and o.OrderDate<'1997-01-01'

--26. Listar los clientes que han realizado pedisos con un total entre $500 y $2000
select c.CompanyName, sum (od.Quantity * od.UnitPrice)
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
group by c.CompanyName
having sum (od.Quantity * od.UnitPrice) between 500 and 2000


--left Join, Right Join, Full Join y Cross join. 


```