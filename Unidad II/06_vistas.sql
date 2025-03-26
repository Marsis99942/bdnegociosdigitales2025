--sintaxis 
/* create view nombreVista
AS
Select colum1, colum2...
from tabla_name
where condicion;
*/


/*CREATE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';

-Podemos consultar la vista anterior de la siguiente manera:

SELECT * FROM [Brazil Customers];


--El siguiente SQL crea una vista que selecciona todos los productos
--de la tabla "Productos" con un precio superior al precio medio:

CREATE VIEW [Products Above Average Price] AS
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
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

drop view VistaCategoriaTodas --Eliminar Vista

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
 


 /* Muestra los pedidos con información del cliente y el representante que los gestionó.*/
 
 CREATE VIEW Vista_Pedidos_Clientes AS
SELECT 
    P.Num_Pedido, P.Fecha_Pedido, 
    C.Num_Cli, C.Empresa, 
    R.Num_Empl AS Rep_ID, R.Nombre AS Representante,
    P.Fab, P.Producto, P.Cantidad, P.Importe
FROM Pedidos P
INNER JOIN Clientes C ON P.Cliente = C.Num_Cli
INNER JOIN Representantes R ON P.Rep = R.Num_Empl;

--Muestra los productos con su cantidad disponible en stock y su precio.
CREATE VIEW Vista_Productos_Stock AS
SELECT 
    Id_fab, Id_producto, Descripcion, Precio, Stock
FROM Productos;


--Muestra cuántos pedidos ha gestionado cada representante y el total de ventas.
CREATE VIEW Vista_Representantes_Ventas AS
SELECT 
    R.Num_Empl, R.Nombre AS Representante, 
    COUNT(P.Num_Pedido) AS Total_Pedidos, 
    SUM(P.Importe) AS Total_Ventas
FROM Representantes R
LEFT JOIN Pedidos P ON R.Num_Empl = P.Rep
GROUP BY R.Num_Empl, R.Nombre;


--Muestra el total de compras de cada cliente y si ha superado su límite de crédito.
CREATE VIEW Vista_Clientes_Credito AS
SELECT 
    C.Num_Cli, C.Empresa, C.Limite_Credito, 
    COALESCE(SUM(P.Importe), 0) AS Total_Compras, 
    CASE 
        WHEN COALESCE(SUM(P.Importe), 0) > C.Limite_Credito THEN 'Excedido'
        ELSE 'Dentro del límite'
    END AS Estado_Credito
FROM Clientes C
LEFT JOIN Pedidos P ON C.Num_Cli = P.Cliente
GROUP BY C.Num_Cli, C.Empresa, C.Limite_Credito;


--Muestra los pedidos con el precio unitario del producto y el importe total.
CREATE VIEW Vista_Pedidos_Detalles AS
SELECT 
    P.Num_Pedido, P.Fecha_Pedido, 
    PR.Id_fab, PR.Id_producto, PR.Descripcion, 
    P.Cantidad, PR.Precio, 
    P.Importe
FROM Pedidos P
INNER JOIN Productos PR ON P.Fab = PR.Id_fab AND P.Producto = PR.Id_producto;


--Muestra los productos que aún no han sido vendidos en ningún pedido.
CREATE VIEW Vista_Productos_Sin_Ventas AS
SELECT PR.Id_fab, PR.Id_producto, PR.Descripcion, PR.Stock
FROM Productos PR
LEFT JOIN Pedidos P ON PR.Id_fab = P.Fab AND PR.Id_producto = P.Producto
WHERE P.Num_Pedido IS NULL;


 --Lista todas las oficinas con los representantes que trabajan en cada una.
 CREATE VIEW Vista_Oficinas_Representantes AS
SELECT 
    O.Oficina, O.Ciudad, O.Region, 
    R.Num_Empl, R.Nombre AS Representante, R.Puesto
FROM Oficinas O
INNER JOIN Representantes R ON O.Oficina = R.Oficina_Rep;

--Muestra los pedidos donde el total del pedido es mayor al límite de crédito del cliente.
CREATE VIEW Vista_Pedidos_SobreCredito AS
SELECT 
    P.Num_Pedido, P.Cliente, C.Empresa, 
    P.Importe, C.Limite_Credito
FROM Pedidos P
INNER JOIN Clientes C ON P.Cliente = C.Num_Cli
WHERE P.Importe > C.Limite_Credito;


--Lista los productos con más unidades vendidas en total.
CREATE VIEW Vista_Productos_Mas_Vendidos AS
SELECT 
    P.Producto, PR.Descripcion, PR.Precio, 
    SUM(P.Cantidad) AS Total_Vendido, 
    PR.Stock AS Stock_Disponible
FROM Pedidos P
INNER JOIN Productos PR ON P.Fab = PR.Id_fab AND P.Producto = PR.Id_producto
GROUP BY P.Producto, PR.Descripcion, PR.Precio, PR.Stock
ORDER BY Total_Vendido DESC;


