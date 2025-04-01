

 
CREATE TABLE CICLOS_CICLO (
    COD INT PRIMARY KEY AUTO_INCREMENT,
    NOMBRE VARCHAR(50) NOT NULL UNIQUE,
    DESCRIPCION VARCHAR(50)
);



CREATE TABLE CICLOS_CURSO (
    COD_CICLO INT,
    CURSO NUMERIC(1),
    GRUPO VARCHAR(1),
    ABREVIATURA VARCHAR(10) UNIQUE,

    CONSTRAINT PK_CICLOS_CURSO PRIMARY KEY(COD_CICLO,CURSO,GRUPO),
    CONSTRAINT FK_COD_CICLO FOREIGN KEY(COD_CICLO) REFERENCES CICLOS_CICLO(COD)
);




CREATE TABLE CICLOS_PROFESORES (
    DNI INT AUTO_INCREMENT UNIQUE NOT NULL,
    NOMBRE VARCHAR(50) PRIMARY KEY,
    DEPARTAMENTO VARCHAR(25) NOT NULL,
    EMAIL VARCHAR(25),
    TELEFONO NUMERIC(9),
    FECHA_NACIMIENTO DATE,

    CONSTRAINT COMP_FECHA_NACI CHECK( FECHA_NACIMIENTO > STR_TO_DATE('01/01/1935','%d/%m/%Y')),
    CONSTRAINT COMP_TEL CHECK (TELEFONO > 0)
);
ALTER TABLE CICLOS_PROFESORES AUTO_INCREMENT=11111110;


CREATE TABLE CICLOS_MODULO(
	codigo INT AUTO_INCREMENT PRIMARY KEY,
    curso VARCHAR(7) NOT NULL,
    profesor VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
	nhorassem NUMERIC(5),

    
	CONSTRAINT chk_modulo CHECK(nhorassem>=0 AND nhorassem <=400),
    CONSTRAINT FK_MODULO_CURSO FOREIGN KEY(curso) REFERENCES CICLOS_CURSO(ABREVIATURA),
    CONSTRAINT FK_MODULO_PROFESORES FOREIGN KEY (profesor) REFERENCES CICLOS_PROFESORES(nombre),
    CONSTRAINT UQ_MODULO UNIQUE(curso,profesor,nombre)
);


CREATE TABLE CICLOS_DEPARTAMENTO(
    CODIGO NUMERIC(2) PRIMARY KEY,
    NOMBRE VARCHAR(25) UNIQUE,
    JEFE VARCHAR(25) NOT NULL,

    CONSTRAINT FK_JEFE FOREIGN KEY(JEFE) REFERENCES CICLOS_PROFESORES(NOMBRE)
);

ALTER TABLE CICLOS_PROFESORES ADD CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY(DEPARTAMENTO) REFERENCES CICLOS_DEPARTAMENTO(NOMBRE);

CREATE TABLE CICLOS_ALUMNO (
    NIA INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(15) NOT NULL,
    APELLIDOS VARCHAR(15) NOT NULL,
    FECHA_NACIMIENTO DATE NOT NULL,
    CICLO VARCHAR(7),
    
    CONSTRAINT FK_ALUMNO_CICLO FOREIGN KEY(CICLO) REFERENCES CICLOS_CURSO(ABREVIATURA),
    CONSTRAINT CK_FECHA_NACI CHECK(FECHA_NACIMIENTO < STR_TO_DATE('01/01/2009','%d/%m/%Y'))
);
ALTER TABLE CICLOS_ALUMNO AUTO_INCREMENT=11111113;



CREATE TABLE CICLOS_TRIMESTRE(
    CODIGO INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(30) NOT NULL,
    FECHA DATE
);


CREATE TABLE CICLOS_EVALUACION(
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    alumno INT NOT NULL,
    E1er_trimestre NUMERIC(3,1),
    E2º_trimestre NUMERIC(3,1),
    E3er_trimestre NUMERIC(3,1),
    CONSTRAINT FK_EVALUACION_ALUMNO FOREIGN KEY(alumno) REFERENCES CICLOS_ALUMNO(NIA)
);
CREATE TABLE CICLOS_NOTAS_MODULO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ALUMNO INT NOT NULL,
    MODULO INT NOT NULL,
    EVALUACION INT NOT NULL,
    NOTA NUMERIC(3,1),
    CONSTRAINT FK_NOTAS_ALUMNO FOREIGN KEY(ALUMNO) REFERENCES CICLOS_ALUMNO(NIA),
    CONSTRAINT FK_NOTAS_MODULO FOREIGN KEY(MODULO) REFERENCES CICLOS_MODULO(codigo),
    CONSTRAINT FK_NOTAS_EVALUACION FOREIGN KEY(EVALUACION) REFERENCES CICLOS_TRIMESTRE(CODIGO)
);


INSERT INTO CICLOS_NOTAS_MODULO (ALUMNO, MODULO, EVALUACION, NOTA) VALUES
(11111113, 1, 1, 7.5),
(11111114, 2, 1, 6.8),
(11111115, 3, 1, 9.0),
(11111116, 4, 1, 5.4),
(11111117, 5, 1, 8.2);



/*EJERCICIOS*/


/*CICLOS*/
INSERT INTO CICLOS_CICLO(nombre, descripcion) VALUES ('CFGM SMR','Sistemas microinformáticos y redes');
INSERT INTO CICLOS_CICLO(nombre) VALUES ('CFGS ASIR');
INSERT INTO CICLOS_CICLO(nombre) VALUES ('CFGS DAW');
INSERT INTO CICLOS_CICLO(nombre) VALUES ('CFGS DAM');
INSERT INTO CICLOS_CICLO(nombre) VALUES ('Curso especialización de videojuegos');
INSERT INTO CICLOS_CICLO(nombre) VALUES ('CFGS DAW Semipresencial');
/*CURSO*/

DESC CICLOS_CURSO;
INSERT INTO CICLOS_CURSO VALUES(1,1,'A','1SMRA');
INSERT INTO CICLOS_CURSO VALUES(1,1,'B','1SMRB');
INSERT INTO CICLOS_CURSO VALUES(1,1,'C','1SMRC');
INSERT INTO CICLOS_CURSO VALUES(1,2,'A','2SMRA');
INSERT INTO CICLOS_CURSO VALUES(1,2,'B','2SMRB');
INSERT INTO CICLOS_CURSO VALUES(1,2,'C','2SMRC');
INSERT INTO CICLOS_CURSO VALUES(2,1,'A','1ASIRA');
INSERT INTO CICLOS_CURSO VALUES(2,1,'B','1ASIRB');
INSERT INTO CICLOS_CURSO VALUES(2,1,'C','1ASIRC');
INSERT INTO CICLOS_CURSO VALUES(2,2,'A','2ASIRA');
INSERT INTO CICLOS_CURSO VALUES(2,2,'B','2ASIRB');
INSERT INTO CICLOS_CURSO VALUES(2,2,'C','2ASIRC');
INSERT INTO CICLOS_CURSO VALUES(3,1,'A','1DAWA');
INSERT INTO CICLOS_CURSO VALUES(3,1,'B','1DAWB');
INSERT INTO CICLOS_CURSO VALUES(3,1,'C','1DAWC');
INSERT INTO CICLOS_CURSO VALUES(3,2,'A','2DAWA');
INSERT INTO CICLOS_CURSO VALUES(3,2,'B','2DAWB');
INSERT INTO CICLOS_CURSO VALUES(3,2,'C','2DAWC');
INSERT INTO CICLOS_CURSO VALUES(4,1,'A','1DAMA');
INSERT INTO CICLOS_CURSO VALUES(4,1,'B','1DAMB');
INSERT INTO CICLOS_CURSO VALUES(4,1,'C','1DAMC');
INSERT INTO CICLOS_CURSO VALUES(4,2,'A','2DAMA');
INSERT INTO CICLOS_CURSO VALUES(4,2,'B','2DAMB');
INSERT INTO CICLOS_CURSO VALUES(4,2,'C','2DAMC');
INSERT INTO CICLOS_CURSO VALUES(5,1,'A','1ESPVIDEO');
INSERT INTO CICLOS_CURSO VALUES(5,2,'A','2ESPVIDEO');
INSERT INTO CICLOS_CURSO VALUES(6,1,'A','1DAWSEMI');
INSERT INTO CICLOS_CURSO VALUES(6,2,'A','2DAWSEMI');

/*PROFESORES*/


ALTER TABLE CICLOS_PROFESORES DROP FOREIGN KEY FK_DEPARTAMENTO;

INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('José Manuel Cano', 'Inglés');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Ramón Galinsoga', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Paco Ribera', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Jésica Sánchez (Prof.Inform 12)', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Juan José Vidal', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('David Ponce', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Miguel Ángel Aguilar', 'FOL');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Valentín Martínez (Prof.sistemas 12)', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Fernando Íñigo', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Samuel Hernández', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Raúl Marín', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Prof.sistemas 13', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Julio Garay', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Godofredo Folgado', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Marga Martínez', 'FOL');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Sonia Tovar', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Ana J. Martínez', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Ángel Martínez', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Javi Llorens', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Sandra Deltell', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Vicente Peñataro', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Roberto Bernabéu', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Ricardo Lucas', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Ricardo Cantó', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Lidia Cerdán', 'Inglés');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Miguel Sánchez', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Miguel Ángel Tomás', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Mercedes Poveda', 'Inglés');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Mª Rosa Aravid', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Silvia Amorós', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('José Ramón Más', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Juan Carlos Gómez', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Tasio Mateos', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Prof. Inf. 19', 'Informática');
INSERT INTO CICLOS_PROFESORES(NOMBRE, DEPARTAMENTO) VALUES ('Inma Climent', 'FOL');
SELECT * FROM CICLOS_PROFESORES;

ALTER TABLE CICLOS_PROFESORES
ADD COLUMN salario INT GENERATED ALWAYS AS (2000+46* FLOOR(antig/3.0));
DESC CICLOS_PROFESORES;
SELECT * FROM CICLOS_PROFESORES;

/*modulo*/



INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Sandra Deltell','LENM', 25);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Inma Climent','FOL', 22);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Ricardo Cantó','Entornos de Desarrollo', 30);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Lidia Cerdán','Inglés', 20);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Sandra Deltell','Base de Datos', 27);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','David Ponce','Sistemas Informáticos', 32);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Ricardo Cantó','Programación', 35);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('1DAMA','Ricardo Cantó','Tutoría', 12);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Lidia Cerdán','Inglés', 20);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Godofredo Folgado','PSER', 25);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Marga Martínez','EIE', 22);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Javi Llorens','PMUL', 30);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Roberto Bernabéu','SGES', 27);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Ricardo Cantó','AD', 32);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Miguel Sánchez','DINT', 35);
INSERT INTO CICLOS_MODULO(curso,profesor,nombre,nhorassem) VALUES('2DAMA','Miguel Sánchez','Tutoría', 12);


/*DEPARTAMENTO*/
INSERT INTO CICLOS_DEPARTAMENTO VALUES (1,'Informática','Ricardo Lucas');
INSERT INTO CICLOS_DEPARTAMENTO VALUES (2,'Inglés','José Manuel Cano');
INSERT INTO CICLOS_DEPARTAMENTO VALUES (3,'FOL','Marga Martínez');
ALTER TABLE CICLOS_PROFESORES ADD CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY(DEPARTAMENTO) REFERENCES CICLOS_DEPARTAMENTO(NOMBRE);

/*ALUMNOS*/
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Bill','Gates',STR_TO_DATE('20/09/1995','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('James','Cameron',STR_TO_DATE('23/07/1993','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Steve','Jobs',STR_TO_DATE('21/12/1998','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Larry','Page',STR_TO_DATE('24/11/2003','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Sergey','Brin',STR_TO_DATE('25/06/1999','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Mark','Zuckerberg',STR_TO_DATE('29/04/1984','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Jeff','Bezos',STR_TO_DATE('10/05/1991','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Dennis','Ritchie',STR_TO_DATE('20/01/1992','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO(NOMBRE,APELLIDOS,FECHA_NACIMIENTO,CICLO) VALUES ('Alan','Turing',STR_TO_DATE('30/12/1986','%d/%m/%Y'),'1DAMA');
INSERT INTO CICLOS_ALUMNO (NOMBRE, APELLIDOS, FECHA_NACIMIENTO, CICLO) VALUES
                                                                           ('Juan', 'Pérez', STR_TO_DATE('15/05/2000', '%d/%m/%Y'), '2DAMA'),
                                                                           ('María', 'García', STR_TO_DATE('20/08/2001', '%d/%m/%Y'), '2DAMA'),
                                                                           ('Carlos', 'López', STR_TO_DATE('10/12/1999', '%d/%m/%Y'), '2DAMA'),
                                                                           ('Ana', 'Martínez', STR_TO_DATE('05/03/2002', '%d/%m/%Y'), '2DAMA'),
                                                                           ('Luis', 'Rodríguez', STR_TO_DATE('25/07/2000', '%d/%m/%Y'), '2DAMA');
INSERT INTO CICLOS_ALUMNO (NOMBRE, APELLIDOS, FECHA_NACIMIENTO, CICLO) VALUES
                                                                           ('Juan', 'Pérez', STR_TO_DATE('15/05/2000', '%d/%m/%Y'), '1SMRA'),
                                                                           ('María', 'García', STR_TO_DATE('20/08/2001', '%d/%m/%Y'), '1SMRA'),
                                                                           ('Carlos', 'López', STR_TO_DATE('10/12/1999', '%d/%m/%Y'), '1SMRA'),
                                                                           ('Ana', 'Martínez', STR_TO_DATE('05/03/2002', '%d/%m/%Y'), '1SMRA'),
                                                                           ('Luis', 'Rodríguez', STR_TO_DATE('25/07/2000', '%d/%m/%Y'), '1SMRA');


SELECT * FROM CICLOS_ALUMNO;
/*TRIMESTRE*/

INSERT INTO CICLOS_TRIMESTRE(NOMBRE,FECHA) VALUES('1er trimestre 22/33',STR_TO_DATE('22/12/2022','%d/%m/%Y'));
INSERT INTO CICLOS_TRIMESTRE(NOMBRE,FECHA) VALUES('2º trimestre 22/33',STR_TO_DATE('16/03/2023','%d/%m/%Y'));
INSERT INTO CICLOS_TRIMESTRE(NOMBRE,FECHA) VALUES('3er trimestre 22/33',STR_TO_DATE('19/06/2023','%d/%m/%Y'));
/*J*/
INSERT INTO CICLOS_EVALUACION(alumno,E1er_trimestre) VALUES(11111118,5.6);
INSERT INTO CICLOS_EVALUACION(alumno,E1er_trimestre) VALUES(11111120,8.2);
INSERT INTO CICLOS_EVALUACION(alumno,E1er_trimestre) VALUES(11111121,3.4);
SELECT * FROM CICLOS_ALUMNO;
/*K*/
UPDATE CICLOS_MODULO 
SET PROFESOR='Ramón Galinsoga'
WHERE CURSO='1DAMA' AND nombre='Tutoría';
UPDATE CICLOS_MODULO 
SET PROFESOR='Sandra Deltell'
WHERE CURSO='2DAMA' AND nombre='Tutoría';
/*L*/

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('15-12-1966','%d-%m-%Y')
WHERE NOMBRE='Sandra Deltell';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('04-12-1977','%d-%m-%Y')
WHERE NOMBRE='Ramón Galinsoga';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('04-12-1977','%d-%m-%Y')
WHERE NOMBRE='Roberto Bernabéu';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('09-04-1939','%d-%m-%Y')
WHERE NOMBRE='Julio Garay';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('30-04-1977','%d-%m-%Y')
WHERE NOMBRE='Mª Rosa Aravid';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('15-07-1972','%d-%m-%Y')
WHERE NOMBRE='Samuel Hernández';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('07-03-1964','%d-%m-%Y')
WHERE NOMBRE='Tasio Mateos';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('26-02-1959','%d-%m-%Y')
WHERE NOMBRE='Juan José Vidal';

UPDATE CICLOS_PROFESORES
SET FECHA_NACIMIENTO=STR_TO_DATE('10-07-1979','%d-%m-%Y')
WHERE NOMBRE='David Ponce';
/*M*/
UPDATE CICLOS_EVALUACION
SET E1er_trimestre = E1er_trimestre + 1
WHERE E1er_trimestre >=5;


/*N*/
/*
En ciclos curso le he añadido unique a Abreviatura para después hacer una FK en ciclos_modulo.
He añadido varias secuencias para auto incrementar valores, he añadido ciclos_modulo, ya que mi DLL no lo tenía.
Añadí la columna CICLO a CICLOS_ALUMNO, cree la tabla CICLOS_TRIMESTRE, porque no la tenía tampoco y añadí los trimestres a CICLOS_EVALUACION.
*/
/*M*/
/*Añadiría una entidad Matriculación para que se pueda almacenar la fecha de matriculación y el alumno para tener la matrícula también almacenada.

