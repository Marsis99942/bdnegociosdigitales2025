# Practica 3. Updates y Deletes

1. Cambiar el salario del empleado Imogene Nolan. Se le asigna 8000.
db.empleado.find({Imogene Nolan})

```json
db.empleados.updateOne(
  { nombre: "Imogene", apellidos: "Nolan" },
  { $set: { salario: 8000 } }
)
```
![alt text](image-17.png)

2. Cambiar "Belgium" por "Bélgica" en los empleados (debe haber dos).
```json
db.empleados.updateMany(
  { pais: "Belgium" },
  { $set: { pais: "Bélgica" } }
)
```
![alt text](image-18.png)

4. Reemplazar el empleado Omar Gentry por el siguiente documento:

```json
{
"nombre": "Omar",
"apellidos": "Gentry",
"correo": "sin correo",
"direccion": "Sin calle",
"region": "Sin region",
"pais": "Sin pais",
"empresa": "Sin empresa",
"ventas": 0,
"salario": 0,
"departamentos": "Este empleado ha sido anulado"
}```

```json
db.empleados.replaceOne(
  { nombre: "Omar", apellidos: "Gentry" },
  {
    "nombre": "Omar",
    "apellidos": "Gentry",
    "correo": "sin correo",
    "direccion": "Sin calle",
    "region": "Sin region",
    "pais": "Sin pais",
    "empresa": "Sin empresa",
    "ventas": 0,
    "salario": 0,
    "departamentos": "Este empleado ha sido anulado"
  }
)

```
![alt text](image-19.png)

5. Con un find comprobar que el empleado ha sido modificado
```json
db.empleados.find({ nombre: "Omar", apellidos: "Gentry" })
```
![alt text](image-20.png)

6. Borrar todos los empleados que ganen mas de 8500. Nota: deben ser borrados 3 documentos
```json
db.empleados.deleteMany({ salario: { $gt: 8500 } })
```
![alt text](image-21.png)

7. Visualizar con una expresión regular todos los empleados con apellidos que comiencen con "R"
```json
db.empleados.find({ apellidos: { $regex: "^R" } })
```
![alt text](image-22.png)

8. Buscar todas las regiones que contenga un "V". Hacerlo con el operador $regex y que no distinga mayúsculas y minúsculas. Deben salir 2.
```json
db.empleados.find({ region: { $regex: "v", $options: "i" } })

```
![alt text](image-23.png)

9. Visualizar los apellidos de los empleados ordenados por el propio apellido.
```json
db.empleados.find(
  {},
  { _id: 0, apellidos: 1 }
).sort({ apellidos: 1 })

```
![alt text](image-24.png)

10. Indicar el número de empleados que trabajan en Google.
```json
db.empleados.countDocuments({ empresa: "Google" })
```
![alt text](image-25.png)

11. Borrar la colección empleados y la base de datos
```json
db.empleados.drop()

use curso
db.dropDatabase()
```
![alt text](image-26.png)