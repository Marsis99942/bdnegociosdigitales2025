--Lenguaje SQL-LMD (insert, update, delete, select- CRUD)
--Consultas Simples

use Northwind;
--	Mostrar todos los cliente, proveedores, categorias, productos con todas las columnas de datos de la empresa

select*from Customers;
select *from Employees;
select*from Orders;
select*from Suppliers;
select*from Products;
select*from Categories;
select*from [Order Details];
select*from Shippers;

--Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock 
from products;

--seleccionar el numero de empleado, su primer nombre, su cargo, ciudad y pais. 
select EmployeeID, FirstName, Title, Country, City 
from employees;

--Alias de columna 

--En base a la consulta anterior, visualizar es employeeid
-- como numero de empleados, firstname como primer nombre, 
--title como cargo, city como ciudad, country como pais

select EmployeeID as 'Numero Empleado',
FirstName as primernombre,
Title 'cargo',
city as ciudad,
country as pais 
from employees;

select EmployeeID as [Numero Empleado],
FirstName as primernombre,
Title 'cargo',
city as ciudad,
country as pais 
from employees;

-- Campos calculados
--selecccionar el importe de cada uno de los productos
--vendidos en una orden 

select*, (UnitPrice * Quantity) as importe from [Order Details]

--selecionar las fechas de orden, año, mes y dia, el cliente 
--que las ordeno y el empleado que la realizo

select OrderDate,year(OrderDate) as año , month(OrderDate) as mes , day (OrderDate) as dia,
CustomerID, EmployeeID from Orders;

 --filas Duplicadas (Distinct)
 select* from Customers;
  
  --Mostrar los paises en donde se tienen clientes,
  --mostrando pais solamente 

  --Quitar datos repetidos
  select distinct Country from Customers
  order by Country
  
  --clausula where
--Clausula where
--Operadores relacionales (<,>,=,<=,>=, != o <>)
select * from Customers;

--Seleccionar el cliente BOLID

select CustomerID, CompanyName, City, country 
from Customers
where CustomerID = 'BOLID';

--Seleccionar los clientes, mostrando su identificador,
--nombre de la empresa, contacto, ciudad y pais
-- de alemania

select CustomerID as Identificador,
CompanyName, ContactName, Country, City 
from Customers
where Country = 'Germany' 

--Seleccionar todos los clientes que no sean de alemania

select CustomerID as Identificador,
CompanyName, ContactName, Country, City 
from Customers
where not Country = 'Germany' 

--Seleccionar todos los productos mostrando su nombre de producto
--categoria a la que pertenece, existencia, precio, pero solamente donde su precio sea mayor a 100 y mostar su costo de inventario 
 
 select ProductName as NombredeProducto,
 CategoryID as Categoria,
 UnitsInStock as existencia, 
 UnitPrice as Precio 
 from Products
 where UnitPrice >100 

 --seleccionar las ordenes de compra
 --mostrando la fecha de orden, la fechard e entrega, 
 --fecha de envio, el cliente a quien se vendio
 --de 1996

 select OrderDate as fechaOrden, 
 RequiredDate [fecha de requerimiento de entrega],
 ShippedDate 'fecha de envio', 
 CustomerID as Cliente
 from Orders
 where year (OrderDate) = '1996'

--Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5 

select * from [Order Details]
where Quantity >5;

--Mostrar el nombre completo del empleado, su numero de empleado, fecha de nacimiento, ciudad,
--fecha de contratacion y esta debe ser de aquellos que fueron contratados despues de 1993
--los resultados en sus encabezados deben ser mostrados en espanol 

select lastName as 'Apellido', firstName as'Primer Nombre', EmployeeID as 'Numero de empleado', BirthDate as 'fecha de nacimiento' 
, HireDate as 'fecha de contratacion'
from employees
where year (HireDate) > 1993

select (FirstName + '' + LastName) as 'Nombre Completo', EmployeeID as 'Numero de empleado', BirthDate as 'fecha de nacimiento' 
, HireDate as 'fecha de contratacion'
from employees
where year (HireDate) > 1993

select Concat(FirstName, '', LastName, '-', Title) as 'Nombre Completo', EmployeeID as 'Numero de empleado', BirthDate as 'fecha de nacimiento' 
, HireDate as 'fecha de contratacion'
from employees
where year (HireDate) > 1993

--Mostrar los empleados que no son dirigidos por el empleado o por jefe 2
select ReportsTo
 from Employees
 where (reportsTo) != 2 

 --Seleccionar los empleados que no tengan jefe 
 select*from Employees
 where ReportsTo is null 
