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