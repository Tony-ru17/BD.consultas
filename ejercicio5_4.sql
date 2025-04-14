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
DROP VIEW Tutoresporcurso;
SELECT * FROM CICLOS_CURSO;



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
3. Elimina de la tabla de profesores aquellos que no impartan ningún
módulo, no sean jefes de departamento ni tutores. (exists)
 */
INSERT INTO CICLOS_PROFESOR(dni, nombre) VALUES('999999999','Prueba');
INSERT INTO CICLOS_CURSO(numero,grupo,codigo_ciclo,tutor_curso) VALUES(9,'B',1,'999999999');
DELETE FROM CICLOS_CURSO
WHERE tutor_curso='999999999';




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

SELECT * FROM CICLOS_PROFESOR
WHERE dni='999999999';

/*
4. Crea una vista “Notas medias” con las notas medias por trimestre y
módulo, almacenando la nota únicamente con dos decimales */

SELECT SUM(ev.codigoModulo)
FROM CICLOS_EVALUACION ev
JOIN CICLOS_TRIMESTRE trim ON ev.codigoTrimestre=trim.codigo_trimestre
JOIN CICLOS_MODULO modulo ON ev.codigoModulo = modulo.cod_modulo
GROUP BY ev.codigoTrimestre;

SELECT * FROM CICLOS_EVALUACION
ORDER BY codigoTrimestre;





/*5. Crea una vista “Posibles jubilaciones” con los profesores que sean
posibles jubilados, es decir, que tengan 55 años o más.*/
-- -------------CONCESIONARIO--------------

/*1. Crea una vista llamada COCHES_DISPONIBLES que almacene el nº
de coches totales que tiene cada concesionario, que será la suma
entre sus coches distribuidos. Haz una consulta sobre la vista y pon la
captura */


/*
2. Inserta en la vista anterior 23 coches para el concesionario 98654678.
¿Funciona? ¿Por qué? ¿Qué tendrías que cambiar para que
funcionara?
 */


/*
3. Inserta, en la tabla distribución, dos SEAT Ibiza para cada
concesionario de Elda o Petrer.
2 filas insertadas
 */


/*
4. Muestra los resultados de la vista anterior. ¿Han cambiado? Explica
por qué. Haz una captura.
 */

-- -------------LISTAS--------------

/*
1. Crea una vista que sea “Cantantescountry”, con el nombre de todos
los artistas que tengan alguna canción que pertenezca a algún género
que contenga la palabra country.
 */