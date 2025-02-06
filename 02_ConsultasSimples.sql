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

 --Operadores Logicos (or, and y not)
 --Selecccionar los productos que tengan un precio de entre 10 y 50 

 select ProductName as 'Nombre', UnitPrice 'precio', UnitsInStock as 'Existencia'
 from Products 
 where UnitPrice>=10
 and UnitPrice<=50;

 --Mostrar todos los pedidos realizados por clientes que No 
 --son enviados a alemania 

 select ShipCountry
 from Orders
where ShipCountry <> 'Germany'; 

 select ShipCountry
 from Orders
where not ShipCountry = 'Germany'; 

--Seleccionar clientes de mexico o estados unidos 
select Country
 from Customers
where Country = 'Mexico' or Country ='USA';

--seleccionar empleados que nacieron entre 1955 y 1958 y 
--que viven en londres

select HireDate, City
 from Employees
where (year (BirthDate)>= 1955 or year (BirthDate)<+1958) and City = 'London';

select * from Employees
where year (BirthDate)>= 1955 and year (BirthDate)<+1958 and City = 'London';

--Seleccionar los Pedidos con flete de peso (Freight) mayor a $100
--y enviados a francia o España

Select OrderID, OrderDate, Freight, ShipCountry 
from Orders
where Freight > 100 and (ShipCountry = 'France' or ShipCountry='Spain'); --Parentesis para darle prioridad de cual va a leer primero 

--Seleccionar las primeras 5 ordenes de compra 

select top 5* from Orders 

--Seleccionar Productos con precio entre $10 y $50,
--que NO esten descontinuados y tengan mas de 20 unidades en stock 

Select UnitPrice, Discontinued, UnitsInStock
from Products
where UnitPrice >= 10 and UnitPrice <= 50 
      and Discontinued = 0 and UnitsInStock >20;

--Pedidos enviados a francia o Alemania, pero con un flete menor a 50 
Select OrderID, Freight, ShipCountry 
from Orders
where Freight <= 50 and (ShipCountry = 'France' or ShipCountry='Germany');

--Clientes que NO sean de Mexico o USA y 
--que tengan fax registrado

select CompanyName, Country, City, Fax
from Customers
where not (Country='Mexico' or Country='USA')
      and Fax is not null

--Seleccionar Pedidos con un flete mayor a 100 
--enviados a brasil o Argentina 
--Pero no enviados por el transportista 1 

select * from Shippers 

--seleccionar empleados que NO viven en londres o Seattle 
--y que fueron contratados 

Select concat (FirstName,'', LastName) as [Nombre completo], 
              hiredate, city, country
from Employees
where city <> 'London'

--Clausula IN (or)
--seleccionar los productos con categoria 1, 3 0 5 
select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID= 5

select ProductName, CategoryID, UnitPrice 
from Products
where CategoryID in (5,3,5);

--seleccionar todas las ordenes de la region RJ, Tachira y que 
--no tengan region asignada 

select OrderID, OrderDate, ShipRegion
from Orders
where ShipRegion in ('RJ', 'Tachira')
      or ShipRegion is null 

--Seleccionar las ordenes que tengan cantidades de 12, 9 y 40 
--y descuento de 0.15 y 0.05 

select Quantity, Discount
from [Order Details]
where Quantity in (12, 9, 40)
      and Discount in (0.15, 0.05);


--Clausula Between (Siempre va en el where) --son rangos--

--between valorInicial and ValorFinal---
--Mostrar los productos con precio entre 10 y 50

select * from Products
where UnitPrice >= 10 and UnitPrice<=50;

select * from Products
where UnitPrice between 10 and 50 

--Seleccionar todos los pedidos realizados entre el primero de enero y 30 de junio de 1997

select * from Orders
where OrderDate >= '1997-01-01' and 
OrderDate <= '1997-06-30';

select * from Orders
where OrderDate between '1997-01-01' and '1997-06-30';

--Seleccionar todos los empleados contrtatados entre 1990 y 1995 que trabajan en londres 

select HireDate, City
 from Employees
where (year (HireDate)>= 1990 or year (	HireDate)<+ 1995) and City = 'London';

select HireDate, City
 from Employees
where year (HireDate) between 1992 and 1994 
       and City = 'London';

--Pedidos de flete (freigh) entre 50 y 200 enviados a alemania, 
--y a francia 

Select OrderID, Freight, ShipCountry as [Pais de entrega]
from Orders
where Freight between 50 and 200 and ShipCountry in ( 'France', 'Germany')

--seleccionar todos los productos que tengan un precio 
--entre 5 y 20 dolares y que sean  de la categoria 1,2 o 3 

select ProductName, UnitPrice, CategoryID
from Products
where UnitPrice between 5 and 20 and CategoryID in ('1','2','3')

--Empleados con numero de trabajador entre 3 y 7 que no 
--trabajan en londres ni seattle 
 select EmployeeID as [Numero de Empleado], CONCAT (firstName, ' ', LastName) 
 as [Nombre completo],  City as [cuidad]
 from Employees
 where EmployeeID between 3 and 7 and not City in ('London', 'Seattle')

 --CLAUSULA 
 /* Patrones:
  1) % (Porcentaje) -> Representa creo o mas caracteres en el patron 
          de busqueda 

  2)_(Guion Bajo) Representa exactamente un caracter en el patron de busquedad 

  3) [] corchetes -> Se utiliza para definir un conjunto de caracteres, buscando 
     cualquiera de ellos en la posicion especifica 

 4) [^] -> Se utiliza para buscar caracteres que no estan dentro del conjunto especifico 
 */

 --Buscar los productos  que comienzan con Cha 
 select * from 
 products
 where ProductName  like 'C%'

 select * from 
 products
 where ProductName  like 'Cha%' 
 and Unitprice=18 

 --Buscar todos los  productos que terminen con e 
  select * from 
 products
 where ProductName  like '%e'  

 --Seleccionar todos lo clientes cuyo nombre de empresa 
 --contiene "co" en cualquier parte 
 select * from 
 Customers
 where CompanyName like '%Co%'  

 --Selecciaonar los empleados cuyo nombre comience con "A" y tenga exactamente 5 caracteres 
 
 select FirstName, LastName
 from Employees
 where FirstName like 'A__'

 --seleccionar los productos que comiencen con A o B 
 select * from 
 Products 
 where ProductName like '[A-M]%'

  select * from 
 Products 
 where ProductName like '[ABC]%'

 --Seleccionar todos los productos que no comiencen con A O B 
 select * from 
 Products 
 where ProductName like '[^AB]%'

 --seleccionar todos los productos donde el nombre comience con a pero no contenga la e 
 select * from 
 Products 
 where ProductName like 'a[^e]%'

 --Clausula order by
 
 select ProductID, ProductName, UnitPrice, UnitsInStock 
 from Products
 order by UnitPrice desc

 select ProductID, ProductName, UnitPrice, UnitsInStock 
 from Products
 order by 3 desc

 select ProductID, ProductName, UnitPrice as 'Precio', UnitsInStock 
 from Products
 order by 'Precio' desc

 --Seleccionar los clientes ordenandos por el pais y dentro por 
 --cuidad 
 select CustomerID, Country, City
 from Customers
 where Country in ('Brazil', 'Germany')
 order by country asc, city desc
 
 
 select CustomerID, Country, City
 from Customers
 where (Country = 'Brazil' or country = 'Germany')
 and region is not null 
 order by country asc, city desc

 select CustomerID, Country, City
 from Customers
 where Country in ('Brazil', 'Germany')
 order by country asc, city desc
 


  
