--sintaxis 
/* create view nombreVista
AS
Select columnas 
from tabla 
where condicion 
*/

use Northwind;
go

-- Crear vista 
--alter view sin eliminarlos
create or alter view VistaCategoriaTodas 
AS
select CategoryID, CategoryName,[Description], picture
from Categories
where CategoryName = 'Beverages'
go 

drop view VistaCategoriaTodas 

select * from  VistaCategoriaTodas 
where CategoryName= 'Beverages'

--Crear una vista que permita visualizar solamente los clientes de mexico y brazil
go 

create or alter view  VistaClientesLatinos
as
select* from Customers
where Country in ('Mexico', 'Brazil')

select CompanyName as [Cliente],
City as [Ciudad], Country as [Paris]
from VistaClientesLatinos
where city= 'Sao Paulo'
Order by 2 desc 


select distinct vcl.Country from 
Orders as o 
Inner join VistaClientesLatinos as vcl 
on vcl.CustomerID = o.CustomerID   

--Crear una vista que contenga los datos de todas las ordenes 
--los productos, categorias de productos, empleados y clientes
--en orden 
--calcular el importe
create or alter view  [dbo].[vistaordenescompra]
as
select o.OrderID as [Numero de orden], o.OrderDate as [Fecha de orden], o.RequiredDate as [Fechad e requisicion], 
concat(e.FirstName,' ', e.LastName) as [Nombre empleado], cu.CompanyName as [Nombre del cliente], p.ProductName as [Nombre del producto], 
c.CategoryName as [Nombre de la categoria],od.UnitPrice as [Precio de venta], od.Quantity as [Cantidad vendida], 
(od.Quantity * od.UnitPrice) as [importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID=p.ProductID
inner join Orders as o
on od.OrderID =o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID
 
select count(distinct [numero Orden]) as [Numero de Ordenes]
from vistaordenescompra

select sum([Cantidad Vendida] * [Precio de Venta]) as [importe Total]
from vistaordenescompra
Go

select sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden]) between '1995' and '1996'  
Go

create or alter view vista_ordenes_1995_1996
as
select [Nombre del Cliente] as 'Nombre Cliente',
sum(importe) as [importe Total]
from vistaordenescompra
where year([Fecha de Orden])
between '1995' and '1996'  
group by [Nombre del Cliente]
having count(*)>2

 
 
 --Extra 
 DROP TABLE rh.tablarh;
 DROP SCHEMA rh;


 create schema rh 

 create table rh.tablarh (
 id int primary key ,
 nombre nvarchar(50)
 )

 --vista horizontal
 create or alter rh.viewcategoriasproductos
 as 
 select c.CategoryID, CategoryName, p.ProductID, P.ProductName
 from 
 Categories as c 
 inner join Products as p 
 on c.CategoryID = P.CategoryID

 select * from vistaordenescompra 

 select [Nombre Producto], sum (importe) as [Monto Total]
 from rh.viewcategoriasproductos
 group by [Nombre 


