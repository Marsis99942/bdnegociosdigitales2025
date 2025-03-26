--Funciones de cadena 

--La funciones de cadena permiten manipular tipos de datos 
--como varchar, nvarchar, char , nchar 

--Funcion Len -> Devuelve la longitud de una cadena 

--Declaracion de un variable

--Transact lenguaje de sql server 
DECLARE @numero int;
SET @numero = 10; 
print @numero


DECLARE @Texto varchar(50) = 'Hola, Mundo!'

--Obtener el tamaño de la cadena almacenada en la variable Texto 
select len (@Texto) as [Longitud]

--------------------------------------------------------------
--Obtener el tamaño de la cadena almacenada en la variable Texto
select len(@texto) as [Longitud]--muestra el tamaño de texto
select RIGHT(@texto, 6)as Final

--LEFT eXtraen un numero especifico de caracteres desde el inicio de la cadena
select LEFT(@texto, 4)as Inicio

--RIGHT extrae un determinado nuemro de caracteres del final de la cadena
select RIGHT(@texto, 6)as Final

--SUBSTRING -> Extrae una parte de la cadena donde el primer parametro es la posicion inicial
-- y el tercer parametro el recorrido
select SUBSTRING (@texto, 7 ,5)

--FUNCION REPLACE -> remplaza una subcadena por otra
--(Cadena, cadena a remplazar, nuevo remplazo)
select REPLACE (@Texto, 'Mundo', 'Amigo')

--CHAR-INDEX 
select CHARINDEX ('Hola' , @Texto2)

--UPPERR ->Convierte una cadena en mayuscula 
select Upper(@Texto2) as Mayusculas
DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';
select Concat 
       (LEFT(@texto2,5),
       ' ',
       UPPER (SUBSTRING(@Texto2, 7, 5)), 
       RIGHT(@texto2, 1)) as Textonuevo

Update Customers 
set  CompanyName = Upper(CompanyName)
where country in ('Mexico', 'Germany')
select * from Customers

-- Trim -> Quita espacios en blanco de una cadena
SELECT TRIM( '     test    ') AS Result;

DECLARE @Texto2 varchar(50) = '   Hola,Mundo!     ';
SELECT LTRIM(@Texto2) AS Result;

SELECT LTRIM('     Five spaces are at the beginning of this string.');
SELECT TRIM('  Five spaces are at the beginning of this string.       ');

select companyname, len(CompanyName) as 'Numero de Caracteres',
LEFT(CompanyName, 4) as Inicio, 
RIGHT(CompanyName, 6) as Final, 
SUBSTRING(CompanyName,7,4) as 'SubCadena'
from Customers
GO





