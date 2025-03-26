# Stores Procedures

``` sql
--Store Procedure

--Crear un store procedure para seleccionar todos los clientes 

create or alter procedure spu_mostrar_clientes
as 
begin 
    select * from Customers;
end;
GO

--Ejecutar un store en transact 

exec spu_mostrar_clientes 

--crear un sp que muestre los clientes por pais
--Parametros de entrada 


--Priemro se ejecuta esto 
Create or alter proc  spu_customersporpais
--Parametros 
@pais nvarchar(15),
@pais2  nvarchar(15)
AS
begin 
   select * from customers 
   where country in (@pais, @pais2);
end;




--Despues se ejecuta esto 
--Ejecuta un store procedure 
DECLARE @p1 nvarchar(15) = 'mexico'
DECLARE @p2 nvarchar(15) = 'germany'

exec spu_customersporpais @p1, @p2;
go

--Generar un reporte que permita visualizar los datos de compra de un 
--determinado cliente, en un rango de fechas, mostrando, 
--el monto total de compras por producto, mediante un sp. 

use northwind 
GO

select * from vistaordenescompra

--Parametros 
Create  or alter proc spu_InformeVentasClientes
@nombre nvarchar(40)= 'Berglunds snabbk�p', --Parametro de entrada con valor por default 
@fechaInicial DateTime, 
@fechaFinal DateTime
AS
begin 
     select [Nombre del Producto], [Nombre del Cliente], sum (importe) as [Monto Total]
     from vistaordenescompra
     where [Nombre del Cliente] = @nombre 
     and [Fecha de Orden] between @fechaInicial and @fechaFinal 
     group by [Nombre del Producto] , [Nombre del Cliente] 
end;
GO

select * from Customers 

--formato de fecha 
select getdate()

--Ejecucion de un store con parametros de entrada 
exec spu_InformeVentasClientes 
                                  'Berglunds snabbk�p', 
								  '1996-07-04','1997-01-01'


--Ejecucion de un store procedure con parametros en diferente posicion 

exec spu_InformeVentasClientes @fechaFinal = '1997-01-01',
                                @nombre= 'Berglunds snabbk�p',
                                 @fechaInicial= '1996-07-04';
--Ejecucion de un store procedure con parametros de entrada con un campo que tiene un 
--valor por default 
exec spu_InformeVentasClientes @fechaFinal = '1997-01-01',
                                 @fechaInicial= '1996-07-04';
GO
--Store procedure con parametros de salida 

create or alter proc spu_obtener_numero_clientes 
@customerid nchar(5), --parametro de entrada
@totalCustomers int output --parametro salida 
as
begin 
select @totalCustomers=count(*) from Customers
where CustomerID = @customerid;
end;
GO

declare @numero int;
exec  spu_obtener_numero_clientes @customerid= 'ANATR'
                                  @totalCustomers= @numero output;
print @numero;
go

--Crear un sp que permita saber si un alumno aprobo o reprobo 

create or alter proc spu_comparar_calificacion 
@calif decimal(10,2) --parametro de entrada 
as 
begin 
   if @calif >0 and @calif<=10
   begin 
         if @calif>=8
         print 'La calificacion es aprovatoria' 
         else 
         print ' La calificaccion es reprobatoria'  
  end
  else 
       print 'Calificacion no valida'
  end ;
  GO


  exec spu_comparar_calificacion @calif =11
  go

  --Crear un sp que permita verificar si un cliente existe antes de devolver su informacion 

  create or alter proc spu_obtener_cliente_siexiste
  @numeroCliente nchar(5)
  as 
  begin
      if exists (select 1 from customers where CustomerID= @numeroCliente)
	  select * from Customers where CustomerID = @numeroCliente;
	  else 
	    print 'El cliente no existe'
	end; 	
  go 

  exec spu_obtener_cliente_siexiste @numeroCliente= 'Moises'

  --Crear un store procedure que permita crear un cliente, 
  --pero se debe verificar que no exista 

 //* Create or alter  spu_crear_cliente
    @numeroCliente NVARCHAR(5),
    @nombre NVARCHAR(100),
    @contacto NVARCHAR(100),
    @ciudad NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si el cliente ya existe
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @numeroCliente)
    BEGIN
        SELECT 'Error: El cliente ya existe' AS Mensaje;
    END
    ELSE
    BEGIN
        -- Insertar el nuevo cliente
        INSERT INTO Customers (CustomerID, CompanyName, ContactName, City)
        VALUES (@numeroCliente, @nombre, @contacto, @ciudad);

        -- Confirmaci�n de creaci�n
        SELECT 'Cliente creado exitosamente' AS Mensaje;
    END
END;
GO
*//




create or alter proc spu_agregar_cliente
  @id nvarchar(5),
  @nombre nvarchar(40),
  @city nvarchar(15) = 'San Miguel'
as
begin 
    if exists (select 1 from Customers where CustomerID = @id)
    begin 
   print ('El cliente ya existe')
   return  1
end 

insert into Customers( customerid, companyname)
values (@id, @nombre);
print ('Cliente insertado exitosamente');
return 0;
end 
go 

exec spu_agregar_cliente 'A1FKKI', 'Patito de Hule'
exec spu_agregar_cliente 'A1FKC', 'Mu�eca vieja'
select * from 


create or alter procedure spu_agregar_cliente_try_catch
@id nvarchar(5),
  @nombre nvarchar(40),
  @city nvarchar(15) = 'San Miguel'
as
begin 
    begin try 
    insert into Customers( customerid, companyname)
    values (@id, @nombre);
    print ('Cliente insertado exitosamente');
end try
begin catch 
    print ('El cliente ya existe')
	end catch 
	end;
	Go 

exec spu_agregar_cliente 'A1FKD','Mu�eca vieja'

--Manejo de ciclos en store procedures

--imprimir el numero de veces que indique el usuario 

create or alter proc spu_imprimir 
@numero int 
as 
begin 

     if @numero <=0 
	 print('El numero no puede ser 0 o negativo')
	 return 
	 end 

     declare @i int
	 SET @i = 1
	 while(@i<=@numero)
	 begin 
	    print concat ('Numero' + @i) 
		set @i = @i + 1
   end

end;
GO 
exec spu_imprimir 10



```