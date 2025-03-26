# MongoDB Crud 

## Crear una base de datos 
**Solo se crea si contiene por lo menos una colecccion**

```json
use basededatos 
```

## Crear una coleccion 

use bd1
db.createCollection('Empleado')

## Mostrar colecciones

`show collections `

## Insercion de un docuemnto 
db.Empleado.insertOne(
{


    nombre:'Soyla',
    apellido:'Vaca',
    edad:32,
    ciudad: 'San Miguel de las piedras'
    }
)

