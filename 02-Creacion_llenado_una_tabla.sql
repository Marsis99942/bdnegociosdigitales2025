#creacion de la base de datos tienda1
#crea la base de datos tienda1
create database tienda1;

#utilizar una base de datos 
use tienda1;



#crear la tabla categoria 
create table categoria(
categoriaid int not null,
nombreCatego varchar(20) not null, 
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre 
unique(nombreCatego)
);

#SQL-LMD
#AGREGAR REGISTROS A LA TABLA CATEGORIA

insert into categoria 
values(1, 'Caranes frias');

insert into categoria(categoriaid,nombreCatego)
values (2, 'linea Blanca');

insert into categoria(nombreCatego, categoriaid)
values ('Vinos y licores', 3);

insert into categoria 
values (4, 'ropa'),
       (5, 'Dulces'),
       (6, 'Lacteos');
       
insert into categoria(nombreCatego, categoriaid)
values ('Panaderia', 7),
       ('Zapateria', 8),
       ('Jugueteria', 9);

select * from categoria
order by categoriaid asc;
