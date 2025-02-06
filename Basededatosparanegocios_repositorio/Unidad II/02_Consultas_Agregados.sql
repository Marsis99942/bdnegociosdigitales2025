--Consultas de agregado --funcion de agregado o resumen 
--nota: solo devuelven un solo registro  
--sum, avg, count, count(*), max y min 

--Cuantos clientes tengo

select count(*) as 'Numero de clientes'  
from Customers

--Cuantas regiones hay 
select count (*) --cuenta las filas que tiene las tablas y no le importan los nulos
from Customers
where region is null
 

 -- Respuesta Correcta 
select count (distinct region) 
from Customers
where region is not null

select * from Orders
select count (*) from Orders 
select count(ShipRegion) from Orders

select * from Products 

--selecciona el precio mas bajo de los productos 

--Solo dan un solo resultado 

select min (UnitPrice), max (UnitPrice),
avg(UnitsInStock) --media o promedio 
from Products;

--seleccionar cuantos pedidos existen 
select count (*) as 'Numero de pedidos'  
from Orders

--calcula el total de dinero vendido 
select sum (UnitPrice* Quantity) 
from [Order Details]

select sum (UnitPrice* Quantity -
(UnitPrice  * Quantity * Discount)) as total --campo calculado y funcion de agregado 
from [Order Details]


--calcula el total de unidades en stock de todos los productos
select * from Products 
select sum (UnitsInStock) from Products

select  sum (UnitsInStock) as 'Total Stock'
from Products

--Group by

--seleccionar el numero de productos por categoria
select count (CategoryID), count(*) as 'Numero de productos' 
from Products
group by CategoryID

select * from 
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID

select * from 
Categories 
inner join Products as p
on Categories.CategoryID = p.CategoryID

--sii
select Categories.CategoryName, 
count(*)  as [Numeros de Productos]
from 
Categories 
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName


--Calcular el precio promedio de los productos por cada categoria
select CategoryID, avg(UnitPrice)  from Products
group by CategoryID

--seleccionar el numero de pedidos realizados por cada empleado por el 
--ultimo trimestre de 1996
select EmployeeID, count (*) as 'Numero de pedidos'
from Orders
group by  EmployeeID

select EmployeeID, count(*) from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by  EmployeeID

--seleccionar la suma total de unidades vendidad por cada producto 
select top 5  ProductID ,sum (Quantity) as 'Numero de productos vendidos' -- productos que mas le han comprado
from [Order Details]
group by ProductID
order by 2 desc 


--Este esta mas especifico de productos vendidos por cada orden 
select OrderID , ProductID ,sum (Quantity) as 'Numero de productos vendidos'
from [Order Details]
group by OrderID, ProductID
order by 2 desc 

--HAVING : es un where del group by 
 --where:filtra filas 
 --having: filtra grupos

 --seleccionar el numero de productos por categoria pero, solo aquellos 
 --que tengan mas de 10 productos 

 --paso 1
 select * from Products 
 --select distinct CategoryID from Products

 --Paso 2
 select CategoryID, UnitsInStock from Products
 where CategoryID in (2,4,8)
 order by categoryID 

 --Paso 3: agrupacion 
 select CategoryID, sum (UnitsInStock)from Products
 where CategoryID in (2,4,8)
 group by categoryID
 order by categoryID 

 --paso 4
  select CategoryID, sum (UnitsInStock)from Products
 where CategoryID in (2,4,8)
 group by categoryID
 having count(*)>=10 
 order by categoryID 

 --listar las ordenes agrupadas por empleado, pero que solo muestre aquellos que 
 --hayan gestionado mas de 10 pedidos  
 
 select EmployeeID
 from Orders
 group by EmployeeID
 having count(*)>10 
 order by EmployeeID
 
 
 select * from Orders




