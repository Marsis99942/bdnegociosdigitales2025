# Practica 1: Base de Datos, colecciones e inserts

1. Conectarnos con mongosh a MongoDB
1. Crear una base de datos llamada curso
1. Comprobar que la base de datos no existe
1. Crear una coleccion que se llame facturas y mostrarla

``` json
 db.createCollection('facturas')
```
show collections

5. Insertar un documento con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 10 |
| Ciente | Frutas Ramirez |
| Total | 223 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_Factura | 20 |
| Ciente | Ferreteria Juan |
| Total | 140 |

```json
db.Facturas.insertOne(
{


    Cod_factura: 10,
    cliente:'Frutas Ramirez',
    total: 223
    }
)


db.Facturas.find({})


db.Facturas.insertOne(
{
    Cod_factura: 20,
    cliente:'Ferreteria Juan',
    total: 140
    }
)

![alt text](image.png)


```
6. Crear una nueva colección pero usando directamente el insertOne.       coleccion: productos
   insertar un documento en la colección productos con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 1 |
| Nombre | Tornillo x 1" |
| Precio | 2 |

```json 
db.Productos.insertOne(
{

    Cod_producto: 1,
    Nombre:'Tornillo x 1',
    Precio:2,
    
    }
)

![alt text](image-1.png)

```
7. Crear un nuevo documento de producto que contenga un array. con los siguientes datos:

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 2 |
| Nombre | Martillo |
| Precio | 20 |
| Unidades | 50 |
| Fabricantes | fab1, fab2, fab3,fab4 |

```json
db.Productos.insertOne(
    {

    Cod_producto: 2, 
    Nombre:'Martillo',
    Precio: 20,
    Unidades: 50,
    Fabricantes: ['fab1', 'fab2', 'Fab3', 'fab4'],
    }
)
```

![alt text](image-2.png)


8. Borrar la colección Facturas y comprobar que se borro
```json
db.Facturas.drop()
```
![alt text](image-3.png)

9. Insertar un documento en una colección denominada **fabricantes** array```
   para probar los subdocumentos y la clave _id personalizada

| Codigo   | Valor   |
|-------------|-------------|
| id | 1 |
| Nombre | fab1 |
| Localidad | ciudad: buenos aires, pais: argentina, Calle: Calle pez 27,cod_postal:2900 |

```json
db.fabricantes.insertOne({
    id: 1, 
    nombre:'fab 1',
    Localidad:{
        ciudad:'buenos aires',
        pais: 'argentina', 
        calle: 'Calle pez 27', 
        cod_postal:2900
    }
})
```
![alt text](image-4.png)



10. Realizar una inserción de varios documentos en a colección
    productos

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 3 |
| Nombre | Alicates |
| Precio | 10 |
| Unidades | 25 |
| Fabricantes | fab1, fab2, fab5 |

| Codigo   | Valor   |
|-------------|-------------|
| Cod_producto | 4 |
| Nombre | Arandela |
| Precio | 1 |
| Unidades | 500 |
| Fabricantes | fab2, fab3, fab4 |


```json
db.Productos.insertMany(
    [
    {
        cod_producto: 3,
    Nombre: "Alicates",
    Precio: 10,
    Unidades: 25,
    Fabricantes:[
        'fab1', 'fab2','fab5'
    ]
    },
    {
        cod_producto: 4,
    Nombre: 'Arandela',
    Precio: 1,
    Unidades: 500,
    Fabricantes:[
        'fab2', 'fab3','fab5'
    ]
        }
    ]
)
```
![alt text](image-5.png)

```