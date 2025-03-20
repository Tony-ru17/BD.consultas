/*CICLOS FORMATIVOS*/
/*1. Visualiza todos los módulos que contengan tres letras "o" en su
interior.*/
SELECT *
FROM CICLOS_CICLO
WHERE NOMBRE LIKE '%o%';

/*2. Visualiza los nombres y apellidos de alumnos matriculados en 1º de
SMR y que hayan nacido después del año 2001 ordenados por
nombre.*/
SELECT NOMBRE,APELLIDOS
FROM CICLOS_ALUMNO
WHERE CICLO LIKE '1SMR_' AND FECHA_NACIMIENTO> '2001-1-1';

/*3. Muestra los nombres, los apellidos y la fecha de nacimiento de todos
aquellos profesores que pertenezcan al mismo departamento que
Samuel Hernández, ordenados por fecha de nacimiento de forma
descendente.*/

/*Mi DDL no tiene la columna de Apellidos, en el nombre se incluyen también los apellidos*/
SELECT NOMBRE,FECHA_NACIMIENTO
FROM CICLOS_PROFESORES
WHERE DEPARTAMENTO=(SELECT DEPARTAMENTO
       FROM CICLOS_PROFESORES
       WHERE NOMBRE='Samuel Hernández')
ORDER BY FECHA_NACIMIENTO DESC;
/*4. Obtén los datos de los módulos con mayor número de horas que
ningún otro módulo.*/

SELECT *
FROM CICLOS_MODULO
WHERE nhorassem = (SELECT MAX(nhorassem)
                   FROM CICLOS_MODULO);

/*5. Obtén los datos de los módulos con menor número de horas que
ningún otro módulo.*/

SELECT *
FROM CICLOS_MODULO
WHERE nhorassem = (SELECT MIN(nhorassem)
                   FROM CICLOS_MODULO);

/*6. Obtén el nombre y apellido de los profesores cuyo jefe de
departamento sea Marga Martínez.*/

SELECT NOMBRE
FROM CICLOS_PROFESORES
WHERE DEPARTAMENTO=(SELECT NOMBRE
                    FROM CICLOS_DEPARTAMENTO
                    WHERE JEFE='Marga Martinez');

/*7. Obtén el nombre, los apellidos y el salario de cada profesor sabiendo
que el sueldo base son 2000€ y que por cada trienio se sumarán 45€,
poniendo alias a todos los campos mostrados.*/


alter table ciclos_profesores add antig decimal(2,0);

update ciclos_profesores set antig=7 where departamento=(SELECT nombre
                                                         FROM ciclos_departamento
                                                         WHERE CODIGO=3);

update ciclos_profesores set antig=10 where departamento=(SELECT nombre
                                                          FROM ciclos_departamento
                                                          WHERE CODIGO=1);

update ciclos_profesores set antig=2 where departamento=(SELECT nombre
                                                         FROM ciclos_departamento
                                                         WHERE CODIGO=2);


SELECT NOMBRE "Nombre y Apellido", DEPARTAMENTO "NOMBRE DEPARTAMENTO", 2000+45*FLOOR(antig/3) "SALARIO"
FROM CICLOS_PROFESORES;

/*CONCESIONARIO*/
/*1. Obtén las ciudades en las que no haya ningún cliente ordenadas por
nombre. */

SELECT *
FROM CONCE_CIUDAD
WHERE NOMBRE NOT IN (SELECT CIUDAD
                 FROM conce_cliente)
ORDER BY NOMBRE;

/*2. Obtén las ciudades distintas en las que haya algún cliente ordenadas
por nombre.*/

SELECT *
FROM CONCE_CIUDAD
WHERE NOMBRE IN (SELECT CIUDAD
                     FROM conce_cliente)
ORDER BY NOMBRE;

/*3. Selecciona el nombre de aquellos coches que se hayan vendido en
concesionarios de Alicante ordenados por nombre.*/

SELECT NOMBRE
FROM CONCE_COCHE
WHERE CODIGO IN (SELECT COCHE
                 FROM conce_ventas
                 WHERE CONCESIONARIO IN (SELECT CIF
                                         FROM CONCE_CONCESIONARIO
                                         WHERE CIUDAD='Alicante'))
ORDER BY NOMBRE;

/*4. Visualiza las columnas nombre, apellido y ciudad de los clientes cuyo
apellido no esté comprendido entre la "B" y la "Q", ordenado por
apellido. */

SELECT NOMBRE,APELLIDO,CIUDAD
FROM CONCE_CLIENTE
WHERE APELLIDO NOT BETWEEN 'B%' AND 'Q%'
ORDER BY APELLIDO;
/*5. Visualiza las columnas nombre, apellido y ciudad de los clientes cuyo
apellido esté comprendido entre la “B” y la “P”.*/

SELECT NOMBRE,APELLIDO,CIUDAD
FROM CONCE_CLIENTE
WHERE APELLIDO BETWEEN 'B%' AND 'P%';

  /*6. Visualiza la marca, el nombre y los colores de los coches distintos que
han sido comprados en agosto de 2019 y cuya marca sea Kia, Seat o
BMW ordenado por marca y nombre del coche .*/

SELECT DISTINCT coche.MARCA, ventas.COCHE,ventas.COLOR
FROM CONCE_COCHE coche, CONCE_VENTAS ventas
WHERE ventas.FECHA BETWEEN '2019-8-1' AND '2019-8-31'
AND coche.MARCA IN ('KIA','Seat','BMW')
AND coche.CODIGO=ventas.COCHE;