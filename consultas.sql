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
                    WHERE JEFE='Marga MArtinez');

/*7. Obtén el nombre, los apellidos y el salario de cada profesor sabiendo
que el sueldo base son 2000€ y que por cada trienio se sumarán 45€,
poniendo alias a todos los campos mostrados.*/

