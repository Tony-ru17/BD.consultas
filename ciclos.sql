--ESTA ES LA CREACIÓN DE TABLAS MODIFICADA DEL EJERCICIO CICLOS QUE HICIMOS--
CREATE TABLE CICLOS_CICLO(
    Codigo NUMERIC(5) PRIMARY KEY,
    Nombre VARCHAR(12), 
    Descripcion VARCHAR(50),
    CONSTRAINT REST_CICL_CICL CHECK(Codigo BETWEEN 00000 AND 99999)
);

CREATE TABLE CICLOS_MODULO(
    Codigo NUMERIC(5) PRIMARY KEY, 
    Nombre VARCHAR(26), 
    Num_horas NUMERIC(3) NOT NULL
);

CREATE TABLE CICLOS_TIENEN_MODULOS(
    Codigo_ciclo_tener NUMERIC(5),
    Codigo_modulo_tener NUMERIC(5),
    CONSTRAINT PK_CIC_TIE_MOD PRIMARY KEY (Codigo_ciclo_tener, Codigo_modulo_tener),
    CONSTRAINT FK_CICLO_TIENE FOREIGN KEY (Codigo_ciclo_tener) REFERENCES CICLOS_CICLO (Codigo),
    CONSTRAINT FK_MODULO_TIENE FOREIGN KEY (Codigo_modulo_tener) REFERENCES CICLOS_MODULO (Codigo)
);

CREATE TABLE CICLOS_DEPARTAMENTO(
    Codigo NUMERIC(5) PRIMARY KEY, 
    Dni_profesor VARCHAR(9),
    Nombre VARCHAR(12) null
);

CREATE TABLE CICLOS_PROFESOR(
    Dni VARCHAR(9) PRIMARY KEY, 
    Codigo_departamento NUMERIC(5),
    Telefono NUMERIC(9) NULL,
    Email VARCHAR(25) NULL ,
    Nombre VARCHAR(30)UNIQUE,
    Fecha_Nacimiento DATE NULL,
    CONSTRAINT FK_PROFESOR_DEPARTAMENTO FOREIGN KEY (Codigo_departamento) REFERENCES CICLOS_DEPARTAMENTO (Codigo)
);

CREATE TABLE CICLOS_CURSO(
    Numero VARCHAR(7) NOT NULL,
    Dni_profesor VARCHAR(9) NULL,
    Grupo VARCHAR(4),
    Codigo_ciclo NUMERIC(5),
    Abreviatura VARCHAR(10) UNIQUE,
    CONSTRAINT PK_CICLOS_CURSO PRIMARY KEY (Numero, Grupo, Codigo_ciclo),
    CONSTRAINT FK_DNI_PRO_CUR FOREIGN KEY (Dni_profesor) REFERENCES CICLOS_PROFESOR (Dni),
    CONSTRAINT FK_CURSO_CICLO FOREIGN KEY (Codigo_ciclo) REFERENCES CICLOS_CICLO (Codigo)
);

CREATE TABLE CICLOS_IMPARTIR(
    Codigo_modulo NUMERIC(5),
    Grupo_curso VARCHAR(4),
    Codigo_ciclo NUMERIC(5),
    Numero_curso VARCHAR(7),
    Dni_profesor VARCHAR(9) NOT NULL,
    Numero_horas_semanales NUMERIC(2) NOT NULL,
    CONSTRAINT PK_IMPARTIR_CURSOS PRIMARY KEY (Codigo_modulo, Grupo_curso,  Codigo_ciclo, Numero_curso),
    CONSTRAINT FK_COD_MOD_IMP FOREIGN KEY (Codigo_modulo) REFERENCES CICLOS_MODULO (Codigo),
    CONSTRAINT FK_COD_CICLO_IMP FOREIGN KEY ( Codigo_ciclo) REFERENCES CICLOS_CICLO (Codigo),
    CONSTRAINT FK_GRU_CUR_IMP FOREIGN KEY (Numero_curso, Grupo_curso, Codigo_ciclo ) REFERENCES CICLOS_CURSO (Numero, Grupo, Codigo_ciclo),
    CONSTRAINT FK_DNI_PRO_IMP FOREIGN KEY (Dni_profesor) REFERENCES CICLOS_PROFESOR (Dni)
);

CREATE TABLE CICLOS_ALUMNO(
    Dni VARCHAR(9) PRIMARY KEY,
    Abreviatura_ciclo VARCHAR(10),
    Nombre VARCHAR(38) NOT NULL,
    Email VARCHAR(25), 
    Fecha_nacimiento DATE NOT NULL, 
    Telefono NUMERIC(9), 
    CONSTRAINT FK_GRU_CUR_ALU FOREIGN KEY (Abreviatura_ciclo) REFERENCES CICLOS_CURSO (Abreviatura)
);

CREATE TABLE CICLOS_TRIMESTRE(
    Codigo NUMERIC(5) PRIMARY KEY,
    Nombre VARCHAR(20),
    Fecha_inicio DATE NOT NULL,
    Fecha_final DATE
    
);

CREATE TABLE CICLOS_EVALUAR(
    Codigo_trimestre NUMERIC(5),
    Dni_alumno VARCHAR(9),
    Codigo_modulo NUMERIC(5),
    Nota NUMERIC(2),
    CONSTRAINT PK_CICLOS PRIMARY KEY (Codigo_trimestre, Dni_alumno, Codigo_modulo),
    CONSTRAINT FK_COD_TRI_EVA FOREIGN KEY (Codigo_trimestre) REFERENCES CICLOS_TRIMESTRE (Codigo), 
    CONSTRAINT FK_DNI_ALU_EVA FOREIGN KEY (Dni_alumno) REFERENCES CICLOS_ALUMNO (Dni),
    CONSTRAINT FK_COD_MOD_EVA FOREIGN KEY (Codigo_modulo) REFERENCES CICLOS_MODULO (Codigo)
);

ALTER TABLE CICLOS_DEPARTAMENTO
ADD CONSTRAINT FK_DNI_PRO_DEP FOREIGN KEY (Dni_profesor) REFERENCES CICLOS_PROFESOR (Dni);
--TRAS ESTO PROCEDO A HACER LAS INSERCIONES--

--INSERCION DE CICLOS--
INSERT INTO CICLOS_CICLO(Codigo, Nombre, Descripcion)
VALUES
    (1, "CFGM SMR" , "Sistemas microinformáticos y redes"),
    (2, "CFGS ASIR","Administración de Sistemas Informáticos en Red"),
    (3, "CFGS DAW", "Desarrollador de aplicaciones web"),
    (4, "CFGS DAM", "Desarrollador de aplicaciones multimedia"),
    (5, "Curso EDV", "Curso especialización de videojuegos"),
    (6, "CFGS DAWS", "Desarrollador de aplicaciones web semipresencial");

    
--INSERCION DE CURSO--
INSERT INTO CICLOS_CURSO(Numero, Grupo, Codigo_ciclo, Abreviatura)
VALUES
    (1, "A", 1,"1SMRA" ),
    (1, "B", 1,"1SMRB" ),
    (1, "C", 1,"1SMRC" ),
    (2, "A", 1,"2SMRA" ),
    (2, "B", 1,"2SMRB"),
    (2, "C", 1,"2SMRC"),
    (1, "A", 2, "1ASIRA"),
    (2, "A", 2, "2ASIRA"),
    (1, "A", 4,"1DAM"),
    (2, "A", 4,"2DAM"),
    (1, "A", 3, "1DAWA"),
    (2, "A", 3, "2DAWA"),
    (1, "A", 5, "1EDV"),
    (1, "A", 6, "1DAW-SEMI");
--INSERCION DE MODULOS--
INSERT INTO CICLOS_MODULO (Codigo, Nombre, Num_horas)
VALUES
    (1,"Base de datos", 125),
    (2, "Programación", 300 ),
    (3, "Inglés", 80 ),
    (4, "IPE", 80),
    (5, "Proyecto Intermodular", 25 ),
    (6, "Entornos de desarrollo",200 ),
    (7, "Lenguaje de marcas",200 );

--INSERTO LOS DEPARTAMENTOS Y LUEGO LES PONGO EL DNI DE PROFESOR--
INSERT INTO CICLOS_DEPARTAMENTO(Codigo, Nombre)
VALUES 
    (1, "Informática"),
    (2, "Inglés"),
    (3, "FOL");
--INSERTO LOS PROFESORES Y LUEGO LES PONGO LOS DEPARTAMENTOS A LOS QUE PERTENECEN--
INSERT INTO CICLOS_PROFESOR(Dni, Telefono, Email, Nombre, Fecha_Nacimiento)
VALUES  
    (11111111, 604937856, "jose@gmail.com", "Jose Manuel Cano", '1960-12-01'),
    (11111112, 674835617, "lidia@gmail.com", "Lidia Cerdán", '1969-10-01'),
    (11111113, 687435681, "mercedes@gmail.com", "Mercedes Poveda", '1970-02-07'),
    (11111114, 686647897, "miguel@gmail.com", "Miguel Ángel Aguilar", '1984-12-07'),
    (11111115, 643253458, "marga@gmail.com", "Marga Martínez", '1963-10-05'),
    (11111116, 609738274, "ramon@gmail.com", "Ramón Galinsoga", '1984-12-01'),
    (11111117, 675234753, "francisco@gmail.com", "Paco Ribera", '1969-11-07'),
    (11111118, 654762867, "juanjo@gmail.com", "Juan José Vidal", '1984-12-03'),
    (11111119, 609787659, "samue@gmail.com", "Samuel Hernández", '1968-12-07'),
    (11111120, 606746876, "davud@gmail.com", "David Ponce", '1966-12-01'),
    (11111121, 657254387, "hernand@gmail.com", "Miguel Hernández", '1960-12-01'),
    (11111122, 612154315, "ramon@gmail.com", "Daniel Hernández", '1984-12-07'),
    (11111123, 612335467, "ramon@gmail.com", "Gonzalo Hernández", '1960-12-04'),
    (11111124, 698665678, "ramon@gmail.com", "Eric Hernández", '1984-12-07');
    --Aqui me dió error por poner la fecha en formato dia-mes-año, y me tocó cambiar absolutamente todas las fechas de la base de datos--
    --INTRODUZCO TODO LO NO INTRODUCIDO EN PROFESORES Y DEPARTAMENTO--
UPDATE CICLOS_DEPARTAMENTO SET Dni_profesor =11111111 WHERE Codigo = 2;
UPDATE CICLOS_DEPARTAMENTO SET Dni_profesor =11111116 WHERE Codigo = 1;
UPDATE CICLOS_DEPARTAMENTO SET Dni_profesor =11111115 WHERE Codigo = 3;

UPDATE CICLOS_PROFESOR SET Codigo_departamento = 2 WHERE Dni = 11111111;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 2 WHERE Dni = 11111112;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 2 WHERE Dni = 11111113;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 3 WHERE Dni = 11111114;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 3 WHERE Dni = 11111115;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111116;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111117;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111118;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111119;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111120;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111121;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111122;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111123;
UPDATE CICLOS_PROFESOR SET Codigo_departamento = 1 WHERE Dni = 11111124;

--CREO LA TABLA ALUMNOS--
INSERT INTO CICLOS_ALUMNO(Dni, Nombre, Fecha_nacimiento, Abreviatura_ciclo)
VALUES
    (11111114, "Paco Rio", '1992-10-01', "1SMRA"), 
    (11111115, "Ruben Linterna", '1995-09-01', "1SMRA"), 
    (11111116, "Carolina Herrera ", '1999-12-01', "1SMRB"), 
    (11111117, "Gonzalo Buffet ", '2004-09-01', "1SMRB"), 
    (11111118, "Bubaloo Fernandez ", '1960-12-01', "1SMRC"), 
    (11111119, "María Sarmiento ", '1960-09-01', "2SMRA"), 
    (11111120, "Valeria Cano ", '1960-12-01', "2SMRB"), 
    (11111121, "Miguel Hacendado ", '1990-12-01', "2SMRC"), 
    (11111122, "Fernando Gutierrez", '1960-09-01', "1ASIRA"), 
    (11111123, "Julio Embape", '1980-12-01', "2ASIRA"), 
    (11111124, "Surge gonzalez ", '1960-09-01', "1DAM"), 
    (11111125, "Bibi Gomez ", '1960-12-01', "2DAM"), 
    (11111126, "Fernanda Rosa ", '1960-12-01', "1DAWA"), 
    (11111127, "Javier Heredia ", '1960-09-01', "2DAWA"), 
    (11111128, "Venancio Rio ", '1990-12-01', "1EDV"), 
    (11111129, "Maria José cañada ", '1960-12-01', "1DAW-SEMI"),
    (11111130, "Owen Julio ", '2004-09-01', "1DAW-SEMI"),
    (11111131, "Joaquin Fundicion ", '1960-12-01', NULL),
    (11111132, "Sevilla Ramos ", '2004-12-01', NULL),
    (11111133, "Matador Rodriguez", '2004-09-01', NULL);
--CREO LA TABLA TRIMIESTRE--
INSERT INTO CICLOS_TRIMESTRE(Codigo, Nombre, Fecha_inicio)
VALUES
    (1, "1ER TRIMESTRE 22/23", '2022-12-22'),
    (2, "2 TRIMESTRE 22/23", '2023-03-16'),
    (3, "3ER TRIMESTRE 22/23", '2023-6-19');

--EVALÚO A 3 ALUMNOS 2 APROBADOS Y UN SUSPENSO--
INSERT INTO CICLOS_EVALUAR(Codigo_trimestre, Dni_alumno, Codigo_modulo, Nota)
VALUES
    (1, 11111114, 1, 6),
    (1, 11111115, 2, 4),
    (1, 11111116, 3, 7);
--HAGO QUE CADA CURSO TUTORIZADO POR UN PROFESOR--
UPDATE CICLOS_CURSO SET Dni_profesor = 11111111 WHERE Abreviatura = "1SMRA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111112 WHERE Abreviatura = "1SMRB";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111113 WHERE Abreviatura = "1SMRC";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111114 WHERE Abreviatura = "2SMRA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111115 WHERE Abreviatura = "2SMRB";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111116 WHERE Abreviatura = "2SMRC";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111117 WHERE Abreviatura = "1ASIRA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111118 WHERE Abreviatura = "2ASIRA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111119 WHERE Abreviatura = "1DAM";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111120 WHERE Abreviatura = "2DAM";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111121 WHERE Abreviatura = "1DAWA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111122 WHERE Abreviatura = "2DAWA";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111123 WHERE Abreviatura = "1EDV";
UPDATE CICLOS_CURSO SET Dni_profesor = 11111124 WHERE Abreviatura = "1DAW-SEMI";
--CAMBIO LA FECHA DE NACIMIENTO DE LOS PROFESORES--
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1966-12-15' WHERE Dni = 11111111;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1977-12-04' WHERE Dni = 11111112;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1966-02-06' WHERE Dni = 11111113;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1939-04-09' WHERE Dni = 11111114;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1977-04-30' WHERE Dni = 11111115;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1972-07-15' WHERE Dni = 11111116;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1964-07-03' WHERE Dni = 11111117;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1959-02-26' WHERE Dni = 11111118;
UPDATE CICLOS_PROFESOR SET Fecha_Nacimiento ='1979-10-07' WHERE Dni = 11111119;

--AUMENTO LA NOTA DE LOS QUE HAN APROBADO--
UPDATE CICLOS_EVALUAR SET Nota = 7 WHERE Dni_alumno = 11111114;
UPDATE CICLOS_EVALUAR SET Nota = 8 WHERE Dni_alumno = 11111116;

/*Hola Ramón, no estoy seguro de si leerás esto, pero es la contestación al punto N. Ha sido toda una epopeya esta inserción de datos, he tenido ganas de quitarme la vida
y también de morir en diferentes ocasiones, he modificado las tablas de la actividad de CICLOS en incontables, innumerables ocasiones, he cambiado casi todas las longitudes
de los VARCHAR,en la primera tabla ya cambié Abreviatura por Descripción, he tenido que reescribir TODAS las fechas de las inserciones, he tenido que cambiar el número de
DAW-SEMI porque le había puesto el mismo que a DAW y no me dejaba tener DAW y DAW-SEMI porque formaban la misma clave principal, y no recuerdo específicamente las difultades, 
pero han sido muchas.
En resumen, este ejercicio no ha podido corromperme, el Heraldo de la virtud me guía por el camino correcto cuando fallo y no me deja caer.*/

--o) He realizado pocos cambios en lo que se refiere al modelo entidad relación, solo he puesto el dni profesor en varias tablas que no lo tenían anteriormente --



   


