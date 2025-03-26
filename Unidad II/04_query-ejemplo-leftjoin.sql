use Northwind

select * from product_new

drop table product_new


--crear una tabla apartir de una consulta 
select p.ProductID, p.ProductName, [cu].CompanyName , 
c.CategoryName, od.UnitPrice ,
p.Discontinued, GETDATE() as 'Inserted_date'
into product_new
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID

--crea la tabla con solo la estructura --este se usa masss 
select top 0 p.ProductID, p.ProductName, [cu].CompanyName , 
c.CategoryName, od.UnitPrice ,
p.Discontinued, GETDATE() as 'Inserted_date'
into product_new
from Products as p
inner join Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID

--Con alias 
select top 0 0 as [productbk], p.ProductID , p.ProductName as [producto], [cu].CompanyName , 
c.CategoryName as [Customer], od.UnitPrice ,
p.Discontinued, GETDATE() as 'Inserted_date'
into product_new
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID



--carga full con datos 
insert into product_new
select p.ProductID, p.ProductName, [cu].CompanyName , 
c.CategoryName, od.UnitPrice ,
p.Discontinued, GETDATE() as fecha 
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID

select * from product_new

alter table product_new
add constraint pk_product_new 
primary key (productbk) 



--Crear la tabla mediante consulta y se agrega el campo                   sin bk pura estructura 
drop table product_new

select top 0 p.ProductID , p.ProductName as [producto]
, [cu].CompanyName  as 'Custumer', 
c.CategoryName as [Customer], od.UnitPrice ,
p.Discontinued, GETDATE() as 'Inserted_date'
into product_new
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID

alter table product_new
add productbk int not null identity (1,1)

alter table product_new 
add constraint pk_product_new
primary key (productbk)
Go 

--Carga full 
select * from product_new

insert into product_new (ProductID,producto,Custumer,
Customer,UnitPrice,Discontinued, inserted_date)
select  p.ProductID , p.ProductName as [producto], [cu].CompanyName , 
c.CategoryName as [Customer], od.UnitPrice ,
p.Discontinued, GETDATE() as 'Inserted_date'
from Products as p
inner join Categories as c
on p.CategoryID = c.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
inner join Customers as cu 
on cu.CustomerID = o.CustomerID

drop table product_new

select pn.ProductID, pn.Producto, pn.Customer, pn.Customer, pn.UnitPrice, pn.Discontinued, pn.Inserted_date,
p.ProductID, p.ProductName
from Products as p
inner join product_new as PN
on p.ProductID = pn.ProductID
where ProductName = 'elote feliz'

select pn.ProductID, pn.Producto, pn.Customer, pn.Customer, pn.UnitPrice, pn.Discontinued, pn.Inserted_date,
p.ProductID, p.ProductName
from Products as p
left join product_new as pn
on p.ProductID = pn.ProductID
where p.ProductID is not null

-- Carga delta 

insert into product_new (ProductID,producto,Customer,
Customer,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join product_new as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null



select * from Products


select top 10*
into products2
from Products

select * from products2
select * from Products

--va a tener 10 consultas pero como es inner join solo van aparecer las que coinciden 
select *
from Products as p1 
inner join Products as p2 
on p1.ProductID = p2.ProductID


select *p
from Products as p1 
left join products2 as p2 
on p1.ProductID = p2.ProductID

select *
from Products as p1 
right join products2 as p2 
on p1.ProductID = p2.ProductID


