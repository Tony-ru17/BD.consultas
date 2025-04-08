-- ---------CICLOS-------------
/*1. Selecciona aquellos módulos que estén repetidos en más de un ciclo y
el número de veces que se repiten ordenados por nombre.*/
SELECT NOMBRE, COUNT(*) nºrepeticiones
FROM CICLOS_MODULO
GROUP BY NOMBRE
HAVING COUNT(*)>1
ORDER BY nombre;

/* RESULTADO
+----------+-----------------+
| NOMBRE   | nºrepeticiones  |
+----------+-----------------+
| Inglés   |               2 |
| Tutoría  |               2 |
+----------+-----------------+

 */

/*2. Obtén el número de alumnos matriculados en cada curso (usa join si
hay más de una tabla) y, además, el nombre de su tutor. Ten en cuenta
que si el curso no tiene tutor, también deberá salir, ordena por curso.*/


SELECT curso.ABREVIATURA, COUNT(*) AS 'Número de Alumnos', modulo.profesor AS 'Tutor'
FROM CICLOS_CURSO curso
         JOIN CICLOS_ALUMNO alumno ON alumno.CICLO = curso.ABREVIATURA
         LEFT JOIN CICLOS_MODULO modulo ON curso.ABREVIATURA = modulo.curso AND modulo.nombre = 'Tutoría'
GROUP BY curso.ABREVIATURA, modulo.profesor
ORDER BY curso.ABREVIATURA;


/* RESULTADO
+-------------+--------------------+------------------+
| ABREVIATURA | Número de Alumnos  | Tutor            |
+-------------+--------------------+------------------+
| 1DAMA       |                  9 | Ramón Galinsoga  |
| 1SMRA       |                  5 | NULL             |
| 2DAMA       |                  5 | Sandra Deltell   |
+-------------+--------------------+------------------+

 */


/*3. De cada departamento, muestra a su jefe y el nº de profesores que
tiene.*/

SELECT departamento.NOMBRE, departamento.JEFE, COUNT(*) 'Contador'
FROM CICLOS_DEPARTAMENTO departamento
         JOIN CICLOS_PROFESORES profesores ON departamento.NOMBRE=profesores.DEPARTAMENTO
GROUP BY departamento.NOMBRE,departamento.JEFE;

/* RESULTADO
+--------------+-------------------+----------+
| NOMBRE       | JEFE              | Contador |
+--------------+-------------------+----------+
| FOL          | Marga Martínez    |        3 |
| Informática  | Ricardo Lucas     |       29 |
| Inglés       | José Manuel Cano  |        3 |
+--------------+-------------------+----------+

 */

/*4. Muestra las notas del periodo 1 que faltan por introducir por alumno y
módulo.*/

SELECT CONCAT(alumno.NOMBRE, ' ', alumno.APELLIDOS) AS Alumno, modulo.nombre AS Modulo
FROM CICLOS_ALUMNO alumno
         JOIN CICLOS_CURSO curso ON alumno.CICLO = curso.ABREVIATURA
         JOIN CICLOS_MODULO modulo ON curso.ABREVIATURA = modulo.curso
         LEFT JOIN CICLOS_EVALUACION notas ON alumno.NIA = notas.ALUMNO AND modulo.codigo = notas.MODULO AND notas.EVALUACION = 1
WHERE notas.NOTA IS NULL
ORDER BY CONCAT(alumno.NOMBRE, ' ', alumno.APELLIDOS);


/* RESULTADO
+-----------------+------------------------+
| Alumno          | Modulo                 |
+-----------------+------------------------+
| Alan Turing     | Sistemas Informáticos  |
| Alan Turing     | Base de Datos          |
| Alan Turing     | FOL                    |
| Alan Turing     | LENM                   |
| Alan Turing     | Inglés                 |
| Alan Turing     | Tutoría                |
| Alan Turing     | Entornos de Desarrollo |
| Alan Turing     | Programación           |
| Ana Martínez    | AD                     |
| Ana Martínez    | DINT                   |
| Ana Martínez    | EIE                    |
| Ana Martínez    | Inglés                 |
| Ana Martínez    | PMUL                   |
| Ana Martínez    | PSER                   |
| Ana Martínez    | Tutoría                |
| Ana Martínez    | SGES                   |
| Bill Gates      | Inglés                 |
| Bill Gates      | Tutoría                |
| Bill Gates      | Entornos de Desarrollo |
| Bill Gates      | Programación           |
| Bill Gates      | Base de Datos          |
| Bill Gates      | Sistemas Informáticos  |
| Bill Gates      | FOL                    |
| Carlos López    | Tutoría                |
| Carlos López    | SGES                   |
| Carlos López    | AD                     |
| Carlos López    | DINT                   |
| Carlos López    | EIE                    |
| Carlos López    | Inglés                 |
| Carlos López    | PMUL                   |
| Carlos López    | PSER                   |
| Dennis Ritchie  | Entornos de Desarrollo |
| Dennis Ritchie  | Programación           |
| Dennis Ritchie  | Sistemas Informáticos  |
| Dennis Ritchie  | Base de Datos          |
| Dennis Ritchie  | FOL                    |
| Dennis Ritchie  | LENM                   |
| Dennis Ritchie  | Inglés                 |
| Dennis Ritchie  | Tutoría                |
| James Cameron   | Tutoría                |
| James Cameron   | Entornos de Desarrollo |
| James Cameron   | Programación           |
| James Cameron   | Base de Datos          |
| James Cameron   | Sistemas Informáticos  |
| James Cameron   | Inglés                 |
| James Cameron   | LENM                   |
| Jeff Bezos      | Inglés                 |
| Jeff Bezos      | Tutoría                |
| Jeff Bezos      | Entornos de Desarrollo |
| Jeff Bezos      | Programación           |
| Jeff Bezos      | Sistemas Informáticos  |
| Jeff Bezos      | Base de Datos          |
| Jeff Bezos      | FOL                    |
| Jeff Bezos      | LENM                   |
| Juan Pérez      | Inglés                 |
| Juan Pérez      | PMUL                   |
| Juan Pérez      | PSER                   |
| Juan Pérez      | Tutoría                |
| Juan Pérez      | SGES                   |
| Juan Pérez      | AD                     |
| Juan Pérez      | DINT                   |
| Juan Pérez      | EIE                    |
| Larry Page      | Programación           |
| Larry Page      | Base de Datos          |
| Larry Page      | Sistemas Informáticos  |
| Larry Page      | FOL                    |
| Larry Page      | LENM                   |
| Larry Page      | Tutoría                |
| Larry Page      | Entornos de Desarrollo |
| Luis Rodríguez  | EIE                    |
| Luis Rodríguez  | Inglés                 |
| Luis Rodríguez  | PMUL                   |
| Luis Rodríguez  | PSER                   |
| Luis Rodríguez  | Tutoría                |
| Luis Rodríguez  | SGES                   |
| Luis Rodríguez  | AD                     |
| Luis Rodríguez  | DINT                   |
| María García    | Tutoría                |
| María García    | SGES                   |
| María García    | AD                     |
| María García    | DINT                   |
| María García    | EIE                    |
| María García    | Inglés                 |
| María García    | PMUL                   |
| María García    | PSER                   |
| Mark Zuckerberg | FOL                    |
| Mark Zuckerberg | LENM                   |
| Mark Zuckerberg | Inglés                 |
| Mark Zuckerberg | Tutoría                |
| Mark Zuckerberg | Entornos de Desarrollo |
| Mark Zuckerberg | Programación           |
| Mark Zuckerberg | Sistemas Informáticos  |
| Mark Zuckerberg | Base de Datos          |
| Sergey Brin     | FOL                    |
| Sergey Brin     | LENM                   |
| Sergey Brin     | Inglés                 |
| Sergey Brin     | Tutoría                |
| Sergey Brin     | Entornos de Desarrollo |
| Sergey Brin     | Programación           |
| Sergey Brin     | Sistemas Informáticos  |
| Steve Jobs      | Programación           |
| Steve Jobs      | Base de Datos          |
| Steve Jobs      | Sistemas Informáticos  |
| Steve Jobs      | FOL                    |
| Steve Jobs      | Inglés                 |
| Steve Jobs      | LENM                   |
| Steve Jobs      | Tutoría                |
+-----------------+------------------------+

 */


-- -------CONCESIONARIO-----------
/*1. Visualiza las ventas de todos los concesionarios, incluso aquellos que
no hayan vendido ningún coche, ordenados por número de ventas de
forma descendente y por nombre de concesionario.*/


SELECT COUNT(*) 'Total coches vendidos', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_VENTAS ventas
         RIGHT JOIN CONCE_CONCESIONARIO conce ON ventas.CONCESIONARIO=conce.CIF
GROUP BY conce.CIF
ORDER BY `Total coches vendidos` DESC;

/* RESULTADO
+-----------------------+--------------------+
| Total coches vendidos | CONCESIONARIO      |
+-----------------------+--------------------+
|                     9 | Automóviles Alpe   |
|                     6 | Móvil Begar        |
|                     3 | Tot Turbo          |
|                     2 | Multi Car          |
|                     2 | BMW Villa de campo |
|                     2 | Motor Sport        |
|                     1 | Grant Turismo      |
|                     1 | Fercar             |
|                     1 | Todo motor         |
|                     1 | BMW Barna          |
|                     1 | 4 rodes            |
|                     1 | Tope Gama          |
+-----------------------+--------------------+

 */

/*2. Visualiza el número de coches vendidos, incluso para aquellos coches
que no hayan sido vendidos nunca ordenado descendentemente por el
total de coches y por el coche.*/

SELECT SUM(distribucion.CANTIDAD) 'Total coches vendidos', coche.NOMBRE AS Coche
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_COCHE coche ON distribucion.COCHE=coche.CODIGO
GROUP BY coche.CODIGO
ORDER BY `Total coches vendidos` DESC;

/* RESULTADO
+-----------------------+-----------------+
| Total coches vendidos | Coche           |
+-----------------------+-----------------+
|                    31 | Ibiza           |
|                    25 | RIO             |
|                    23 | CEED            |
|                    21 | AUDI A3         |
|                    12 | SPORTAGE        |
|                    11 | QASQAI          |
|                    11 | BMW Serie 3     |
|                    10 | BMW Serie 1     |
|                     8 | PULSAR          |
|                     7 | C5              |
|                     5 | BMW Serie 5     |
|                     3 | AUDI A5         |
|                  NULL | BMW Serie 7     |
|                  NULL | C4              |
|                  NULL | BMW Serie 4     |
|                  NULL | AUDI A6 QUATTRO |
+-----------------------+-----------------+

 */

/*3. Queremos saber el stock total de cada concesionario (es decir, la
cantidad total de coches distribuidos), incluso aquellos que no tengan
Stock ordenado de mayor a menor stock.*/

SELECT SUM(distribucion.CANTIDAD) 'Stock', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_CONCESIONARIO conce ON distribucion.CONCESIONARIO=conce.CIF
GROUP BY conce.NOMBRE
ORDER BY `Stock` DESC;

/* RESULTADO
+-------+--------------------+
| Stock | CONCESIONARIO      |
+-------+--------------------+
|    51 | Automóviles Alpe   |
|    26 | Móvil Begar        |
|    20 | Tot Turbo          |
|    17 | 4 rodes            |
|    14 | Multi Car          |
|    14 | BMW Villa de campo |
|    13 | Motor Sport        |
|     8 | Grant Turismo      |
|     4 | Fercar             |
|  NULL | Todo motor         |
|  NULL | BMW Barna          |
|  NULL | Tope Gama          |
+-------+--------------------+


 */


-- 4.De la consulta anterior:
    -- a. Filtrar aquellos concesionarios que no tengan stock

SELECT SUM(distribucion.CANTIDAD) 'Stock', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_CONCESIONARIO conce ON distribucion.CONCESIONARIO=conce.CIF
GROUP BY conce.NOMBRE
HAVING Stock IS NULL;

/* RESULTADO
+-------+---------------+
| Stock | CONCESIONARIO |
+-------+---------------+
|  NULL | BMW Barna     |
|  NULL | Todo motor    |
|  NULL | Tope Gama     |
+-------+---------------+

 */


-- b. Filtrar aquellos concesionarios cuyo stock sea mayor o igual a 20.

SELECT SUM(distribucion.CANTIDAD) 'Stock', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_CONCESIONARIO conce ON distribucion.CONCESIONARIO=conce.CIF
GROUP BY conce.NOMBRE
HAVING Stock >= 20
ORDER BY `Stock` ASC;

/* RESULTADO
+-------+-------------------+
| Stock | CONCESIONARIO     |
+-------+-------------------+
|    20 | Tot Turbo         |
|    26 | Móvil Begar       |
|    51 | Automóviles Alpe  |
+-------+-------------------+

 */



-- ----------LISTAS---------------
/*1.Obtén el número de artistas, ordenados por número de artistas de
    forma descendente:*/
-- a. Por ciudad, sólo en aquellas en las que haya más de un artista.

SELECT ciudad.NOMBRE, COUNT(*) 'Numero de artistas'
FROM LISTAS_CIUDAD ciudad
    LEFT JOIN LISTAS_ARTISTA artista ON ciudad.COD=artista.COD_CIUDAD
GROUP BY ciudad.NOMBRE
HAVING COUNT(*)>1
ORDER BY COUNT(*);

/* RESULTADO
+--------------+--------------------+
| NOMBRE       | Numero de artistas |
+--------------+--------------------+
| Queens       |                  2 |
| Nashville    |                  2 |
| Houston      |                  2 |
| Gran Canaria |                  2 |
| Athens       |                  2 |
| Memphis      |                  2 |
| Gary         |                  2 |
| Newark       |                  2 |
| Medellín     |                  2 |
| Barcelona    |                  3 |
| Brooklyn     |                  3 |
| San Juan     |                  3 |
| Atlanta      |                  4 |
| Los Ángeles  |                  4 |
| Nueva York   |                  4 |
| Londres      |                 12 |
+--------------+--------------------+

 */


-- b. Por estado o provincia, sólo en aquellos en los que haya más
-- de un artista, también.

SELECT provincia.NOMBRE, COUNT(*) 'Numero de artistas'
FROM LISTAS_CIUDAD ciudad
    LEFT JOIN LISTAS_ARTISTA artista ON ciudad.COD=artista.COD_CIUDAD
    RIGHT JOIN LISTAS_PROVINCIA_ESTADO provincia ON ciudad.PROVINCIA_ESTADO=provincia.COD
GROUP BY provincia.NOMBRE
HAVING COUNT(*)>1
ORDER BY COUNT(*);

/* RESULTADO
+----------------------------+--------------------+
| Míchigan                   |                  2 |
| Washington D. C.           |                  2 |
| Kentucky                   |                  2 |
| Las Palmas de Gran Canaria |                  2 |
| Ontario                    |                  2 |
| Minesota                   |                  2 |
| Indiana                    |                  2 |
| Antioquia                  |                  2 |
| Virginia                   |                  3 |
| Barcelona                  |                  3 |
| Misisipi                   |                  4 |
| Nueva Jersey               |                  4 |
| Tennessee                  |                  5 |
| Puerto Rico                |                  5 |
| Georgia                    |                  7 |
| Texas                      |                  8 |
| California                 |                  9 |
| Nueva York                 |                 10 |
| Gran Londres               |                 16 |
+----------------------------+--------------------+

 */



-- c. Y por país, también sólo en aquellos en los que haya más de un
-- artista

SELECT pais.NOMBRE, COUNT(*) 'Numero de artistas'
FROM LISTAS_CIUDAD ciudad
    JOIN LISTAS_ARTISTA artista ON ciudad.COD=artista.COD_CIUDAD
    JOIN LISTAS_PROVINCIA_ESTADO provincia ON ciudad.PROVINCIA_ESTADO=provincia.COD
    JOIN LISTAS_PAIS pais ON provincia.COD_PAIS = pais.CODIGO
GROUP BY pais.NOMBRE
HAVING COUNT(*)>1
ORDER BY COUNT(*);

/* RESULTADO
+----------------+--------------------+
| NOMBRE         | Numero de artistas |
+----------------+--------------------+
| Noruega        |                  2 |
| Nueva Zelanda  |                  2 |
| Colombia       |                  3 |
| España         |                 11 |
| Reino Unido    |                 24 |
| Estados Unidos |                 69 |
+----------------+--------------------+
 */



/*2. Usando operadores de conjuntos:
    a. Muestra el nombre artístico de todos los artistas y grupos que
siguen en activo actualmente y el número de años que llevan
juntos o su edad, en una única columna que se llame “años”.
Ordena toda esta consulta por ese campo años de forma
descendente, además, si es un grupo debe estar menos de 20
años juntos y si es un artista independiente, tener menos de 35
años.
 */

SELECT artista.NOMBREARTISTICO,TIMESTAMPDIFF(YEAR,artistaind.FNAC,artistaind.FMUERTE) AS AÑOS
FROM LISTAS_ARTISTA artista
JOIN LISTAS_ARTISTAIND artistaind ON artista.COD = artistaind.COD
WHERE TIMESTAMPDIFF(YEAR,artistaind.FNAC,artistaind.FMUERTE) < 35

UNION ALL

SELECT artista.NOMBREARTISTICO, TIMESTAMPDIFF(YEAR,grupo.FCREACION,grupo.FDISOLUCION) AS AÑOS
FROM LISTAS_GRUPO grupo
     JOIN LISTAS_ARTISTA artista ON grupo.COD=artista.COD
WHERE TIMESTAMPDIFF(YEAR,grupo.FCREACION,grupo.FDISOLUCION)<20
ORDER BY AÑOS;


/* RESULTADO
+-----------------------------+-------+
| NOMBREARTISTICO             | AÑOS  |
+-----------------------------+-------+
| Fleetwood Mac               |     1 |
| Pink Floyd                  |     2 |
| The Sex Pistols             |     3 |
| The Jimi Hendrix Experience |     4 |
| The Smiths                  |     5 |
| The Beach Boys              |     7 |
| The Kingsmen                |     8 |
| The Clash                   |    10 |
| The Beatles                 |    10 |
| Led Zeppelin                |    12 |
| Jay-Z                       |    13 |
| OutKast                     |    14 |
| Robyn                       |    27 |
| Bill Monroe                 |    29 |
| Aless Gibaja                |    30 |
| The Who                     |    33 |
+-----------------------------+-------+

 */

