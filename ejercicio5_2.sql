/*-------------DUAL*/
SELECT UPPER(DATE_FORMAT((STR_TO_DATE('010712','%d%m%y')),'%M')) 'Fecha' FROM DUAL;
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

/*
 En mi ddl, nombre y apellidos es una sola variable, de todas formas,
 esto se haría así.
 */
SELECT CONCAT(NOMBRE,' ',APELLIDOS) 'Nombre completo', TIMESTAMPDIFF(YEAR ,FECHA_NACIMIENTO,SYSDATE()) 'Edad'
FROM CICLOS_PROFESORES
/*-------------CONCESIONARIO*/
/*-------------BDLISTAS*/
