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

/*3. Para esta consulta deberás realizar una consulta previa
a. Muestra la longitud máxima del nombre de los módulos
b. Muestra el nombre de los módulos de la siguiente forma, que al
menos tengan un asterisco detrás.*/
-- A
SELECT MAX(LENGTH(NOMBRE))
FROM CICLOS_MODULO;

-- B
SELECT RPAD(NOMBRE,(SELECT MAX(CHAR_LENGTH(NOMBRE)) FROM CICLOS_MODULO),'*') NOMBRE
FROM CICLOS_MODULO;


/*4. Muestra el nombre y apellidos del profesor, la antigüedad y el salario,
teniendo en cuenta que el sueldo base de un profesor 2000 € y, por
cada trienio 46 € más, y que los trienios se miden por años completos.
Ordénalo por salario, descendentemente. Además, si la antigüedad es
nula, deberá mostrarse el sueldo base.*/
SELECT NOMBRE "Nombre y Apellido", DEPARTAMENTO "NOMBRE DEPARTAMENTO",IF(antig IS NULL,2000, 2000 + 46 * FLOOR(antig / 3)) "SALARIO"
FROM CICLOS_PROFESORES
ORDER BY SALARIO DESC;


/*5. (0.5) Basándote en la consulta anterior, muestra el máximo, el mínimo
y el salario medio de los profesores de la tabla, este último con dos
decimales.*/
SELECT MAX(salario ) "SALARIO MAXIMO", MIN(salario) "SALARIO MINIMO",ROUND(AVG(salario),2) "MEDIA"
FROM CICLOS_PROFESORES;

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


/*2. (0,5) ¿Cuántos coches distintos se han vendido?*/

SELECT COUNT(DISTINCT COCHE)
FROM CONCE_DISTRIBUCION;
/*3. Necesitamos crear contraseñas web seguras para todos los
concesionarios. ¿Qué tal si cogemos sus nombres y sustituimos las ‘A’
por ‘4’, las ‘E’ por ‘3’, las ‘I’ por ‘1’ las ‘O’ por ‘0’ y las ‘T’ por ‘7’?
Asegúrate para ello que el nombre está en mayúsculas y, si hubiera
algún acento, no sería el mismo carácter, así que no se tiene en
cuenta.*/
ALTER TABLE CONCE_CONCESIONARIO
ADD contraseña VARCHAR(50) GENERATED ALWAYS AS (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(NOMBRE),'T','7'),'O','0'),'I','1'),'E','3'),'A','4')) ;
SELECT contraseña FROM CONCE_CONCESIONARIO;
/*4. Calcula el precio total, el precio mínimo, el precio máximo y el precio
medio de todos los coches.*/
SELECT TRUNCATE(SUM(PRECIO_BASE),0) 'Total', TRUNCATE(MIN(PRECIO_BASE),0) 'Mínimo',TRUNCATE(MAX(PRECIO_BASE),0) 'Máximo', TRUNCATE(AVG(PRECIO_BASE),0) 'Media'
FROM CONCE_COCHE;
/*-------------BDLISTAS*/
/*1. De los artistas, visualiza el nombre artístico, el último carácter del
nombre artístico que no sea blanco y el número de caracteres del
nombre artístico (sin contar los blancos de la derecha) ordenados por
el nombre artístico, de aquellos artistas que empiecen por J.*/
SELECT NOMBREARTISTICO,RTRIM(NOMBREARTISTICO),SUBSTR(NOMBREARTISTICO,CHAR_LENGTH(RTRIM(NOMBREARTISTICO)))'Último caracter',CHAR_LENGTH(RTRIM(NOMBREARTISTICO)) 'Longitud'
FROM LISTAS_ARTISTA;
/*2. Muestra el nombre artístico de todos los artistas individuales que ya no
están entre nosotros, y la edad a la que murieron ordenado por edad.*/
SELECT artista.NOMBREARTISTICO, TIMESTAMPDIFF(YEAR,FNAC,FMUERTE)
FROM LISTAS_ARTISTA artista,LISTAS_ARTISTAIND artistaind
WHERE artista.COD=artistaind.COD
AND artistaind.FMUERTE IS NOT NULL ;
