-- Creación de las tablas

CREATE TABLE CICLOS_CICLO (
    codigo DECIMAL(5,0) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    abreviatura_ciclo VARCHAR(100) NOT NULL,
    CONSTRAINT CK_CODIGO_CICLO CHECK(codigo BETWEEN 00000 AND 99999)
);

CREATE TABLE CICLOS_CURSO (
    numero DECIMAL(1),
    grupo VARCHAR(4), 
    codigo_ciclo DECIMAL(5,0) NOT NULL,
    abreviatura VARCHAR(50),
    CONSTRAINT FK_CODIGO_CICLO FOREIGN KEY (codigo_ciclo) REFERENCES CICLOS_CICLO(codigo),
    CONSTRAINT PK_CURSO PRIMARY KEY (numero, grupo, codigo_ciclo)
);

CREATE TABLE CICLOS_MODULO (
    cod_modulo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    numero_horas_totales DECIMAL(3,0) NOT NULL,
    CONSTRAINT CK_NUMHORAS CHECK( numero_horas_totales > 0)
);

CREATE TABLE CICLOS_PROFESOR (
    dni VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    email VARCHAR(80),
    telefono VARCHAR(12),
    fecha_nacimiento DATE
);

ALTER TABLE CICLOS_CURSO ADD (tutor_curso VARCHAR(10)  UNIQUE REFERENCES CICLOS_PROFESOR(dni));


CREATE TABLE CICLOS_DEPARTAMENTO (
    codigo DECIMAL(10) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    jefe_departamento VARCHAR(10) UNIQUE,
    CONSTRAINT FK_JEFE_DEP FOREIGN KEY (jefe_departamento) REFERENCES CICLOS_PROFESOR(dni)
);

ALTER TABLE CICLOS_PROFESOR ADD (departamento DECIMAL(10) REFERENCES CICLOS_DEPARTAMENTO(codigo));

CREATE TABLE CICLOS_IMPARTIR (
    codigo_modulo VARCHAR(10),
    codigo_ciclo DECIMAL(5,0),
    numero_curso DECIMAL(1), 
    grupo_curso VARCHAR(3),
    dni_profesor VARCHAR(10) NOT NULL,
    numero_horas_semanales DECIMAL(2,0) NOT NULL,
    CONSTRAINT FK_DNI_PROFESOR FOREIGN KEY (dni_profesor) REFERENCES CICLOS_PROFESOR(dni),
    CONSTRAINT FK_MODULO FOREIGN KEY (codigo_modulo) REFERENCES CICLOS_MODULO(cod_modulo),
    CONSTRAINT CK_HORAS CHECK( numero_horas_semanales > 0),
    CONSTRAINT FK_CURSO FOREIGN KEY (codigo_ciclo, numero_curso, grupo_curso) REFERENCES CICLOS_CURSO (codigo_ciclo, numero, grupo), 
    CONSTRAINT PK_IMPARTIR PRIMARY KEY (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso)
);


CREATE TABLE CICLOS_ALUMNO (
    dni VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    email VARCHAR(80) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(12),
    codigo_ciclo DECIMAL(5,0),
    numero_curso DECIMAL(1),
    grupo_curso VARCHAR(3),
    CONSTRAINT FK_MATRICULA FOREIGN KEY (numero_curso,grupo_curso,codigo_ciclo) REFERENCES CICLOS_CURSO(numero, grupo, codigo_ciclo)
);


CREATE TABLE CICLOS_TRIMESTRE (
    codigo_trimestre DECIMAL(5,0) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT CK_CODIGO CHECK( codigo_trimestre BETWEEN 00000 AND 99999)
);

CREATE TABLE CICLOS_EVALUACION (
    dniAlumno VARCHAR(10),
    codigoModulo VARCHAR(10),
    codigoTrimestre DECIMAL(5,0),
    nota DECIMAL(4,2) NOT NULL,
    CONSTRAINT FK_EVALUACION_ALUMNO FOREIGN KEY (dniAlumno) REFERENCES CICLOS_ALUMNO(dni),
    CONSTRAINT FK_EVALUACION_MODULO FOREIGN KEY (codigoModulo) REFERENCES CICLOS_MODULO(cod_modulo),
    CONSTRAINT FK_EVALUACION_TRIMESTRE FOREIGN KEY (codigoTrimestre) REFERENCES CICLOS_TRIMESTRE(codigo_trimestre),
    CONSTRAINT CK_NOTA CHECK (nota >= 0),
    CONSTRAINT PK_EVALUACION PRIMARY KEY (dniAlumno, codigoModulo, codigoTrimestre)
);



-- Creación de MÁS restricciones

/*ALTER TABLE CICLOS_PROFESOR ADD (CONSTRAINT CK_fecha_correcta CHECK (fecha_nacimiento >= TO_DATE ('01-01-1955', 'dd-mm-yyyy')));*/

ALTER TABLE CICLOS_CURSO ADD (CONSTRAINT CK_numero_curso_correcto CHECK (numero_curso = 1 OR numero_curso = 2));

ALTER TABLE CICLOS_IMPARTIR ADD (CONSTRAINT CK_horas_semanales_correctas CHECK (numero_horas_semanales >= 0 AND numero_horas_semanales <= 10));

ALTER TABLE CICLOS_MODULO ADD (CONSTRAINT CK_horas_totales_correctas CHECK (numero_horas_totales >= 0 AND numero_horas_totales <= 400));

ALTER TABLE CICLOS_DEPARTAMENTO ADD (CONSTRAINT UK_nombre UNIQUE (nombre));


--INSERCIÓN DE DATOS
--Tabla Ciclos
INSERT INTO CICLOS_CICLO
VALUES (1, 'CFGM SMR', 'Sistemas microinformáticos y redes');
INSERT INTO CICLOS_CICLO
VALUES (2, 'CFGS ASIR', 'Administración de Sistemas Informáticos en Red');
INSERT INTO CICLOS_CICLO
VALUES (3, 'CFGS DAW', 'Desarrollo de Aplicaciones Web');
INSERT INTO CICLOS_CICLO
VALUES (4, 'CFGS DAM', 'Desarrollo de Aplicaciones Multiplataforma');
INSERT INTO CICLOS_CICLO
VALUES (5, 'Curso especialización de videojuegos', 'Curso de especialización de videojuegos y realidad virtual');

--Tabla Curso
INSERT INTO CICLOS_CURSO (numero,codigo_ciclo,grupo,abreviatura) VALUES (1, 1, 'A', '1SMRA');
INSERT INTO CICLOS_CURSO (numero,codigo_ciclo,grupo,abreviatura) VALUES (1,1,'B','1SMRB');
insert into CICLOS_CURSO (numero,codigo_ciclo,grupo,abreviatura) values (1, 1, 'C', '1SMRC');
INSERT INTO CICLOS_CURSO (numero, grupo_curso, codigo_ciclo, abreviatura) VALUES ( 2, 'B', 1, '2SMRB');
INSERT INTO CICLOS_CURSO (codigo_ciclo, numero, grupo, abreviatura) VALUES (1,  2, 'C','2SMRC');
INSERT INTO CICLOS_CURSO (numero, grupo, codigo_ciclo, abreviatura) VALUES (1, 'A', 4, '1DAM');

INSERT INTO CICLOS_CURSO (numero,grupo,codigo_ciclo,abreviatura) VALUES (2,'A',4,'2DAMA');
INSERT INTO CICLOS_CURSO (numero,grupo,codigo_ciclo,abreviatura) VALUES (2,'A',2,'2ASIRA');
INSERT INTO CICLOS_CURSO (codigo_ciclo, numero, grupo, abreviatura) VALUES (3, 2, 'A', '2DAWA');
insert into CICLOS_CURSO(numero,grupo,codigo_ciclo,abreviatura) values(1,'A',5,'Videojuego');
INSERT INTO CICLOS_CURSO (codigo_ciclo,numero, grupo, abreviatura) VALUES(3, 1, 'Sem', '1DAWSemi');
INSERT INTO CICLOS_CURSO (numero, grupo, codigo_ciclo, abreviatura) VALUES (1, 'A', 3, '1DAW');
INSERT INTO CICLOS_CURSO (codigo_ciclo,grupo,numero, abreviatura) VALUES(2,'A',1,'1ASIRA');

--Tabla Módulo 
--1ºSMR
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('0221', 'Montaje y mantenimiento de equipos', 224);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('0225', 'Redes locales', 224);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('0223', 'Aplicaciones ofimáticas', 224);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('0222', 'Sistemas operativos monopuesto', 128);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('0229', 'Formación y Orientación Laboral', 96);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales) VALUES ('CV0001', 'Inglés Técnico I-M', 64);

--2ºSMR
INSERT INTO CICLOS_MODULO VALUES ('0224', 'Sistemas operativos en red', 176);
INSERT INTO CICLOS_MODULO VALUES ('0226', 'Seguridad informática', 110);
INSERT INTO CICLOS_MODULO VALUES ('0227', 'Servicios en red', 176);
INSERT INTO CICLOS_MODULO VALUES ('0228', 'Aplicaciones web', 88);
INSERT INTO CICLOS_MODULO VALUES ('0230', 'Empresa e iniciativa emprendedora', 66);
INSERT INTO CICLOS_MODULO VALUES ('CV0002', 'Inglés Técnico II-M', 44);
INSERT INTO CICLOS_MODULO VALUES ('0231', 'Formación en Centros de Trabajo', 380);

--1ºDAM
INSERT INTO CICLOS_MODULO VALUES ('0373','Lenguajes de marcas y sistemas de gestión de información',96);
INSERT INTO CICLOS_MODULO VALUES ('0483','Sistemas informáticos',160);
INSERT INTO CICLOS_MODULO VALUES ('0484','Bases de Datos',160);
INSERT INTO CICLOS_MODULO VALUES ('0485','Programación',96);
INSERT INTO CICLOS_MODULO VALUES ('0487','Entornos de desarrollo',96);
INSERT INTO CICLOS_MODULO VALUES ('0493','Formación y Orientación Laboral',96);
INSERT INTO CICLOS_MODULO VALUES ('CV0003','Inglés Técnico I-S',96);

--2ºDAM
insert into CICLOS_MODULO values ('CV0004','Inglés Técnico II-S',120);
insert into CICLOS_MODULO values ('0490','Programación de servicios y procesos',60);
insert into CICLOS_MODULO values ('0494','Empresa e iniciativa emprendedora',60);
insert into CICLOS_MODULO values ('0489','Programación multimedia y dispositivos móviles',100);
insert into CICLOS_MODULO values ('0491','Sistemas de gestión empresarial',100);
insert into CICLOS_MODULO values ('0486','Acceso a datos',120);
insert into CICLOS_MODULO values ('0488','Desarrollo de interfaces',120);
INSERT INTO CICLOS_MODULO VALUES ('0495', 'Formación en Centros de Trabajo', 400);
INSERT INTO CICLOS_MODULO VALUES ('0492', 'Proyecto de desarrollo de aplicaciones Multiplataforma', 40);

--1ºDAW
--Son los mismos que 1ºDAM
INSERT INTO CICLOS_MODULO VALUES ('0617','Formación y Orientación Laboral',96);

--2ºDAW
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0612', 'Desarrollo web en entorno cliente', 140);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0613', 'Desarrollo en entorno servidor', 160);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0614', 'Despliegue de aplicaciones web', 80);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0615', 'Diseño de interfaces web', 120);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0618', 'Empresa e iniciativa emprendedora', 60);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0616', 'Proyecto de desarrollo de aplicaciones', 40);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0619', 'Formación en Centros de Trabajo', 400);

--1ºASIR
INSERT INTO CICLOS_MODULO VALUES('0370','Planificación de sistemas operativos' , 192);
INSERT INTO CICLOS_MODULO VALUES('0369','Implantación de sistemas operativos' , 224);
INSERT INTO CICLOS_MODULO VALUES('0371','Fundamentos de Hardware' , 96);
INSERT INTO CICLOS_MODULO VALUES('0372','Gestión de bases de datos' , 160);
INSERT INTO CICLOS_MODULO VALUES('0380','Formación y orientación laboral' , 96);

--2ºASIR
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0374','Administración de sistemas operativos',120);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0375','Servicios de red e Internet',120);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0376','Implantación de aplicaciones web',100);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0377','Administración de sistemas gestores de bases de datos',60);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0378','Seguridad y alta disponibilidad',100);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0381','Empresa e iniciativa emprendedora',60);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0382','Formación en centros de trabajo',400);
INSERT INTO CICLOS_MODULO (codigo, nombre, numero_horas_totales)
VALUES ('0379','Proyecto de administración de sistemas informáticos en red',40);

--Especialización de videojuegos
insert into CICLOS_MODULO (codigo, nombre, numero_horas_totales) values(5048,'Programación y motores de viedojuegos',150);
insert into CICLOS_MODULO (codigo, nombre, numero_horas_totales) values(5049,'Diseño gráfico 2D y 3D ',150);
insert into CICLOS_MODULO (codigo, nombre, numero_horas_totales) values(5050,'Programación en red e inteligencia artifical ',150);
insert into CICLOS_MODULO (codigo, nombre, numero_horas_totales) values(5051,'Realidad virtual y realidad aumentada',150);
insert into CICLOS_MODULO (codigo, nombre, numero_horas_totales) values(5052,'Gestión, publicación y producción',150);

-- Inserciones de los departamentos
INSERT INTO CICLOS_DEPARTAMENTO (codigo, nombre) VALUES (1, 'Informática');
INSERT INTO CICLOS_DEPARTAMENTO (codigo, nombre)  VALUES (2, 'Inglés');
INSERT INTO CICLOS_DEPARTAMENTO (codigo, nombre)  VALUES (3, 'FOL');

--Tabla Profesor
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111111, 'José Manuel Cano', 'josemanuelcano.ingles@iespacomolla.es', 644857468, STR_TO_DATE('14/06/1975','%d/%m/%Y'),2);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111117, 'Miguel Ángel Aguilar Pérez', 'miguelangelaguilar.fol@iespacomolla.es', 644837468, STR_TO_DATE('17/10/1982','%d/%m/%Y'),3);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111126, 'Sonia Tovar Francés', 'soniatovar.informatica@iespacomolla.es', 644427758, STR_TO_DATE('02/11/1985','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111120, 'Samuel Hernández Romero', 'samuelhernandez.informatica@iespacomolla.es', 644747595, STR_TO_DATE('22/01/1973','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111128, 'Ángel Martínez Arques', 'angelmartinez.informatica@iespacomolla.es', 647447665, STR_TO_DATE('28/07/1979','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111133, 'Ricardo Lucas Gómez', 'ricardolucas.informatica@iespacomolla.es', 647447665, STR_TO_DATE('18/08/1972','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR(dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111125, 'Marga Martínez', 'margamartinez.fol@iespacomolla.es', 647446885, STR_TO_DATE('16/11/1981','%d/%m/%Y'),2);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111112, 'Inma Climent', 'inmaculadacliment.fol@iespacomolla.es', 971403768, STR_TO_DATE('23/04/1985', '%d/%m/%Y'), 3);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111113, 'Paco Ribera', 'pacoribera.informatica@iespacomolla.es', 152398710, STR_TO_DATE('05/11/1990', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111114, 'Jésica Sánchez', 'jesicasanchez.informatica@iespacomolla.es', 987712439, STR_TO_DATE('12/06/1970', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111115, 'Juan José Vidal', 'juanjosevidal.informatica@iespacomolla.es', 547123786, STR_TO_DATE('11/02/1988', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111116, 'David Ponce', 'davidponce.informatica@iespacomolla.es', 976632918, STR_TO_DATE('01/09/1991', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111130, 'Sandra Deltell', 'sandradeltell.informatica@iespacomolla.es', 654321000, STR_TO_DATE('10/02/1990','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111134, 'Ricardo Canto', 'ricardocanto.informatica@iespacomolla.es', 655566999, STR_TO_DATE('15/04/1968','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
VALUES (11111135, 'Lidia Cerdan', 'lidiacerdan.ingles@iespacomolla.es', 625999874, STR_TO_DATE('25/04/1990','%d/%m/%Y'),2);
insert into CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
values (11111121, 'Raúl Marín', 'raulmarin.informatica@gmail.com', 745621935, STR_TO_DATE('06/04/1992', '%d/%m/%Y'), 1);
insert into CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
values (11111118, '1ºSMR Prof 12 - TARDE', 'profesorsistematarde.informatica@gmail.com', 658432756, STR_TO_DATE('21/10/1985', '%d/%m/%Y'), 1);
insert into CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
values (11111119, 'Fernando Íñigo', 'fernandoiñigo.informatica@gmail.com', 685236875, STR_TO_DATE('29/06/1974', '%d/%m/%Y'), 1);
insert into CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento) 
values (11111122, '1ºSMR Prof 13 - MAÑANA/TARDE', 'profesorsistemamañanatarde.informatica@gmail.com', 723541684, STR_TO_DATE('29/06/1974', '%d/%m/%Y'), 1);
insert into CICLOS_PROFESOR values (11111124,'Godofredo Folgado De La Rosa','godofredo@gmail.com',666666667,STR_TO_DATE('01/01/2001', '%d/%m/%Y'),1);
insert into CICLOS_PROFESOR values (11111129,'Javi Llorens Llorens','javi@gmail.com',666666668,STR_TO_DATE('01/01/2003', '%d/%m/%Y'),1);
insert into CICLOS_PROFESOR values (11111132,'Roberto Bernabéu Gómez','roberto@gmail.com',666666669,STR_TO_DATE('01/01/2006', '%d/%m/%Y'),1);
insert into CICLOS_PROFESOR values (11111136,'Miguel Sánchez Molina','miguel@gmail.com',666666611,STR_TO_DATE('01/01/2004', '%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111123,'Julio Garay','juliogaray.informatica@iespacomolla.es',965387384,STR_TO_DATE('05/06/1983','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111131,'Vicente Peñataro','vicentepenataro.informatica@iespacomolla.es',965387385,STR_TO_DATE('01/07/1988','%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111127, 'Ana J. Martínez', 'anamartinez.informatica@iespacomolla.es', 625147589, STR_TO_DATE ('20/10/1978', '%d/%m/%Y'),1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111142, 'Juan Carlos Gómez', 'juancarlosgomez.informatica@iespacomolla.es', 966313030, STR_TO_DATE('01/01/1998', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111138, 'Mercedes Poveda', 'mercedespoveda.ingles@iespacomolla.es', 966323030, STR_TO_DATE('01/01/1998', '%d/%m/%Y'), 2);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111137, 'Miguel Ángel Tomás', 'migueltomas.informatica@iespacomolla.es', 966333030, STR_TO_DATE('01/01/1998', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111139, 'Mº Rosa Aravid', 'mariarosaaravid.informatica@iespacomolla.es', 966343030, STR_TO_DATE('01/01/1998', '%d/%m/%Y'), 1);
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono,fecha_nacimiento, departamento)
VALUES (11111140, 'Silvia Amoros', 'silviaamoros.informatica@iespacomolla.es', 966353030, STR_TO_DATE('01/01/1998', '%d/%m/%Y'), 1);
insert into CICLOS_PROFESOR (dni, nombre) values (11111144, 'Prof. Inf 19');
insert into CICLOS_PROFESOR (dni, nombre) values (11111143, 'Tasio Mateo Martínez');
INSERT INTO CICLOS_PROFESOR (dni, nombre, email, telefono, fecha_nacimiento) VALUES (11111141, 'José Ramón Más', 'josemanuelcano.informatica@iespacomolla.es', 621498877, STR_TO_DATE('05/02/1969','%d/%m/%Y'));


-- Update de departamento
UPDATE CICLOS_DEPARTAMENTO SET jefe_departamento = '11111133' WHERE codigo = 1;
UPDATE CICLOS_DEPARTAMENTO SET jefe_departamento = '11111111' WHERE codigo = 2;
UPDATE CICLOS_DEPARTAMENTO SET jefe_departamento = '11111125' WHERE codigo = 3;

--Tabla Impartir
--1ºSMA
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0221', 1, 1, 'A', '11111116', 7);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0225', 1, 1, 'A', '11111114', 7);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0223', 1, 1, 'A', '11111115', 7);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0222', 1, 1, 'A', '11111113', 4);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0229', 1, 1, 'A', '11111112', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('CV0001', 1, 1, 'A', '11111111', 2);

--1ºSMRC
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('0221', 1, 1, 'C', '11111122', 7);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('0225', 1, 1, 'C', '11111119', 7);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('0223', 1, 1, 'C', '11111118', 7);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('0222', 1, 1, 'C', '11111121', 4);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('0229', 1, 1, 'C', '11111117', 3);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
values ('CV0001', 1, 1, 'C', '11111111', 2);

--2ºSMRB
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('CV0002', 1, 2, 'B', '11111111', 2);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0228', 1, 2, 'B', '11111126', 4);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0226', 1, 2, 'B', '11111126', 5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0230', 1, 2, 'B', '11111125', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0224', 1, 2, 'B', '11111127', 8);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0227', 1, 2, 'B', '11111128', 8);


--2ºSMRC
INSERT INTO CICLOS_IMPARTIR VALUES('CV0002', 1, 2, 'C', '11111111', 2);
INSERT INTO CICLOS_IMPARTIR VALUES('0224', 1, 2, 'C', '11111120', 8);
INSERT INTO CICLOS_IMPARTIR VALUES('0226', 1, 2, 'C', '11111126', 5);
INSERT INTO CICLOS_IMPARTIR VALUES('0227', 1, 2, 'C', '11111128', 8);
INSERT INTO CICLOS_IMPARTIR VALUES('0228', 1, 2, 'C', '11111126', 4);
INSERT INTO CICLOS_IMPARTIR VALUES('0230', 1, 2, 'C', '11111117', 3);

--1ºDAM
INSERT INTO CICLOS_IMPARTIR VALUES ('0373',4,1,'A','11111130',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0483',4,1,'A','11111116',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0484',4,1,'A','11111130',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0485',4,1,'A','11111134',8);
INSERT INTO CICLOS_IMPARTIR VALUES ('0487',4,1,'A','11111134',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0493',4,1,'A','11111112',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('CV0003',4,1,'A','11111135',3);

--2ºDAM
INSERT INTO CICLOS_IMPARTIR VALUES ('CV0004',4,2,'A','11111135',2);
INSERT INTO CICLOS_IMPARTIR VALUES ('0490',4,2,'A','11111124',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0494',4,2,'A','11111112',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0489',4,2,'A','11111129',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0491',4,2,'A','11111132',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0486',4,2,'A','11111134',6);
INSERT INTO CICLOS_IMPARTIR VALUES ('0488',4,2,'A','11111136',6);


--1ºASIR

INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0374',2,1,'A','11111132',6);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0375',2,1,'A','11111123',6);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0376',2,1,'A','11111129',5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0377',2,1,'A','11111133',3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0378',2,1,'A','11111131',5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0381',2,1,'A','11111112',3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('CV0004',2,1,'A','11111111',2);

--2ºASIR
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0374',2,2,'A','11111132',6);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0375',2,2,'A','11111123',6);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0376',2,2,'A','11111129',5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0377',2,2,'A','11111133',3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0378',2,2,'A','11111131',5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('0381',2,2,'A','11111125',3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo,codigo_ciclo,numero_curso,grupo_curso,dni_profesor,numero_horas_semanales)
VALUES ('CV0004',2,2,'A','11111111',2);

--1ºDAW semi
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0373', 3, 1, 'Sem', '11111130', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0493', 3, 1, 'Sem', '11111117', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0487', 3, 1, 'Sem', '11111143', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('CV0003', 3, 1, 'Sem', '11111138', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0484', 3, 1, 'Sem', '11111137', 5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0483', 3, 1, 'Sem', '11111127', 5);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales) VALUES ('0485', 3, 1, 'Sem', '11111141', 8);

--1ºDAW
INSERT INTO CICLOS_IMPARTIR VALUES ('0373',3,1,'A','11111137',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0483',3,1,'A','11111139',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0484',3,1,'A','11111140',5);
INSERT INTO CICLOS_IMPARTIR VALUES ('0485',3,1,'A','11111141',8);
INSERT INTO CICLOS_IMPARTIR VALUES ('0487',3,1,'A','11111119',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('0617',3,1,'A','11111117',3);
INSERT INTO CICLOS_IMPARTIR VALUES ('CV0003',3,1,'A','11111138',3);


--2ºDAW
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('CV0004', 3, 2, 'A', '11111138', 2);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0614', 3, 2, 'A', '11111140', 4);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0618', 3, 2, 'A', '11111125', 3);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0615', 3, 2, 'A', '11111139', 6);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0612', 3, 2, 'A', '11111142', 7);
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, dni_profesor, numero_horas_semanales)
VALUES ('0613', 3, 2, 'A', '11111137', 7);

--Curso de especialización
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso,numero_horas_semanales,dni_profesor) VALUES(5049,5,1,'A',5,'11111136');
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso,numero_horas_semanales,dni_profesor) VALUES(5049,5,1,'A',5,'11111144');
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso,numero_horas_semanales,dni_profesor) VALUES(5052,5,1,'A',4,'11111142');
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso,numero_horas_semanales,dni_profesor) VALUES(5052,5,1,'A',4,'11111121');
INSERT INTO CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso,numero_horas_semanales,dni_profesor) VALUES(5049,5,1,'A',5,'11111139');
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5052, 5, 1, 'A', 4, 11111144);
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5048, 5, 1, 'A', 5, '11111144');
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5051, 5, 1, 'A', 3, '11111143');
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5051, 5, 1, 'A', 3, '11111144');
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5050, 5, 1, 'A', 3, '11111121');
insert into CICLOS_IMPARTIR (codigo_modulo, codigo_ciclo, numero_curso, grupo_curso, numero_horas_semanales, dni_profesor) values (5050, 5, 1, 'A', 3, '11111144');

--Tabla Alumno
INSERT INTO CICLOS_ALUMNO VALUES('33111118', 'Sergey Brin', 'sergeybrin.alu@iespacomolla.es', STR_TO_DATE('25/06/1999', '%d/%m/%Y'), 644985214, 1, 2, 'C');
INSERT INTO CICLOS_ALUMNO VALUES('33111133', 'Juan Pablo Sierra', 'juanpablosierra.alu@iespacomolla.es', STR_TO_DATE('14/08/2000', '%d/%m/%Y'), 644974522, 1, 2, 'C');
INSERT INTO CICLOS_ALUMNO VALUES('33100951', 'Diana Soriano', 'dianasoriano.alu@iespacomolla.es', STR_TO_DATE('15/07/1999', '%d/%m/%Y'), 644914575, 1, 2, 'C');
INSERT INTO CICLOS_ALUMNO VALUES ('3511111125', 'Steve Wozniak', 'stevewozniak.alu@iespacomolla.es', STR_TO_DATE('10/07/1985', '%d/%m/%Y'), 752098879, 1, 1, 'A');
INSERT INTO CICLOS_ALUMNO 
VALUES ('3511111133', 'Diana Soriano', 'dianasoriano.alu@iespacomolla.es', STR_TO_DATE('15/07/1999', '%d/%m/%Y'), 644904503, 1, 1, 'A');
INSERT INTO CICLOS_ALUMNO 
VALUES ('3511111134', 'Isaac Julián Pavón', 'isaacjulianpavon.alu@iespacomolla.es', STR_TO_DATE('25/03/1995', '%d/%m/%Y'), 635535989, 1, 1, 'A');
INSERT INTO CICLOS_ALUMNO(dni,nombre, email,fecha_nacimiento,numero_curso,grupo_curso,codigo_ciclo) 
VALUES('11167115','Daniel Sanchez','danielsanchez@iespacolla.es', STR_TO_DATE('28/02/1997','%d/%m/%Y'),1,'A',4);
INSERT INTO CICLOS_ALUMNO(dni,nombre, email,fecha_nacimiento,numero_curso,grupo_curso,codigo_ciclo)
VALUES('11115515','Jose Alonso','josealonso@iespacolla.es', STR_TO_DATE('13/08/1995','%d/%m/%Y'),1,'A',4);
insert into CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
values ('11111120', 'Jeff Bezos', 'jeffbezos.alumno@iespacomolla.es', STR_TO_DATE ('10/05/1991', '%d/%m/%Y'), 632451751, 1, 1, 'C');
insert into CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
values ('32111111', 'Juan Pablo Sierra', 'juanpablosierra.alumno@iespacomolla.es', STR_TO_DATE ('02/06/2002', '%d/%m/%Y'), 765123489, 1, 1, 'C');
insert into CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
values ('33111111', 'Diana Soriano', 'dianasoriano.alumno@iespacomolla.es', STR_TO_DATE ('15/07/1999', '%d/%m/%Y'), 642587139, 1, 1, 'C');
insert into CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
values ('31111111', 'Pedro Sanchez', 'pedrosanchez.alumno@iespacomolla.es', STR_TO_DATE ('07/09/1979', '%d/%m/%Y'), 743923415, 1, 1, 'C');
insert into CICLOS_ALUMNO values ('11111111','Rasmus Lerdorf','rasmusledorf@gmail.com',STR_TO_DATE('29/11/1989','%d/%m/%Y'),777777777,4,2,'A');

INSERT INTO CICLOS_ALUMNO (dni,nombre,email,fecha_nacimiento,telefono,codigo_ciclo,numero_curso,grupo_curso)
VALUES ('45111126','Richard Stallman','r.stallman.alu@iespacomolla.es',STR_TO_DATE('07/08/1986','%d/%m/%Y'),null,2,2,'A');
INSERT INTO CICLOS_ALUMNO (dni,nombre,email,fecha_nacimiento,telefono,codigo_ciclo,numero_curso,grupo_curso)
VALUES ('45111133','Paul Allen','p.allen.alu@iespacomolla.es',STR_TO_DATE('21/01/1953','%d/%m/%Y'),null,2,2,'A');
INSERT INTO CICLOS_ALUMNO (dni,nombre,email,fecha_nacimiento,telefono,codigo_ciclo,numero_curso,grupo_curso)
VALUES ('45111134','Lawrence Ellison','l.ellison.alu@iespacomolla.es',STR_TO_DATE('17/08/1944','%d/%m/%Y'),null,2,2,'A');
INSERT INTO CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
VALUES ('11111114', 'Larry Page', 'l.page@iespacomolla.es', STR_TO_DATE ('24/11/2003','%d/%m/%Y'), 666555225, 1, 2, 'B');
INSERT INTO CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
VALUES ('31111114', 'Elcoco Bongo', 'e.bongo@miespacoolla.es', STR_TO_DATE ('24/10/2003','%d/%m/%Y'), 666555222, 1, 2, 'B');
INSERT INTO CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
VALUES ('31111118', 'Amorcillo Forever', 'a.forever@iespacomolla.es', STR_TO_DATE ('07/07/2003', '%d/%m/%Y'), 666555022, 1, 2, 'B');
INSERT INTO CICLOS_ALUMNO (dni, nombre, email, fecha_nacimiento, telefono, codigo_ciclo, numero_curso, grupo_curso)
VALUES ('26111114', 'Bill Gates', 'billgates@iespacomolla.es', STR_TO_DATE('20/09/1995', '%d/%m/%Y'), 966403030, 3, 2, 'A');
INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,codigo_ciclo) VALUES(24111124,'Jimmy Wales', 'jimmywales.alu@iespacomolla.es',STR_TO_DATE('03/05/1982','%d/%m/%Y'),5);
INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,codigo_ciclo) VALUES(24111128,'Ada Lovelace', 'adalovelace.alu@iespacomolla.es',STR_TO_DATE('10/04/1988','%d/%m/%Y'),5);
INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,codigo_ciclo) VALUES(25111132,'Luís Miguel','luismiguel.alu@iespacomolla.es',STR_TO_DATE('19/04/1970','%d/%m/%Y'),5);
INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,codigo_ciclo) VALUES(25111123,'Pedro Pascal','pedropascal.alu@iespacomolla.es',STR_TO_DATE('02/04/1975','%d/%m/%Y'),5);
INSERT INTO CICLOS_ALUMNO(dni,nombre,email,fecha_nacimiento,codigo_ciclo) VALUES(25111134,'Guillermo Díaz','guillermodiaz.alu@iespacomolla.es',STR_TO_DATE('09/05/1993','%d/%m/%Y'),5);
INSERT INTO CICLOS_ALUMNO (dni, nombre, fecha_nacimiento, email, telefono, codigo_ciclo, numero_curso, grupo_curso) VALUES ('21111123', 'Linus Torvalds', STR_TO_DATE( '11/08/1983' ,'%d/%m/%Y'), 'linus@gmail.com', 611111110, 3, 1, 'Sem' );
INSERT INTO CICLOS_ALUMNO (dni, nombre, fecha_nacimiento, email, telefono, codigo_ciclo, numero_curso, grupo_curso) VALUES ('12111124', 'Jose Raul', STR_TO_DATE('22/02/1969' ,'%d/%m/%Y'), 'Jose_3@gmail.com', 617715163, 3, 1, 'Sem');
INSERT INTO CICLOS_ALUMNO (dni, nombre, fecha_nacimiento, email, telefono, codigo_ciclo, numero_curso, grupo_curso) VALUES ('12111113', 'Pedro León', STR_TO_DATE('16/02/1995' ,'%d/%m/%Y'), 'pedro_3@gmail.com', 611515163, 3, 1, 'Sem');
INSERT INTO CICLOS_ALUMNO(dni, nombre, fecha_nacimiento, email, telefono,numero_curso, grupo_curso,codigo_ciclo) VALUES('15111122','Alan Turing','alanturing@iespacolla.es', STR_TO_DATE('30/12/1986','%d/%m/%Y'),1,'A',3);
INSERT INTO CICLOS_ALUMNO(dni, nombre, fecha_nacimiento, email, telefono,numero_curso, grupo_curso,codigo_ciclo) VALUES('15111156','Manolo Sanz','manolosanz@iespacolla.es', STR_TO_DATE('28/02/1997','%d/%m/%Y'),1,'A',3);
INSERT INTO CICLOS_ALUMNO(dni, nombre, fecha_nacimiento, email, telefono,numero_curso, grupo_curso,codigo_ciclo) VALUES('15111115','Alfonso García','alfonsogarcia@iespacolla.es', STR_TO_DATE('13/08/1995','%d/%m/%Y'),1,'A',3);
INSERT INTO CICLOS_ALUMNO (dni, nombre,fecha_nacimiento,numero_curso, grupo_curso,codigo_ciclo,email) VALUES ('12111117','Iván Ayuso',STR_TO_DATE('08/12/1999','%d/%m/%Y'),1,'B',1,'ivan@fallodeisaac.com');
INSERT INTO CICLOS_ALUMNO (dni, nombre,fecha_nacimiento,numero_curso, grupo_curso,codigo_ciclo,email) VALUES ('12111118','Diana Cubí',STR_TO_DATE('15/07/1999','%d/%m/%Y'),1,'B',1,'diana@fallodeisaac.com');
INSERT INTO CICLOS_ALUMNO (dni, nombre,fecha_nacimiento,numero_curso, grupo_curso,codigo_ciclo,email) VALUES ('11111116','Steve Jobs',STR_TO_DATE('12/12/1998','%d/%m/%Y'),1,'B',1,'steve@fallodeisaac.com');

--alumnos no matriculados este año
INSERT INTO CICLOS_ALUMNO VALUES('33111129', 'Hedy Lamarr', 'hedylamarr.alu@iespacomolla.es', STR_TO_DATE('03/11/2002', '%d/%m/%Y'), 644885314, null, null, null);
INSERT INTO CICLOS_ALUMNO VALUES('33111130', 'Joan Clarke', 'joanclarke.alu@iespacomolla.es', STR_TO_DATE('19/11/1998', '%d/%m/%Y'), 645668855, null, null, null);
INSERT INTO CICLOS_ALUMNO VALUES('33111131', 'Grace Hopper', 'gracehopper@gmail.com', STR_TO_DATE('20/07/2003', '%d/%m/%Y'), 644741124, null, null, null);
INSERT INTO CICLOS_ALUMNO VALUES('33111132', 'Radia Perlman', 'radiaperlman@hotmail.es', STR_TO_DATE('12/03/2003', '%d/%m/%Y'), 644996321, null, null, null);


--Tabla Trimestre
INSERT INTO CICLOS_TRIMESTRE VALUES(1, '1er trimestre 22/23', STR_TO_DATE('22/12/2022', '%d/%m/%Y'));
INSERT INTO CICLOS_TRIMESTRE VALUES(2, '2º trimestre 22/23', STR_TO_DATE('16/03/2023', '%d/%m/%Y'));
INSERT INTO CICLOS_TRIMESTRE VALUES(3, '3er trimestre 22/23', STR_TO_DATE('19/06/2023', '%d/%m/%Y'));

--Tabla Evaluación

INSERT INTO CICLOS_EVALUACION VALUES('33111118', '0226', 1, 6.7);
INSERT INTO CICLOS_EVALUACION VALUES('33111118', '0227', 1, 5.35);
INSERT INTO CICLOS_EVALUACION VALUES('33111118', '0228', 1, 4.3);

INSERT INTO CICLOS_EVALUACION VALUES('33111133', '0226', 1, 2.41);
INSERT INTO CICLOS_EVALUACION VALUES('33111133', '0227', 1, 8.00);
INSERT INTO CICLOS_EVALUACION VALUES('33111133', '0228', 1, 5.00);

INSERT INTO CICLOS_EVALUACION VALUES('33100951', '0226', 1, 7.00);
INSERT INTO CICLOS_EVALUACION VALUES('33100951', '0227', 1, 7.50);
INSERT INTO CICLOS_EVALUACION VALUES('33100951', '0228', 1, 3.85);

INSERT INTO CICLOS_EVALUACION 
VALUES ('3511111125', '0221', 1, 4.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('3511111133', '0225', 1, 8);
INSERT INTO CICLOS_EVALUACION 
VALUES ('3511111134', '0223', 1, 8);

INSERT INTO CICLOS_EVALUACION VALUES ('11111115','0484',1,9);
INSERT INTO CICLOS_EVALUACION VALUES ('11167115','0484',1,6); 
INSERT INTO CICLOS_EVALUACION VALUES ('11115515','0484',1,3);

insert into CICLOS_EVALUACION values ('32111111', '0221', 3, 8.5);
insert into CICLOS_EVALUACION  values ('33111111', '0223', 3, 3.2);
insert into CICLOS_EVALUACION  values ('31111111', '0225', 3, 6.7);

INSERT INTO CICLOS_EVALUACION VALUES ('11111111','0494',1,5);
INSERT INTO CICLOS_EVALUACION VALUES ('11111112','0494',1,7); 
INSERT INTO CICLOS_EVALUACION VALUES ('11111113','0494',1,2);
INSERT INTO CICLOS_EVALUACION VALUES ('11111111','0488',1,2);
INSERT INTO CICLOS_EVALUACION VALUES ('11111112','0488',1,5); 
INSERT INTO CICLOS_EVALUACION VALUES ('11111113','0488',1,6);
INSERT INTO CICLOS_EVALUACION VALUES ('11111111','0486',1,8);
INSERT INTO CICLOS_EVALUACION VALUES ('11111112','0486',1,9); 
INSERT INTO CICLOS_EVALUACION VALUES ('11111113','0486',1,3);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111126','0374',3,9);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111126','0375',3,7);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111126','0376',3,2);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111133','0374',3,8);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111133','0375',3,6);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111133','0376',3,4);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111134','0374',3,5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111134','0375',3,3);
INSERT INTO CICLOS_EVALUACION 
VALUES ('45111134','0376',3,1);
INSERT INTO CICLOS_EVALUACION 
VALUES ('11111114', '0228', 1, 8.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('11111114', '0230', 1, 5.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('11111114', '0227', 1, 3.2);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111114', '0228', 1, 8.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111114', '0230', 1, 2.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111114', '0227', 1, 8.2);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111118', '0228', 1, 5.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111118', '0230', 1, 1.5);
INSERT INTO CICLOS_EVALUACION 
VALUES ('31111118', '0227', 1, 8.2);
INSERT INTO CICLOS_EVALUACION 
VALUES ('26111114', '0612', 1, 6);
INSERT INTO CICLOS_EVALUACION 
VALUES ('26111114', '0613', 1, 7);
INSERT INTO CICLOS_EVALUACION 
VALUES ('26111114', '0614', 1, 4);
insert into CICLOS_EVALUACION values (25111132, 5052, 2, 3);
insert into CICLOS_EVALUACION values (25111123, 5052, 2, 8);
insert into CICLOS_EVALUACION  values (25111134, 5052, 2, 9);
INSERT INTO CICLOS_EVALUACION  VALUES ('21111123', '0485', 2 , 8);
INSERT INTO CICLOS_EVALUACION  VALUES ('12111124', '0485', 2 , 4);
INSERT INTO CICLOS_EVALUACION  VALUES ('12111113', '0485', 2 , 6);
INSERT INTO CICLOS_EVALUACION VALUES ('15111122','0485',1,7);
INSERT INTO CICLOS_EVALUACION VALUES ('15111156','0485',1,8); 
INSERT INTO CICLOS_EVALUACION VALUES ('15111115','0485',1,2);

INSERT INTO CICLOS_EVALUACION  VALUES ('12111117','0221','1',8);
INSERT INTO CICLOS_EVALUACION  VALUES ('12111118','0229','1',10);
INSERT INTO CICLOS_EVALUACION  VALUES ('12111118','CV0001','1',3);


--UPDATE CICLOS_CURSO para insertar al tutor
UPDATE CICLOS_CURSO SET tutor_curso=11111114 WHERE codigo_ciclo = 1 AND numero= 1 AND grupo = 'A';
UPDATE CICLOS_CURSO SET tutor_curso=11111128 WHERE numero=2 AND grupo_curso='C' AND codigo_ciclo=1;
UPDATE CICLOS_CURSO SET tutor_curso=11111134 WHERE numero=1 AND codigo_ciclo=4 AND grupo='A'; 
update CICLOS_CURSO set tutor_curso=11111118 where abreviatura='1SMRC';
update CICLOS_CURSO set tutor_curso=11111136 where numero=2 and codigo_ciclo=4 and grupo='A';
UPDATE CICLOS_CURSO SET tutor_curso=11111129 WHERE numero=2 AND grupo='A' AND codigo_ciclo=2;
UPDATE CICLOS_CURSO SET tutor_curso=11111127 WHERE numero=2 and grupo='B' and codigo_ciclo=1 and abreviatura='2SMRB';
UPDATE CICLOS_CURSO SET tutor_curso=11111139 WHERE codigo_ciclo=5;
UPDATE CICLOS_CURSO SET tutor_curso=11111143 WHERE numero=1 AND codigo_ciclo=3 AND grupo='Sem'; 
UPDATE CICLOS_CURSO SET tutor_curso=11111141 WHERE numero=1 AND codigo_ciclo=3 AND grupo='A';
--UPDATE CICLOS_PROFESOR, fechas de nacimiento
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('15/12/1966','%d/%m/%Y') WHERE dni=11111111;
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('04/12/1977','%d/%m/%Y') WHERE dni=11111117;
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('06/02/1966','%d/%m/%Y') WHERE dni=11111126;
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('30/04/1977','%d/%m/%Y') WHERE dni=11111128;
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('15/07/1972','%d/%m/%Y') WHERE dni=11111133;
UPDATE CICLOS_PROFESOR SET fecha_nacimiento=STR_TO_DATE('07/03/1964','%d/%m/%Y') WHERE dni=11111028;

/*Añadir antigüedad*/
alter table CICLOS_PROFESOR add antig decimal(2,0);

update CICLOS_PROFESOR set antig=7 where departamento=3;
update CICLOS_PROFESOR set antig=10 where departamento=1;
update CICLOS_PROFESOR set antig=2 where departamento=2;


--COMPROBACIÓN CON SELECT

SELECT *FROM CICLOS_ALUMNO;
SELECT *FROM CICLOS_CICLO;
SELECT *FROM CICLOS_CURSO;
SELECT *FROM CICLOS_DEPARTAMENTO;
SELECT *FROM CICLOS_EVALUACION;
SELECT *FROM CICLOS_IMPARTIR;
SELECT *FROM CICLOS_MODULO;
SELECT *FROM CICLOS_PROFESOR;     
SELECT *FROM CICLOS_TRIMESTRE;

-- Borrado ordenado
/*DROP TABLE CICLOS_IMPARTIR CASCADE CONSTRAINTS;
DROP TABLE CICLOS_DEPARTAMENTO CASCADE CONSTRAINTS;
DROP TABLE CICLOS_PROFESOR CASCADE CONSTRAINTS;
DROP TABLE CICLOS_EVALUACION CASCADE CONSTRAINTS;
DROP TABLE CICLOS_MODULO CASCADE CONSTRAINTS;
DROP TABLE CICLOS_TRIMESTRE CASCADE CONSTRAINTS;
DROP TABLE CICLOS_ALUMNO CASCADE CONSTRAINTS;
DROP TABLE CICLOS_CURSO CASCADE CONSTRAINTS;
DROP TABLE CICLOS_CICLO CASCADE CONSTRAINTS;*/
