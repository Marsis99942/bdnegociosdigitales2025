# Ejercicio de Pedidos con Store Procedure 

- Realizar un pedido 
- validar que el pedido no exista 
- validar que el cliente, el empleado y producto exista 
- validar que la cantidad a vender tenga suficiente stock 
- Insertar el pedido y calcular el importe (multiplicando el precio del 
- producto por la cantidad vendida)
- Actualizar el stock del producto ( restando el stock menos la cantidad 
- vendida)	

``` sql 

create or alter proc spu_pedido
@npedido int,
@cliente int,
@rep int,
@fab char(3),
@prod char(5),
@cantidad int
As
begin
	if exists(select 1 from Pedidos where Num_Pedido = @npedido)
	begin
		print 'El pedido ya existe'
		return;
	end

	if not exists(select 1 from Clientes where Num_Cli = @cliente) or
	   not exists(select 1 from Representantes where Num_Empl = @rep) or
	   not exists(select 1 from Productos where Id_fab = @fab and Id_producto = @prod)
	begin
		print 'Los datos no son validos'
		return;
	end

	if @cantidad <=0
	begin
		print('La cantidad no puede ser 0 o negativo')
		return;
	end

	declare @stockValido int
	select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @prod

	if @cantidad > @stockValido
	begin
		print'No hay suficiente stock'
		return;
	end

	declare @precio money
	declare @importe money
	select @precio = Precio from Productos where  Id_fab = @fab and Id_producto = @prod
	set @importe = @cantidad * @precio

	begin try
	insert into Pedidos
	values(@npedido, GETDATE(), @cliente, @rep, @fab, @prod, @cantidad, @importe)

	update Productos
	set Stock = Stock - @cantidad
	where  Id_fab = @fab and Id_producto = @prod

	end try
	begin catch
	print 'Error a la actualizar datos'
	return;
	end catch
end;
GO

exec spu_realizar_pedido @numPedido = 112961, @cliente = 2000, 
@repre = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @numPedido = 112961, @cliente = 2117, 
@repre = 111, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @numPedido = 113071, @cliente = 2117, 
@repre = 101, @fab = 'ACI',
@producto = '4100X', @cantidad = 20

select * from Productos
where Id_fab = 'ACI'and Id_producto = '4100x'


``` sql
```