/*-------------DUAL*/
SELECT UPPER(DATE_FORMAT((STR_TO_DATE('010712','%d%m%y')),'%M')) 'Fecha' FROM DUAL;
/*
+-------+
| Fecha |
+-------+
| JULIO |
+-------+
*/



/*-------------CICLOS FORMATIVOS*/
/*1.  De la tabla de profesores, realiza una sentencia select que obtenga la
siguiente salida: NOMBRE, FNACIMIENTO, FECHA_FORMATEADA,
donde FECHA_FORMATEADA tiene el siguiente formato:
“Nació el 12 de abril de 1992”.

 */
SELECT NOMBRE,FECHA_NACIMIENTO,DATE_FORMAT(FECHA_NACIMIENTO,'Nació el %d de %M de %Y') "Fecha Formateada"
FROM CICLOS_PROFESORES;
/*
+----------------------------------------+------------------+-----------------------------------+
| NOMBRE                                 | FECHA_NACIMIENTO | Fecha Formateada                  |
+----------------------------------------+------------------+-----------------------------------+
| Ana J. Martínez                        | NULL             | NULL                              |
| Ángel Martínez                         | NULL             | NULL                              |
| David Ponce                            | 1979-07-10       | Nació el 10 de julio de 1979      |
| Fernando Íñigo                         | NULL             | NULL                              |
| Godofredo Folgado                      | NULL             | NULL                              |
| Inma Climent                           | NULL             | NULL                              |
| Javi Llorens                           | NULL             | NULL                              |
| Jésica Sánchez (Prof.Inform 12)        | NULL             | NULL                              |
| José Manuel Cano                       | NULL             | NULL                              |
| José Ramón Más                         | NULL             | NULL                              |
| Juan Carlos Gómez                      | NULL             | NULL                              |
| Juan José Vidal                        | 1959-02-26       | Nació el 26 de febrero de 1959    |
| Julio Garay                            | 1939-04-09       | Nació el 09 de abril de 1939      |
| Lidia Cerdán                           | NULL             | NULL                              |
| Marga Martínez                         | NULL             | NULL                              |
| Mercedes Poveda                        | NULL             | NULL                              |
| Miguel Ángel Aguilar                   | NULL             | NULL                              |
| Miguel Ángel Tomás                     | NULL             | NULL                              |
| Miguel Sánchez                         | NULL             | NULL                              |
| Mª Rosa Aravid                         | 1977-04-30       | Nació el 30 de abril de 1977      |
| Paco Ribera                            | NULL             | NULL                              |
| Prof. Inf. 19                          | NULL             | NULL                              |
| Prof.sistemas 13                       | NULL             | NULL                              |
| Ramón Galinsoga                        | 1977-12-04       | Nació el 04 de diciembre de 1977  |
| Raúl Marín                             | NULL             | NULL                              |
| Ricardo Cantó                          | NULL             | NULL                              |
| Ricardo Lucas                          | NULL             | NULL                              |
| Roberto Bernabéu                       | 1977-12-04       | Nació el 04 de diciembre de 1977  |
| Samuel Hernández                       | 1972-07-15       | Nació el 15 de julio de 1972      |
| Sandra Deltell                         | 1966-12-15       | Nació el 15 de diciembre de 1966  |
| Silvia Amorós                          | NULL             | NULL                              |
| Sonia Tovar                            | NULL             | NULL                              |
| Tasio Mateos                           | 1964-03-07       | Nació el 07 de marzo de 1964      |
| Valentín Martínez (Prof.sistemas 12)   | NULL             | NULL                              |
| Vicente Peñataro                       | NULL             | NULL                              |
+----------------------------------------+------------------+-----------------------------------+
*/

/*
2. (0.5) Muestra el “Nombre Completo” y la “Edad” de aquellos profesores
que están cerca de jubilarse, es decir, que tienen más de 55 años.
Nombre completo se refiere al nombre y apellidos en una misma
columna separados POR UN SOLO ESPACIO
 */

/*En mi ddl, nombre y apellidos es una sola variable, de todas formas,
 esto se haría así.*/
SELECT CONCAT(NOMBRE,' ',APELLIDOS) 'Nombre completo', TIMESTAMPDIFF(YEAR ,FECHA_NACIMIENTO,CURDATE()) 'Edad'
FROM CICLOS_PROFESORES
WHERE TIMESTAMPDIFF(YEAR ,FECHA_NACIMIENTO,CURDATE()) BETWEEN 55 AND 65;

/*
+-----------------+------+
| Nombre completo | Edad |
+-----------------+------+
| Sandra Deltell  |   58 |
| Tasio Mateos    |   61 |
+-----------------+------+
*/

/*3. Para esta consulta deberás realizar una consulta previa
a. Muestra la longitud máxima del nombre de los módulos
b. Muestra el nombre de los módulos de la siguiente forma, que al
menos tengan un asterisco detrás.*/
-- A
SELECT MAX(LENGTH(NOMBRE)) 'Longitud'
FROM CICLOS_MODULO;

/*
+----------+
| Longitud |
+----------+
|       22 |
+----------+
 */

-- B
SELECT RPAD(NOMBRE,(SELECT MAX(CHAR_LENGTH(NOMBRE)) FROM CICLOS_MODULO),'*') NOMBRE
FROM CICLOS_MODULO;

/*
+-------------------------+
| NOMBRE                  |
+-------------------------+
| Sistemas Informáticos*  |
| FOL*******************  |
| Inglés****************  |
| Tutoría***************  |
| Entornos de Desarrollo  |
| Programación**********  |
| Base de Datos*********  |
| LENM******************  |
| PSER******************  |
| PMUL******************  |
| Inglés****************  |
| EIE*******************  |
| DINT******************  |
| AD********************  |
| SGES******************  |
| Tutoría***************  |
+-------------------------+

*/

/*4. Muestra el nombre y apellidos del profesor, la antigüedad y el salario,
teniendo en cuenta que el sueldo base de un profesor 2000 € y, por
cada trienio 46 € más, y que los trienios se miden por años completos.
Ordénalo por salario, descendentemente. Además, si la antigüedad es
nula, deberá mostrarse el sueldo base.*/
SELECT NOMBRE "Nombre y Apellido", DEPARTAMENTO "NOMBRE DEPARTAMENTO",IF(antig IS NULL,2000, salario) "SALARIO"
FROM CICLOS_PROFESORES
ORDER BY SALARIO DESC;

/*
+----------------------------------------+---------------------+---------+
| Nombre y Apellido                      | NOMBRE DEPARTAMENTO | SALARIO |
+----------------------------------------+---------------------+---------+
| Ana J. Martínez                        | Informática         |    2138 |
| Mª Rosa Aravid                         | Informática         |    2138 |
| Paco Ribera                            | Informática         |    2138 |
| Prof. Inf. 19                          | Informática         |    2138 |
| Prof.sistemas 13                       | Informática         |    2138 |
| Ramón Galinsoga                        | Informática         |    2138 |
| Raúl Marín                             | Informática         |    2138 |
| Ricardo Cantó                          | Informática         |    2138 |
| Ricardo Lucas                          | Informática         |    2138 |
| Roberto Bernabéu                       | Informática         |    2138 |
| Samuel Hernández                       | Informática         |    2138 |
| Sandra Deltell                         | Informática         |    2138 |
| Silvia Amorós                          | Informática         |    2138 |
| Sonia Tovar                            | Informática         |    2138 |
| Tasio Mateos                           | Informática         |    2138 |
| Valentín Martínez (Prof.sistemas 12)   | Informática         |    2138 |
| Miguel Sánchez                         | Informática         |    2138 |
| Miguel Ángel Tomás                     | Informática         |    2138 |
| Vicente Peñataro                       | Informática         |    2138 |
| Jésica Sánchez (Prof.Inform 12)        | Informática         |    2138 |
| Godofredo Folgado                      | Informática         |    2138 |
| José Ramón Más                         | Informática         |    2138 |
| Juan Carlos Gómez                      | Informática         |    2138 |
| Juan José Vidal                        | Informática         |    2138 |
| Julio Garay                            | Informática         |    2138 |
| Fernando Íñigo                         | Informática         |    2138 |
| David Ponce                            | Informática         |    2138 |
| Ángel Martínez                         | Informática         |    2138 |
| Javi Llorens                           | Informática         |    2138 |
| Inma Climent                           | FOL                 |    2092 |
| Miguel Ángel Aguilar                   | FOL                 |    2092 |
| Marga Martínez                         | FOL                 |    2092 |
| Lidia Cerdán                           | Inglés              |    2000 |
| Mercedes Poveda                        | Inglés              |    2000 |
| José Manuel Cano                       | Inglés              |    2000 |
+----------------------------------------+---------------------+---------+
 */


/*5. (0.5) Basándote en la consulta anterior, muestra el máximo, el mínimo
y el salario medio de los profesores de la tabla, este último con dos
decimales.*/
SELECT MAX(salario ) "SALARIO MAXIMO", MIN(salario) "SALARIO MINIMO",ROUND(AVG(salario),2) "MEDIA"
FROM CICLOS_PROFESORES;

/*
+----------------+----------------+---------+
| SALARIO MAXIMO | SALARIO MINIMO | MEDIA   |
+----------------+----------------+---------+
|           2138 |           2000 | 2122.23 |
+----------------+----------------+---------+
 */



/*-------------CONCESIONARIO*/

/*1. Visualiza “Cantidad”, “Concesionario” y “Coche”, siendo:
a. Cantidad: cantidad de coches distribuidos que se corresponde
con la máxima que hay en la tabla.
b. Concesionario: es el nombre del concesionario.
c. Coche: es una columna que contiene la Marca y el nombre del
coche, separados por un espacio*/

SELECT distr.CANTIDAD AS CANTIDAD, conce.NOMBRE AS Concesionario, CONCAT(marca.NOMBRE,' ',coche.NOMBRE) AS Coche
FROM CONCE_DISTRIBUCION distr, CONCE_CONCESIONARIO conce, CONCE_COCHE coche, CONCE_MARCA marca
WHERE distr.CONCESIONARIO=conce.CIF
AND distr.COCHE=coche.CODIGO
AND coche.MARCA=marca.NOMBRE
AND distr.cantidad=(SELECT MAX(CANTIDAD)
                    FROM CONCE_DISTRIBUCION);

/*
+----------+-------------------+---------+
| CANTIDAD | Concesionario     | Coche   |
+----------+-------------------+---------+
|       25 | Automóviles Alpe  | KIA RIO |
+----------+-------------------+---------+
 */


/*2. (0,5) ¿Cuántos coches distintos se han vendido?*/

SELECT COUNT(DISTINCT COCHE) 'Coches Distintos'
FROM CONCE_DISTRIBUCION;

/*
+-----------------------+
| COUNT(DISTINCT COCHE) |
+-----------------------+
|                    12 |
+-----------------------+
*/

/*3. Necesitamos crear contraseñas web seguras para todos los
concesionarios. ¿Qué tal si cogemos sus nombres y sustituimos las ‘A’
por ‘4’, las ‘E’ por ‘3’, las ‘I’ por ‘1’ las ‘O’ por ‘0’ y las ‘T’ por ‘7’?
Asegúrate para ello que el nombre está en mayúsculas y, si hubiera
algún acento, no sería el mismo carácter, así que no se tiene en
cuenta.*/
ALTER TABLE CONCE_CONCESIONARIO
ADD contraseña VARCHAR(50) GENERATED ALWAYS AS (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(NOMBRE),'T','7'),'O','0'),'I','1'),'E','3'),'A','4')) ;

SELECT contraseña FROM CONCE_CONCESIONARIO;

/*
+--------------------+
| contraseña         |
+--------------------+
| 4U70MÓV1L3S 4LP3   |
| MÓV1L B3G4R        |
| BMW B4RN4          |
| 4 R0D3S            |
| F3RC4R             |
| 707 7URB0          |
| GR4N7 7UR1SM0      |
| 70D0 M070R         |
| M070R SP0R7        |
| MUL71 C4R          |
| BMW V1LL4 D3 C4MP0 |
| 70P3 G4M4          |
+--------------------+
*/

/*4. Calcula el precio total, el precio mínimo, el precio máximo y el precio
medio de todos los coches.*/
SELECT TRUNCATE(SUM(PRECIO_BASE),0) 'Total', TRUNCATE(MIN(PRECIO_BASE),0) 'Mínimo',TRUNCATE(MAX(PRECIO_BASE),0) 'Máximo', TRUNCATE(AVG(PRECIO_BASE),0) 'Media'
FROM CONCE_COCHE;

/*
+--------+---------+---------+-------+
| Total  | Mínimo  | Máximo  | Media |
+--------+---------+---------+-------+
| 266000 |    5000 |   25000 | 16625 |
+--------+---------+---------+-------+
 */

/*-------------BDLISTAS*/
/*1. De los artistas, visualiza el nombre artístico, el último carácter del
nombre artístico que no sea blanco y el número de caracteres del
nombre artístico (sin contar los blancos de la derecha) ordenados por
el nombre artístico, de aquellos artistas que empiecen por J.*/

SELECT NOMBREARTISTICO,RIGHT(RTRIM(NOMBREARTISTICO),1) 'Último caracter',CHAR_LENGTH(RTRIM(NOMBREARTISTICO)) 'Longitud'
FROM LISTAS_ARTISTA
WHERE NOMBREARTISTICO LIKE 'J%'
ORDER BY NOMBREARTISTICO;

/*
+-----------------+------------------+----------+
| NOMBREARTISTICO | Último caracter  | Longitud |
+-----------------+------------------+----------+
| J Balvin        | n                |        8 |
| Jay Wheeler     | r                |       11 |
| Jay-Z           | Z                |        5 |
| Jimmie Rodgers  | s                |       14 |
| John Cobra      | a                |       10 |
| John Lennon     | n                |       11 |
| Johnny Cash     | h                |       11 |
| Justin Bieber   | r                |       13 |
+-----------------+------------------+----------+
 */


/*2. Muestra el nombre artístico de todos los artistas individuales que ya no
están entre nosotros, y la edad a la que murieron ordenado por edad. */

SELECT artista.NOMBREARTISTICO, TIMESTAMPDIFF(YEAR,FNAC,FMUERTE) AS 'Edad_Muerte'
FROM LISTAS_ARTISTA artista,LISTAS_ARTISTAIND artistaind
WHERE artista.COD=artistaind.COD
AND artistaind.FMUERTE IS NOT NULL
ORDER BY Edad_Muerte;

/*
+----------------------+-------------+
| NOMBREARTISTICO      | Edad_Muerte |
+----------------------+-------------+
| Robyn                |          27 |
| Bill Monroe          |          29 |
| Aless Gibaja         |          30 |
| The Who              |          33 |
| George Jones         |          35 |
| The Rolling Stones   |          40 |
| Elvis Presley        |          42 |
| John Lennon          |          44 |
| Backstreet Boys      |          48 |
| Madonna              |          50 |
| Jimmie Rodgers       |          55 |
| Whitney Houston      |          57 |
| Dolly Parton         |          64 |
| Missy Elliot         |          69 |
| Glen Campbell        |          70 |
| Karmele Marchante    |          71 |
| Eagles               |          71 |
| Nirvana              |          73 |
| The Stanley Brothers |          76 |
| Marvin Gaye          |          76 |
| Tammy Wynette        |          79 |
| Patsy Cline          |          81 |
| Kitty Wells          |          81 |
| Loretta Lynn         |          81 |
| Buck Owens           |          84 |
| Chuck Berry          |          90 |
| Hank Williams        |          92 |
+----------------------+-------------+
 */