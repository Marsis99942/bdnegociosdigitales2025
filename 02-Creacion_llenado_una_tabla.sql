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

-- tabla productos 
create table producto1(
productoid int not null,
nombreProducto varchar (20) not null,
descripcion varchar (80) null,
precio decimal (10,2) not null,
existencia int not null,
categoriaid int null,
constraint pk_producto1
primary key (productoid),
constraint unico_descripcion
unique (nombreProducto),
constraint chk_precio 
check (precio>0.0 and precio<+1000),
constraint chk_existencia
check(existencia>0 and existencia<=200),
constraint fk_categoria_producto1
foreign key (categoriaid)
references categoria(categoriaid)

select*from categoria 

insert into producto1
values (1, 'Miguel','Dulce sano para la lombriz', 34.5, 45,5);

insert into producto1
values (2, 'tupsi pop','Dulce re-sano para la lombriz', 1000, 45,5);


insert into producto1
values (3, 'Plancha','plancha facil el suit', 1000, 45,5);

select*from producto1
where categoriaid=5

select*from categoria

create table cliente(
clienteid int not null identity (1,1)
