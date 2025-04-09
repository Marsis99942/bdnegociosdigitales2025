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

## Insercion de un documento mas conplejo con array

``` json 
db.empleado.insertOne(
{
nombre: 'ivan',
apellido: 'Baltazar',
apellido2: 'Rodriguez',
aficiones:['Cerveza', 'Canabis', 'Crico', 'Mentir']
}
)
```

**Eliminar una coleccion**
```json
db.coleccion.drop()
```

_Ejemplo_
```json 
db.coleccion.drop()
```

## Insercion de documentos mas complejos con anidados, arrays y ID 

```json
db.alumnos.insertOne(
{
    nombre:'Jose Luis',
    apellido1: 'Herrera',
    apellido2: 'Gallardo',
    edad: 41,
    estudios:[
        'Ingenieria en sistemas computacionales',
    ],
    experiencia: {
        lenguaje:'SQL',
        sgb: 'SqlServer',
        anios_experiencia: 20 
    }
}
)
```
```json

db.alumnos.insertOne({
    _id: 3, 
    nombre:'Sergio',
    apellido: 'Ramos',
    equipo:'Monterrey',
    aficiones: ['Dinero', 'Hombres', 'Fiesta'],
    talentos:{
        futbol:true,
        bañarse: false
    }
})
```
## Insertar Multiples Documentos 
```json 
db.alumnos.insertMany(
[
    {
        _id: 12, 
        nombre: 'Osvaldo',
        apellido: 'Venado',
        edad: 20,
        descripcion: 'Es un quejombroso'
    },
    {
        nombre: 'Maritza',
        apellido: 'Reachicken',
        edad: 20, 
        habilidades:[ 'Ser Vibora', 'Ilusionar', 'Caguamear' ], 
        direccion : {
            calle: 'Del infierno',
            numero: 666
        },
        esposos:[
            {
                nombre:'Joshua',
                edad: '20',
                pension: -34,
                hijos:['Ivan', 'Jose']
            },
            {
                nombre:'Leo',
                edad: '15',
                pension: 70, 
                complaciente:true,
            }
        ]
    } 
  ]
)

```

## Busquedas, Condiciones simples de igualdad metodo find ()

1. Seleccionar todos los documentos de la coleccion libros
```json 
db.Libros.find({})
```

2. Seleccionar todos los documentos que sean de la editorial biblio
 ```json 
db.Libros.find({editorial:'Biblio'})
 ```

3. Mostrar todos los documentos que el precio sea 25 
 ```json 
db.Libros.find({Precio: 25})
 ```
4. Seleccionar todos los documentos donde el titulo sea `json para todos`
 ```json 
db.Libros.find({'titulo':'JSON para todos'})
```

## Operadores de Comparacion 

[Operadores de Comparacion] (https://www.mongodb.com/docs/manual/reference/operator/query/)

--rutas relativas 
![Operadores de comparacion](../img/operadores-Relacionales.png)

1. Mostrar todos los documentos, donde el precio sea mayor a 25 
```json
db.Libros.find({precio:{$gt:25}})
```
2. Mostrar los documentos donde el precio sea 25 
```json
db.Libros.find({precio:{$eq:25}})
```
3. Mostrar los documentos cuya cantidad sea menor a 5 
```json
db.Libros.find({cantidad:{$lt:5}})
```

4. Mostrar los documentos que pertenecen a la editorial  biblio o planeta

```json
db.Libros.find({editorial:{$in:['planeta',"Biblio"]}})
```

5. Mostrar todos los documentos de libros que causen 20 a 25 
```json
db.Libros.find(
{
    precio:{
        $in:[20,25]
        }
        }
        )
```
6. Recuperar todos los documentos que no cuesten 20 0 25 

```json
db.Libros.find(
{
    precio:{
        $nin:[20,25]
        }
        }
        )
```

## Instruccion findOne 

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion)

```json
db.libros.findOne(
{
    precio:{
        $in:[20,25]
        }
        }
        )
```

## Operadores Logicos 

[Operadores Logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

## Operador and 

--Dos posibles opciones 

1. La simple, mediante condiciones separadas por comas 
-db.libros.find({condicion1, condicion2}) ->Con esto asume que es and 
1. usando el operador $and 
{ $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
- db.libros.find({$and:[{condicion1}, {condicion2}]})


1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15 

db.libros.find(
    {
        precio:{$gt:25},
        cantidad:{$lt:15}
    }
)


db.Libros.find(
    {
        $and:[
            {precio:{$gt:25}},
            {cantidad:{$lt:15}}
        ]
    }
)


### Operador or ($or)
-Mostrar todos aquellos libros que cuesten mas de 25 o cuya cantidad se ainferior a 15 

```json
db.libros.find(
{
    $or:[
        {
            precio:{$gt:25}

        },
        {
            cantidad:{$lt:15}
        }

    ]
    }
        )
```

### Ejemplo de AND y OR Combinados 

-Mostrar los libros de la editorial Biblio con precio mayor a 40 o libros de la editorial 
planeta con precio mayor a 30 

```json
db.libros.find(
{
    $and: [
        { $or: [ { editorial: 'Biblio'} , { precio : { $gt: 40 } } ] },
        { $or: [ { editorial: { $eq:'Planeta'}}, {precio:{$gt:20}}  ] }
    ]
   } 
)
```



### Proyeccion (Ver ciertas columnas )

**Sintaxis**

db.coleccion.find(filtro,columnas)

1. Seleccionar todos los libros, solo mostrando el titulo
db.libros.find({}, {titulo: 1})
db.libros.find({}, {titulo: 1, _id:0})
db.libros.find(
    {editorial:'Planeta'},
    {_id: 0, titulo: 1, editorial:1, precio:1}
)

### Operador exists(Permite saber si un campo se encuentra o no en un documento)
{ field: { $exists: <boolean> } }

db.libros.find({editorial:{$exist:true}})


### Operador Type (Permite solicitar a MonfoDB si un campo correspondiente a un tipo )

[Operador type: https://www.mongodb.com/docs/manual/reference/operator/query/type/]

--Mostrar todos los documentos donde el precio sea de tipo double o entero o cualquier otro tipo de dato

db.libros.find(
    {
        precio:{$type:1}
    }
)

db.libros.find(
    {
        precio:{$type:16}
    }
)

db.libros.find(
    {
        precio:{$type:"int"}
    }
)

db.libros.insertMany(

    [
        {
        _id:12,
        titulo:'IA',
        editorial: 'Terra',
        precio: 125, 
        cantidad: 20
        },
{
                    _id:13,
            titulo:'Pyton para todos',
            editorial: 2001, 
            precio: 200, 
            cantidad: 30 
        }
    ]
)

--seleccionar todos los documentos de libros donde los valores de la editorial sean strings

db.libros.find({editorial:{$type:2}})

db.libros.find({editorial:{$type:'string'}})

db.libros.find({editorial:{$type:16}})

db.libros.find({editorial:{$type:"int"}})




# Modificando Documentos 
## Comandos Importantes 

1. UpdateOne -> Modifica un solo documento
2. UpdateMany -> Modificar multiples documentos
3. replaceOne -> Sustituir el contenido completo de un dom=ceumento 

Tiene el siguiente formato 

```json
db.collection.updateOne(
)
```



db.libros.insertOne(
     {
        _id: 10,
        titulo: 'Mongo en negocios digitales',
        editorial: 'Terra',
        precio: 125 
    }
)









[Operadores update](https://www.mongodb.com/docs/manual/reference/operator/update/)

***Operador $set**

1. modificar un documento 
```json
db.libros.updateOne({titulo:'Pyton para todos'}, {$set:{titulo:'Java para todos'}})
```

```json
db.libros.insertOne
```
db.libros.find({_id:10})

--Modificar el documento con id 10, estableciendo el precio en 100 yla cantidad en 50
```json
db.libros.updateOne(
    {
        _id:10
    },
    {
        $set:{precio:100, cantidad:50}
    }
)
```
--Utilizando el updateMany, modificar todos los libros donde el precio sea mayor a 100 cambiarlo por 150 

```json
db.libros.updateMany(
  
  { precio: { $gt: 100 } },
{
    $set: {precio:150}
}
 )
```

### Operadores $inc y $mul 

--Incrementar todos los precios de los libros en 5 
```json
db.libros.updateMany(
{editorial: 'Terra'},
{
    $inc:{precio:5}
})
```
--Multiplicar todos los documentos o todos los libros donde la cantidad sea mayor a 20 en su cantidad por 2 ($mul)

db.libros.find({})

```json
db.libros.updateMany(
   { 
      cantidad: { $gt: 20 } 
   },
   { 
      $mul: { cantidad: 2 } 
   }
)
```

db.libros.find({_id:{$in:[1,7,10,13]}})

--Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20 

```json
db.libros.updateMany(
   { 
      precio : { $gt: 20 }
   },
   { 
      $mul: { cantidad: 2, precio: 2 } 
   }
)
```

### Reemplazar doumentos (replaceOne)

1. Actualizar todo el documento del id 2 por el titulo: De la Tierra a la Luna, autor: Julio Verne, editorial: Terra, precio: 100
json
db.libros.replaceOne({_id:2}, 
{
    titulo: 'De la Tierra a la Luna',
    autor: 'Julio Verne',
    editorial: 'Terra',
    precio: 100
})

### Borrar Documentos
- Elimina un solo documento deleteOne
- Elimina multiples documentos deleteMany

1. Eliminar el documento con el id 2
json
db.libros.deleteOne({_id:2})


2. Eliminar todos los libros donde la cantidad es mayor a 150 
json
db.libros.deleteMany({cantidad: {$gt:150}})


### Expresiones Regulares

1. Seleccionar todos los libros que contengan una (t)
json
db.libros.find({titulo:/t/})


2. Seleccionar todos los libros que en el titulo contenga la palabra (json)
json
db.libros.find({titulo:/json/})


3. Seleccionar todos los libros que en el titulo terminen con (tos)
json
db.libros.find({titulo:/tos$/})


4. Seleccionar todos los titulos que comiences con (j)
json
db.libros.find({titulo:/^J/})


## Operador $regex
[Operadores Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)
```json
--Seleccionar los libros que contengan la palabra "para" en el titilo 

db.libros.find(
{
 titulo: {
           $regex:'para'
 }
}
)

db.libros.find(
    {
        titulo:{
            $regex:/para/
        }
    }
)

--seleccionar todos los titulos que contengan json 

db.libros.find(
{
 titulo: {
           $regex:'JSON'
 }
}
)

-Distingir entre mayusculas y minusculas 
db.libros.find(
{
 titulo: {
           $regex:/JSON/i
 }
}
)
```json
[ <field>:{$regex: /pattern/, $options:
'<options>'}]

db.libros.find(
{
 titulo: {
           $regex:/JSON/, $options:i
 }
}
)
```
```json
db.libros.find(
{
 titulo: {
           $regex:/^j/, $options:i
 }
}
)
```

-seleccionar todos los documentos de libros donde el titulo termine con "es" y no distinga entre mayusculas y minusculas. 

```json
db.libros.find(
{
 titulo: {
           $regex:/es$/, $options:'i'
 }
}
)
```

### Método sort (Ordenar Documentos)

-- Ordenar los libros de manera ascendente por el 
precio 

```json
db.libros.find(
    {},{
        _id:0,
        titulo:1,
        precio:1
    }
).sort({precio:1})
```
--ordenar los numeros de manera descendente por el precio 

```json
db.libros.find(
    {},{
        _id:0,
        titulo:1,
        precio:1
    }
).sort({precio:1})
```

--Ordenar los libros de manera ascendente por la editorial y de manera descendente por el precio, mostrando el titulo, el precio y la editorial.

```json
db.libros.find(
    {},{
        _id:0,
        titulo:1,
        precio:1
    }
).sort({precio:1})
```
```json
db.libros.find(
    {},
    {
        _id:0, 
        precio:1,
        editorial:1

    }
) 
.sort(
{
    editorial:1,
    precio:-1
})

db.libros.find({}).size()

```json
db.libros.find(
{
 titulo: {
           $regex:/^j/, $options:'i'
 }
}
).size()
```
--Buscar todos los libros mostrando los dos primeros
```json
db.libros.find({}).limit(2)

--skip(saltar)

db.libros.find({}).skip()


### Otros métodos (skip, limit, size)

### Borrar colecciones y base de datos

db.libros.drop()






   


