-- ---------CICLOS-------------
/*1. Selecciona aquellos módulos que estén repetidos en más de un ciclo y
el número de veces que se repiten ordenados por nombre.*/
SELECT NOMBRE, COUNT(*)
FROM CICLOS_MODULO
GROUP BY NOMBRE
HAVING COUNT(*)>1
ORDER BY nombre;
/*2. Obtén el número de alumnos matriculados en cada curso (usa join si
hay más de una tabla) y, además, el nombre de su tutor. Ten en cuenta
que si el curso no tiene tutor, también deberá salir, ordena por curso.*/
-- Como full join no está en mySql utilizaré el WHERE
SELECT COUNT(*)
FROM CICLOS_CURSO
FULL JOIN CICLOS_ALUMNO
ON CICLOS_=CICLOS_ALUMNO.CICLO ;


/*3. De cada departamento, muestra a su jefe y el nº de profesores que
tiene.*/
/*4. Muestra las notas del periodo 1 que faltan por introducir por alumno y
módulo.*/

-- -------CONCESIONARIO-----------
/*1. Visualiza las ventas de todos los concesionarios, incluso aquellos que
no hayan vendido ningún coche, ordenados por número de ventas de
forma descendente y por nombre de concesionario.*/
/*2. Visualiza el número de coches vendidos, incluso para aquellos coches
que no hayan sido vendidos nunca ordenado descendentemente por el
total de coches y por el coche.*/
/*3. Queremos saber el stock total de cada concesionario (es decir, la
cantidad total de coches distribuidos), incluso aquellos que no tengan
Stock ordenado de mayor a menor stock.*/
/*4.De la consulta anterior:
    a. Filtrar aquellos concesionarios que no tengan stock
    b. Filtrar aquellos concesionarios cuyo stock sea mayor o igual a 20.*/

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