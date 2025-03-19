--Examen 

--1. clientes con limite de credito mayor a 5000 y sus representantes 

select c.Limite_Credito, r.Nombre as 'Representante' 
from Clientes as c 
inner join Representantes as r
on c.Rep_Cli = r.Num_Empl
where Limite_Credito > 5000

--2. Pedidos con cantidad mayor a 100 o importe mayor a 5000, con detalles de cliente 
select  p.Cantidad, p.Importe, c.Num_Cli, c.Empresa
from Pedidos as p 
inner join Clientes as c 
on p.Cliente = c.Rep_Cli
where Cantidad >100 and Importe > 5000
Group by p.Cantidad, p.Importe, c.Num_Cli, c.Empresa


--3. Oficinas en la region 'este' o 'este', con detalles de su jefe
--(cuidad y nombre del jefe)
select * from Oficinas

select r.Nombre as 'Nombre jefe', o.Ciudad as 'Ciudad' 
from Oficinas as o 
inner join Representantes as r 
on o.Jef = r.Jefe
where Region = 'Este' or Region= 'Oeste' 



--4. Clientes en las ciudades 'Navarra', Castellon, 'Daimiel, con detalles de representante (Empresa y nombre)
select * from Representantes

select r.Nombre, c.Empresa
from Clientes as c 
inner join Representantes as r 
on c.Rep_Cli = r.Num_Empl
inner join Oficinas as o
on o.Jef = r.Jefe
where o.Ciudad in ('Navarra','Castellon', 'Daimiel')

--5 
--6 Select * from Clientes as c 
select p.Cliente, r.Nombre
from Clientes as c 
inner join Representantes as r 
on c.Rep_Cli = r.Num_Empl
inner join Pedidos as p 
on p.Rep = r.Num_Empl
where p.Cantidad >3
