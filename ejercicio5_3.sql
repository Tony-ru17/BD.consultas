-- ---------CICLOS-------------
/*1. Selecciona aquellos módulos que estén repetidos en más de un ciclo y
el número de veces que se repiten ordenados por nombre.*/
SELECT NOMBRE, COUNT(*) nºrepeticiones
FROM CICLOS_MODULO
GROUP BY NOMBRE
HAVING COUNT(*)>1
ORDER BY nombre;
/*2. Obtén el número de alumnos matriculados en cada curso (usa join si
hay más de una tabla) y, además, el nombre de su tutor. Ten en cuenta
que si el curso no tiene tutor, también deberá salir, ordena por curso.*/


SELECT curso.ABREVIATURA, COUNT(*) AS 'Número de Alumnos', modulo.profesor AS 'Tutor'
FROM CICLOS_CURSO curso
         JOIN CICLOS_ALUMNO alumno ON alumno.CICLO = curso.ABREVIATURA
         LEFT JOIN CICLOS_MODULO modulo ON curso.ABREVIATURA = modulo.curso AND modulo.nombre = 'Tutoría'
GROUP BY curso.ABREVIATURA, modulo.profesor
ORDER BY curso.ABREVIATURA;



/*3. De cada departamento, muestra a su jefe y el nº de profesores que
tiene.*/

SELECT departamento.NOMBRE, departamento.JEFE, COUNT(*) 'Contador'
FROM CICLOS_DEPARTAMENTO departamento
         JOIN CICLOS_PROFESORES profesores ON departamento.NOMBRE=profesores.DEPARTAMENTO
GROUP BY departamento.NOMBRE,departamento.JEFE;

/*4. Muestra las notas del periodo 1 que faltan por introducir por alumno y
módulo.*/

SELECT CONCAT(alumno.NOMBRE, ' ', alumno.APELLIDOS) AS Alumno, modulo.nombre AS Modulo
FROM CICLOS_ALUMNO alumno
         JOIN CICLOS_CURSO curso ON alumno.CICLO = curso.ABREVIATURA
         JOIN CICLOS_MODULO modulo ON curso.ABREVIATURA = modulo.curso
         LEFT JOIN CICLOS_EVALUACION notas ON alumno.NIA = notas.ALUMNO AND modulo.codigo = notas.MODULO AND notas.EVALUACION = 1
WHERE notas.NOTA IS NULL
ORDER BY CONCAT(alumno.NOMBRE, ' ', alumno.APELLIDOS);




-- -------CONCESIONARIO-----------
/*1. Visualiza las ventas de todos los concesionarios, incluso aquellos que
no hayan vendido ningún coche, ordenados por número de ventas de
forma descendente y por nombre de concesionario.*/


SELECT COUNT(*) 'Total coches vendidos', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_VENTAS ventas
         RIGHT JOIN CONCE_CONCESIONARIO conce ON ventas.CONCESIONARIO=conce.CIF
GROUP BY conce.CIF
ORDER BY `Total coches vendidos` DESC;

/*2. Visualiza el número de coches vendidos, incluso para aquellos coches
que no hayan sido vendidos nunca ordenado descendentemente por el
total de coches y por el coche.*/

SELECT SUM(distribucion.CANTIDAD) 'Total coches vendidos', coche.NOMBRE AS Coche
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_COCHE coche ON distribucion.COCHE=coche.CODIGO
GROUP BY coche.CODIGO
ORDER BY `Total coches vendidos` DESC;

/*3. Queremos saber el stock total de cada concesionario (es decir, la
cantidad total de coches distribuidos), incluso aquellos que no tengan
Stock ordenado de mayor a menor stock.*/

SELECT SUM(distribucion.CANTIDAD) 'Stock', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_CONCESIONARIO conce ON distribucion.CONCESIONARIO=conce.CIF
GROUP BY conce.NOMBRE
ORDER BY `Stock` ASC;

/*4.De la consulta anterior:
    a. Filtrar aquellos concesionarios que no tengan stock
    b. Filtrar aquellos concesionarios cuyo stock sea mayor o igual a 20.*/
SELECT SUM(distribucion.CANTIDAD) 'Stock', conce.NOMBRE AS CONCESIONARIO
FROM CONCE_DISTRIBUCION distribucion
         RIGHT JOIN CONCE_CONCESIONARIO conce ON distribucion.CONCESIONARIO=conce.CIF
GROUP BY conce.NOMBRE
HAVING Stock IS NULL
ORDER BY `Stock` ASC;


-- ----------LISTAS---------------
/*1.Obtén el número de artistas, ordenados por número de artistas de
    forma descendente:
    a. Por ciudad, sólo en aquellas en las que haya más de un artista.
    b. Por estado o provincia, sólo en aquellos en los que haya más
    de un artista, también.
    c. Y por país, también sólo en aquellos en los que haya más de un
    artista*/
/*2. Usando operadores de conjuntos:
    a. Muestra el nombre artístico de todos los artistas y grupos que
siguen en activo actualmente y el número de años que llevan
juntos o su edad, en una única columna que se llame “años”.
Ordena toda esta consulta por ese campo años de forma
descendente, además, si es un grupo debe estar menos de 20
años juntos y si es un artista independiente, tener menos de 35
años.
 */