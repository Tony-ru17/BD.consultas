/*CICLOS FORMATIVOS*/
/*1. Visualiza todos los módulos que contengan tres letras "o" en su
interior.*/
SELECT *
FROM CICLOS_MODULO
WHERE NOMBRE LIKE '%o%o%o%';

/*2. Visualiza los nombres y apellidos de alumnos matriculados en 1º de
SMR y que hayan nacido después del año 2001 ordenados por
nombre.*/
SELECT NOMBRE,APELLIDOS
FROM CICLOS_ALUMNO
WHERE CICLO LIKE '1SMR_' AND FECHA_NACIMIENTO> '2001-1-1'
ORDER BY NOMBRE;

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


alter table CICLOS_PROFESORES add antig decimal(2,0);

update CICLOS_PROFESORES set antig=7 where departamento=(SELECT nombre
                                                         FROM CICLOS_DEPARTAMENTO
                                                         WHERE CODIGO=3);

update CICLOS_PROFESORES set antig=10 where departamento=(SELECT nombre
                                                          FROM CICLOS_DEPARTAMENTO
                                                          WHERE CODIGO=1);

update CICLOS_PROFESORES set antig=2 where departamento=(SELECT nombre
                                                         FROM CICLOS_DEPARTAMENTO
                                                         WHERE CODIGO=2);


SELECT NOMBRE "Nombre y Apellido", DEPARTAMENTO "NOMBRE DEPARTAMENTO", 2000+45*FLOOR(antig/3) "SALARIO"
FROM CICLOS_PROFESORES;

/*CONCESIONARIO*/
/*1. Obtén las ciudades en las que no haya ningún cliente ordenadas por
nombre. */

SELECT *
FROM CONCE_CIUDAD
WHERE NOMBRE NOT IN (SELECT CIUDAD
                 FROM CONCE_CLIENTE)
ORDER BY NOMBRE;

/*2. Obtén las ciudades distintas en las que haya algún cliente ordenadas
por nombre.*/

SELECT *
FROM CONCE_CIUDAD
WHERE NOMBRE IN (SELECT CIUDAD
                     FROM CONCE_CLIENTE)
ORDER BY NOMBRE;

/*3. Selecciona el nombre de aquellos coches que se hayan vendido en
concesionarios de Alicante ordenados por nombre.*/

SELECT NOMBRE
FROM CONCE_COCHE
WHERE CODIGO IN (SELECT COCHE
                 FROM CONCE_VENTAS
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
BMW ordenado por marca y nombre del coche.*/

SELECT coche.MARCA, coche.NOMBRE,ventas.COLOR
FROM CONCE_COCHE coche, CONCE_VENTAS ventas
WHERE ventas.FECHA BETWEEN '2019-8-1' AND '2019-8-31'
AND coche.MARCA IN ('KIA','Seat','BMW')
AND coche.CODIGO=ventas.COCHE
ORDER BY coche.MARCA, ventas.COCHE;

/*LISTAS*/

 /*1. Selecciona el nombre artístico, el nombre real y el nombre de la ciudad
de los artistas independientes cuyo país sea Estados Unidos.*/


SELECT artista.NOMBREARTISTICO "Nombre Artístico", artistaind.nombreReal "Nombre Real", ciudad.NOMBRE "Ciudad"
FROM LISTAS_ARTISTA artista, LISTAS_ARTISTAIND artistaind, LISTAS_PAIS pais, LISTAS_PROVINCIA_ESTADO proves, LISTAS_CIUDAD ciudad
WHERE artistaind.COD = artista.COD
AND artista.COD_CIUDAD=ciudad.COD
AND ciudad.PROVINCIA_ESTADO=proves.COD
AND proves.COD_PAIS = pais.CODIGO
AND pais.NOMBRE='Estados Unidos';



/*2. Muestra la posición, el nombre del artista y el nombre de la canción de
la lista 7. */

SELECT posicion.POSICION, artista.NOMBREARTISTICO,lista.NOMBRE
FROM LISTAS_POSICION_LISTA posicion,LISTAS_ARTISTA artista, LISTAS_LISTA lista, LISTAS_CANCION cancion
WHERE posicion.COD_LISTA = lista.COD
AND posicion.COD_CANCION=cancion.COD
AND cancion.COD_ARTISTA=artista.COD
AND lista.COD=7;


/*3. Lista el nombre de todos los géneros ordenados alfabéticamente.*/

DESC LISTAS_GENERO;
SELECT NOMBRE
FROM LISTAS_GENERO
ORDER BY NOMBRE;


/*4. Lista el nombre y el género de todas las canciones que tengan como
género alguno que contenga en su interior la palabra rock
(indistintamente de si está en mayúsculas o minúsculas).*/

SELECT cancion.TITULO, genero.NOMBRE
FROM LISTAS_CANCION cancion, LISTAS_GENERO genero, LISTAS_GENERO_CANCION gencan
WHERE cancion.COD=gencan.COD_CANCION
AND gencan.COD_GENERO = genero.COD
AND LOWER(genero.NOMBRE) LIKE '%rock%';

/*5. Lista el nombre artístico, la fecha de nacimiento y la fecha de la muerte
de los artistas independientes que hayan muerto y que nacieron
después de los años 70.*/

SELECT artista.NOMBREARTISTICO, artistaind.FNAC, artistaind.FMUERTE
FROM LISTAS_ARTISTA artista, LISTAS_ARTISTAIND artistaind
WHERE artistaind.COD=artista.COD
AND FMUERTE IS NOT NULL
AND FNAC>'1970-01-01';
SELECT * FROM LISTAS_ARTISTA;


/*6. Selecciona el nombre y la fecha de disolución de los grupos que se
han disuelto ordenados por fecha de disolución.*/

SELECT artista.NOMBREARTISTICO, grupo.FDISOLUCION
FROM LISTAS_ARTISTA artista, LISTAS_GRUPO grupo
WHERE grupo.COD=artista.COD
AND grupo.FDISOLUCION IS NOT NULL
ORDER BY grupo.FDISOLUCION;

/*7. Obtén el nombre de todos los grupos que se crearon después de la
muerte de Elvis Presley ordenado por fecha de creación*/

SELECT artista.NOMBREARTISTICO
FROM LISTAS_ARTISTA artista,LISTAS_GRUPO grupo
WHERE grupo.COD=artista.COD
AND grupo.FCREACION > (SELECT FMUERTE
     FROM LISTAS_ARTISTAIND artistaind, LISTAS_ARTISTA artista
     WHERE artista.COD=artistaind.COD
     AND artista.NOMBREARTISTICO='Elvis Presley')
ORDER BY grupo.FCREACION;






