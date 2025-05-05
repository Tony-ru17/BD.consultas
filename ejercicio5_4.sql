-- -------------CICLOS--------------
/*1. Crea una vista “Tutorespocurso”, que almacene los nombres de los
cursos con los nombres de los tutores de cada curso y el número de
alumnos de cada curso. */

CREATE OR REPLACE VIEW Tutoresporcurso(nombreCurso, nombreTutor, numAlumnos) AS
SELECT curso.abreviatura,profesor.nombre, COUNT(*)
FROM CICLOS_CURSO curso, CICLOS_PROFESOR profesor, CICLOS_ALUMNO alumnos
WHERE CONCAT(curso.codigo_ciclo,curso.numero,curso.grupo)=CONCAT(alumnos.codigo_ciclo,alumnos.numero_curso,alumnos.grupo_curso)
AND curso.tutor_curso=profesor.dni
GROUP BY alumnos.numero_curso,alumnos.grupo_curso,alumnos.codigo_ciclo;

SELECT * FROM Tutoresporcurso;

/*
+-------------+-------------------------+------------+
| nombreCurso | nombreTutor             | numAlumnos |
+-------------+-------------------------+------------+
| 1SMRA       | Jésica Sánchez          |          3 |
| 1DAW        | José Ramón Más          |          3 |
| 1DAM        | Ricardo Canto           |          2 |
| 1SMRC       | 1ºSMR Prof 12 - TARDE   |          4 |
| 1DAWSemi    | Tasio Mateo Martínez    |          3 |
| 2ASIRA      | Javi Llorens Llorens    |          3 |
| 2DAMA       | Miguel Sánchez Molina   |          1 |
| 2SMRB       | Ana J. Martínez         |          3 |
| 2SMRC       | Ángel Martínez Arques   |          3 |
+-------------+-------------------------+------------+

 */



/*2. Inserta en la tabla alumnos todos aquellos profesores que sean tutores
de algún curso o aquellos que no impartan ningún módulo y, además,
su fecha de nacimiento sea posterior a 1960. ¿Funciona
correctamente? Cambia lo necesario para que funcione correctamente. */

/* Esta ejecución da un error, ya que hay alumnos que tienen el mismo DNI
   que los profesores, para que funcione voy a cambiar los DNIs de los
   alumnos que coincidan.
   Para ello primero vemos cuáles coinciden:*/




-- Actualizamos el dni del alumno de ciclos_evaluacion y después ciclos_alumno
SET FOREIGN_KEY_CHECKS = 0;
UPDATE CICLOS_EVALUACION
SET dniAlumno=dniAlumno+120
WHERE dniAlumno IN(SELECT CICLOS_EVALUACION.dniAlumno
      FROM CICLOS_EVALUACION,CICLOS_PROFESOR
      WHERE CICLOS_EVALUACION.dniAlumno=CICLOS_PROFESOR.dni);

UPDATE CICLOS_ALUMNO
SET dni=dni+120
WHERE dni IN(SELECT CICLOS_ALUMNO.dni
                   FROM CICLOS_ALUMNO,CICLOS_PROFESOR
                   WHERE CICLOS_ALUMNO.dni=CICLOS_PROFESOR.dni);
SELECT *
FROM CICLOS_EVALUACION;
SELECT *
FROM CICLOS_ALUMNO;
SET FOREIGN_KEY_CHECKS = 1;

-- Debemos modificar la tabla de CICLOS_ALUMNO, ya que algunos nombre son muy largos
ALTER TABLE CICLOS_ALUMNO
MODIFY nombre VARCHAR(30);

-- Ahora insertamos los valores

INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,telefono)
SELECT DISTINCT profesor.dni,profesor.nombre,profesor.email,profesor.fecha_nacimiento,profesor.telefono
FROM CICLOS_PROFESOR profesor
    LEFT JOIN CICLOS_CURSO curso ON profesor.dni=curso.tutor_curso
    LEFT JOIN CICLOS_IMPARTIR impartir ON profesor.dni = impartir.dni_profesor
WHERE profesor.fecha_nacimiento>'1960-01-01'
AND(curso.tutor_curso IS NOT NULL);

SELECT *
FROM CICLOS_ALUMNO a,CICLOS_PROFESOR p
WHERE a.dni=p.dni;
/*
+----------+----------------+----------------------------------+------------------+-----------+--------------+--------------+-------------+----------+--------------------------+---------------------------------------------+-----------+------------------+--------------+-------+
| dni      | nombre         | email                            | fecha_nacimiento | telefono  | codigo_ciclo | numero_curso | grupo_curso | dni      | nombre                   | email                                       | telefono  | fecha_nacimiento | departamento | antig |
+----------+----------------+----------------------------------+------------------+-----------+--------------+--------------+-------------+----------+--------------------------+---------------------------------------------+-----------+------------------+--------------+-------+
| 11111111 | Rasmus Lerdorf | rasmusledorf@gmail.com           | 1989-11-29       | 777777777 |            4 |            2 | A           | 11111111 | José Manuel Cano         | josemanuelcano.ingles@iespacomolla.es       | 644857468 | 1966-12-15       |            2 |     2 |
| 11111114 | Larry Page     | l.page@iespacomolla.es           | 2003-11-24       | 666555225 |            1 |            2 | B           | 11111114 | Jésica Sánchez           | jesicasanchez.informatica@iespacomolla.es   | 987712439 | 1970-06-12       |            1 |    10 |
| 11111116 | Steve Jobs     | steve@fallodeisaac.com           | 1998-12-12       | NULL      |            1 |            1 | B           | 11111116 | David Ponce              | davidponce.informatica@iespacomolla.es      | 976632918 | 1991-09-01       |            1 |    10 |
| 11111120 | Jeff Bezos     | jeffbezos.alumno@iespacomolla.es | 1991-05-10       | 632451751 |            1 |            1 | C           | 11111120 | Samuel Hernández Romero  | samuelhernandez.informatica@iespacomolla.es | 644747595 | 1973-01-22       |            1 |    10 |
+----------+----------------+----------------------------------+------------------+-----------+--------------+--------------+-------------+----------+--------------------------+---------------------------------------------+-----------+------------------+--------------+-------+

 */


/*
3. Elimina de la tabla de profesores aquellos que no impartan ningún
módulo, no sean jefes de departamento ni tutores. (exists)
 */




DELETE FROM CICLOS_PROFESOR
WHERE NOT EXISTS (
    SELECT 1
    FROM CICLOS_IMPARTIR
    WHERE CICLOS_IMPARTIR.dni_profesor = CICLOS_PROFESOR.dni
)
  AND NOT EXISTS (
    SELECT 1
    FROM CICLOS_DEPARTAMENTO
    WHERE CICLOS_DEPARTAMENTO.jefe_departamento = CICLOS_PROFESOR.dni
)
  AND NOT EXISTS (
    SELECT 1
    FROM CICLOS_CURSO
    WHERE CICLOS_CURSO.tutor_curso = CICLOS_PROFESOR.dni
);

SELECT * FROM CICLOS_PROFESOR;

/*
+----------+--------------------------------+---------------------------------------------------+-----------+------------------+--------------+-------+
| dni      | nombre                         | email                                             | telefono  | fecha_nacimiento | departamento | antig |
+----------+--------------------------------+---------------------------------------------------+-----------+------------------+--------------+-------+
| 11111111 | José Manuel Cano               | josemanuelcano.ingles@iespacomolla.es             | 644857468 | 1966-12-15       |            2 |     2 |
| 11111112 | Inma Climent                   | inmaculadacliment.fol@iespacomolla.es             | 971403768 | 1985-04-23       |            3 |     7 |
| 11111113 | Paco Ribera                    | pacoribera.informatica@iespacomolla.es            | 152398710 | 1990-11-05       |            1 |    10 |
| 11111114 | Jésica Sánchez                 | jesicasanchez.informatica@iespacomolla.es         | 987712439 | 1970-06-12       |            1 |    10 |
| 11111115 | Juan José Vidal                | juanjosevidal.informatica@iespacomolla.es         | 547123786 | 1988-02-11       |            1 |    10 |
| 11111116 | David Ponce                    | davidponce.informatica@iespacomolla.es            | 976632918 | 1991-09-01       |            1 |    10 |
| 11111117 | Miguel Ángel Aguilar Pérez     | miguelangelaguilar.fol@iespacomolla.es            | 644837468 | 1977-12-04       |            3 |     7 |
| 11111118 | 1ºSMR Prof 12 - TARDE          | profesorsistematarde.informatica@gmail.com        | 658432756 | 1985-10-21       |            1 |    10 |
| 11111119 | Fernando Íñigo                 | fernandoiñigo.informatica@gmail.com               | 685236875 | 1974-06-29       |            1 |    10 |
| 11111120 | Samuel Hernández Romero        | samuelhernandez.informatica@iespacomolla.es       | 644747595 | 1973-01-22       |            1 |    10 |
| 11111121 | Raúl Marín                     | raulmarin.informatica@gmail.com                   | 745621935 | 1992-04-06       |            1 |    10 |
| 11111122 | 1ºSMR Prof 13 - MAÑANA/TARDE   | profesorsistemamañanatarde.informatica@gmail.com  | 723541684 | 1974-06-29       |            1 |    10 |
| 11111123 | Julio Garay                    | juliogaray.informatica@iespacomolla.es            | 965387384 | 1983-06-05       |            1 |    10 |
| 11111124 | Godofredo Folgado De La Rosa   | godofredo@gmail.com                               | 666666667 | 2001-01-01       |            1 |    10 |
| 11111125 | Marga Martínez                 | margamartinez.fol@iespacomolla.es                 | 647446885 | 1981-11-16       |            2 |     2 |
| 11111126 | Sonia Tovar Francés            | soniatovar.informatica@iespacomolla.es            | 644427758 | 1966-02-06       |            1 |    10 |
| 11111127 | Ana J. Martínez                | anamartinez.informatica@iespacomolla.es           | 625147589 | 1978-10-20       |            1 |    10 |
| 11111128 | Ángel Martínez Arques          | angelmartinez.informatica@iespacomolla.es         | 647447665 | 1977-04-30       |            1 |    10 |
| 11111129 | Javi Llorens Llorens           | javi@gmail.com                                    | 666666668 | 2003-01-01       |            1 |    10 |
| 11111130 | Sandra Deltell                 | sandradeltell.informatica@iespacomolla.es         | 654321000 | 1990-02-10       |            1 |    10 |
| 11111131 | Vicente Peñataro               | vicentepenataro.informatica@iespacomolla.es       | 965387385 | 1988-07-01       |            1 |    10 |
| 11111132 | Roberto Bernabéu Gómez         | roberto@gmail.com                                 | 666666669 | 2006-01-01       |            1 |    10 |
| 11111133 | Ricardo Lucas Gómez            | ricardolucas.informatica@iespacomolla.es          | 647447665 | 1972-07-15       |            1 |    10 |
| 11111134 | Ricardo Canto                  | ricardocanto.informatica@iespacomolla.es          | 655566999 | 1968-04-15       |            1 |    10 |
| 11111135 | Lidia Cerdan                   | lidiacerdan.ingles@iespacomolla.es                | 625999874 | 1990-04-25       |            2 |     2 |
| 11111136 | Miguel Sánchez Molina          | miguel@gmail.com                                  | 666666611 | 2004-01-01       |            1 |    10 |
| 11111137 | Miguel Ángel Tomás             | migueltomas.informatica@iespacomolla.es           | 966333030 | 1998-01-01       |            1 |    10 |
| 11111138 | Mercedes Poveda                | mercedespoveda.ingles@iespacomolla.es             | 966323030 | 1998-01-01       |            2 |     2 |
| 11111139 | Mº Rosa Aravid                 | mariarosaaravid.informatica@iespacomolla.es       | 966343030 | 1998-01-01       |            1 |    10 |
| 11111140 | Silvia Amoros                  | silviaamoros.informatica@iespacomolla.es          | 966353030 | 1998-01-01       |            1 |    10 |
| 11111141 | José Ramón Más                 | josemanuelcano.informatica@iespacomolla.es        | 621498877 | 1969-02-05       |         NULL |  NULL |
| 11111142 | Juan Carlos Gómez              | juancarlosgomez.informatica@iespacomolla.es       | 966313030 | 1998-01-01       |            1 |    10 |
| 11111143 | Tasio Mateo Martínez           | NULL                                              | NULL      | NULL             |         NULL |  NULL |
| 11111144 | Prof. Inf 19                   | NULL                                              | NULL      | NULL             |         NULL |  NULL |
+----------+--------------------------------+---------------------------------------------------+-----------+------------------+--------------+-------+

 */


/*
4. Crea una vista “Notas medias” con las notas medias por trimestre y
módulo, almacenando la nota únicamente con dos decimales */

CREATE VIEW Notas_Medias AS
SELECT codigoTrimestre, codigoModulo, ROUND(AVG(nota), 2) AS nota_media
FROM CICLOS_EVALUACION
GROUP BY codigoTrimestre,codigoModulo;

SELECT * FROM Notas_Medias;

/*
+-----------------+--------------+------------+
| codigoTrimestre | codigoModulo | nota_media |
+-----------------+--------------+------------+
|               1 | 0221         |       6.25 |
|               1 | 0223         |       8.00 |
|               1 | 0225         |       8.00 |
|               1 | 0226         |       5.37 |
|               1 | 0227         |       6.74 |
|               1 | 0228         |       5.94 |
|               1 | 0229         |      10.00 |
|               1 | 0230         |       3.17 |
|               1 | 0484         |       6.00 |
|               1 | 0485         |       5.67 |
|               1 | 0486         |       6.67 |
|               1 | 0488         |       4.33 |
|               1 | 0494         |       4.67 |
|               1 | 0612         |       6.00 |
|               1 | 0613         |       7.00 |
|               1 | 0614         |       4.00 |
|               1 | CV0001       |       3.00 |
|               2 | 0485         |       6.00 |
|               2 | 5052         |       6.67 |
|               3 | 0221         |       8.50 |
|               3 | 0223         |       3.20 |
|               3 | 0225         |       6.70 |
|               3 | 0374         |       7.33 |
|               3 | 0375         |       5.33 |
|               3 | 0376         |       2.33 |
+-----------------+--------------+------------+

 */



/*5. Crea una vista “Posibles jubilaciones” con los profesores que sean
posibles jubilados, es decir, que tengan 55 años o más.*/

CREATE OR REPLACE VIEW POSIBLES_JUBILACIONES(DNI_PROFESOR,NOMBRE_PROFESOR,EMAIL_PROFESOR,TELEFONO_PROFESOR,FECHA_NACIMIENTO_PROFESOR,DEPARTAMENTO,ANTIG) AS
SELECT dni,nombre,email,telefono,fecha_nacimiento,departamento,antig
FROM CICLOS_PROFESOR
WHERE (YEAR(SYSDATE())-YEAR(fecha_nacimiento))>=55;

SELECT * FROM POSIBLES_JUBILACIONES;

/*
+--------------+----------------------+--------------------------------------------+-------------------+---------------------------+--------------+-------+
| DNI_PROFESOR | NOMBRE_PROFESOR      | EMAIL_PROFESOR                             | TELEFONO_PROFESOR | FECHA_NACIMIENTO_PROFESOR | DEPARTAMENTO | ANTIG |
+--------------+----------------------+--------------------------------------------+-------------------+---------------------------+--------------+-------+
| 11111111     | José Manuel Cano     | josemanuelcano.ingles@iespacomolla.es      | 644857468         | 1966-12-15                |            2 |     2 |
| 11111114     | Jésica Sánchez       | jesicasanchez.informatica@iespacomolla.es  | 987712439         | 1970-06-12                |            1 |    10 |
| 11111126     | Sonia Tovar Francés  | soniatovar.informatica@iespacomolla.es     | 644427758         | 1966-02-06                |            1 |    10 |
| 11111134     | Ricardo Canto        | ricardocanto.informatica@iespacomolla.es   | 655566999         | 1968-04-15                |            1 |    10 |
| 11111141     | José Ramón Más       | josemanuelcano.informatica@iespacomolla.es | 621498877         | 1969-02-05                |         NULL |  NULL |
+--------------+----------------------+--------------------------------------------+-------------------+---------------------------+--------------+-------+

 */

-- -------------CONCESIONARIO--------------

/*1. Crea una vista llamada COCHES_DISPONIBLES que almacene el nº
de coches totales que tiene cada concesionario, que será la suma
entre sus coches distribuidos. Haz una consulta sobre la vista y pon la
captura */

SELECT * FROM CONCE_DISTRIBUCION;

CREATE OR REPLACE VIEW COCHES_DISPONIBLES(CONCESIONARIO,Stock) AS
SELECT conce.CIF,IFNULL(SUM(CANTIDAD),0)
FROM CONCE_CONCESIONARIO AS conce
LEFT JOIN CONCE_DISTRIBUCION distr ON conce.CIF = distr.CONCESIONARIO
GROUP BY conce.CIF
ORDER BY SUM(CANTIDAD) ASC;

SELECT * FROM COCHES_DISPONIBLES;

/*
+---------------+-------+
| CONCESIONARIO | Stock |
+---------------+-------+
|      11232123 |     0 |
|      76543213 |     0 |
|      44554433 |     4 |
|      56429642 |     8 |
|      54345432 |    12 |
|      77323232 |    13 |
|      85643123 |    14 |
|      85543123 |    14 |
|      32323232 |    17 |
|      98654678 |    23 |
|      11111111 |    28 |
|       1222222 |    53 |
+---------------+-------+
 */

/*
2. Inserta en la vista anterior 23 coches para el concesionario 98654678.
¿Funciona? ¿Por qué? ¿Qué tendrías que cambiar para que
funcionara?
 */

/* No, no se puede insertar directamente en una vista porque estas no son tablas físicas.
   Para insertar, debemos hacerlo en la tabla subyacente, en este caso CONCE_DISTRIBUCION
 */

INSERT INTO CONCE_DISTRIBUCION VALUES (98654678,'KCEED',23);


/*
3. Inserta, en la tabla distribución, dos SEAT Ibiza para cada
concesionario de Elda o Petrer.
2 filas insertadas
 */
    INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
    SELECT CIF, 'IBIZA', 2
    FROM CONCE_CONCESIONARIO
    WHERE CIUDAD IN ('Elda', 'Petrer');


/*
4. Muestra los resultados de la vista anterior. ¿Han cambiado? Explica
por qué. Haz una captura.
 */

SELECT * FROM CONCE_DISTRIBUCION;
/*
+---------------+--------+----------+
| CONCESIONARIO | COCHE  | CANTIDAD |
+---------------+--------+----------+
|       1222222 | IBIZA  |        2 |
|       1222222 | KCEED  |       14 |
|       1222222 | KRIO   |       25 |
|       1222222 | KSPORT |       12 |
|      11111111 | BMWe34 |        5 |
|      11111111 | BMWe46 |       11 |
|      11111111 | BMWe86 |       10 |
|      11111111 | IBIZA  |        2 |
|      32323232 | IBIZA  |       17 |
|      44554433 | A3     |        4 |
|      54345432 | A3     |        9 |
|      54345432 | A5     |        3 |
|      56429642 | IBIZA  |        8 |
|      77323232 | C5C    |        7 |
|      77323232 | NISQA  |        6 |
|      85543123 | KCEED  |        9 |
|      85543123 | NISQA  |        5 |
|      85643123 | IBIZA  |        6 |
|      85643123 | NISPU  |        8 |
|      98654678 | KCEED  |       23 |
+---------------+--------+----------+

 */
/*
 Si, el resultado cambias automaticamente porque las vistas son dinámicas
 y se ejecutan cada vez que se acceden, en mi caso es igual, porque haciendo el ejercicio
 lo ejecuté
 */
-- -------------LISTAS--------------

/*
1. Crea una vista que sea “Cantantescountry”, con el nombre de todos
los artistas que tengan alguna canción que pertenezca a algún género
que contenga la palabra country.
 */
CREATE VIEW Cantantescountry AS
SELECT DISTINCT LA.NOMBREREAL
FROM LISTAS_ARTISTAIND LA
         JOIN LISTAS_CANCION LC ON LA.COD = LC.COD_ARTISTA
         JOIN LISTAS_GENERO_CANCION LGC ON LC.COD = LGC.COD_CANCION
         JOIN LISTAS_GENERO LG ON LGC.COD_GENERO = LG.COD
WHERE LG.NOMBRE LIKE '%country%';

SELECT * FROM Cantantescountry;

/*
+----------------------------+
| NOMBREREAL                 |
+----------------------------+
| Montero Lamar Hill         |
| Taylor Alison Swift        |
| Kenneth Donald Rogers      |
| Loretta Webb               |
| George Harvey Strait       |
| James Robert Wills         |
| Glen Travis Campbell       |
| Ellen Muriel Deason        |
| Hiram King Williams        |
| William Smith Monroe       |
| Alvis Edgar Owens Jr.      |
| Waylon Arnold Jennings     |
| Dolly Rebecca Parton       |
| Merle Ronald Haggard       |
| Ray Charles Robinson       |
| Virginia Wynette Pugh      |
| James Charles Rodgers      |
| George Glenn Jones         |
| Virginia Patterson Hensley |
| J. R. Cash                 |
| George Ivan Morrison       |
+----------------------------+
 */