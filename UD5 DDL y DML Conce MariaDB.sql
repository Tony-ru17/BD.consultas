-- Creamos las tablas en el orden correspondiente
CREATE TABLE CONCE_CIUDAD(
	NOMBRE varchar(10) PRIMARY KEY,
	NHABITANTES decimal(10,0) NOT NULL,
	CONSTRAINT CK_NHABITANTES CHECK(NHABITANTES > 0)
);

CREATE TABLE CONCE_MARCA(
	NOMBRE varchar(10) PRIMARY KEY,
	CIUDAD varchar(10) NOT NULL,
	CONSTRAINT FK_CIUD_MARC FOREIGN KEY (CIUDAD) REFERENCES CONCE_CIUDAD(NOMBRE)
);

CREATE TABLE CONCE_COCHE(
	CODIGO varchar(8) PRIMARY KEY,
	NOMBRE varchar(15),
	MARCA varchar(10) NOT NULL, 
	CONSTRAINT FK_COCH_MARC FOREIGN KEY (MARCA) REFERENCES CONCE_MARCA(NOMBRE)
);

CREATE TABLE CONCE_CONCESIONARIO(
	CIF decimal(8,0) PRIMARY KEY,
	NOMBRE varchar(20),
	CIUDAD varchar(10) NOT NULL, 
	CONSTRAINT FK_CONC_CIU FOREIGN KEY (CIUDAD) REFERENCES CONCE_CIUDAD(NOMBRE),
	CONSTRAINT CK_CIF_VALIDO CHECK (CIF >= 0 AND CIF BETWEEN 00000000 AND 99999999)
);

CREATE TABLE CONCE_CLIENTE(
	DNI decimal(8,0) PRIMARY KEY,
	NOMBRE varchar(12) NOT NULL,
	APELLIDO1 varchar(15) NOT NULL,
	APELLIDO2 varchar(15),
	CIUDAD varchar(10) NOT NULL,
	CONSTRAINT FK_CLI_CIU FOREIGN KEY (CIUDAD) REFERENCES CONCE_CIUDAD(NOMBRE),
	CONSTRAINT CK_DNI_VALIDO CHECK(DNI >=0 AND DNI BETWEEN 00000000 AND 99999999)
);

CREATE TABLE CONCE_VENTAS(
	CONCESIONARIO decimal(8,0),
	CLIENTE decimal(8,0),
	COCHE varchar(8),
	COLOR varchar(9),
	FECHA DATE,
	CONSTRAINT FK_VEN_COCH FOREIGN KEY (COCHE) REFERENCES CONCE_COCHE(CODIGO),
	CONSTRAINT FK_VEN_CLI FOREIGN KEY (CLIENTE) REFERENCES CONCE_CLIENTE(DNI),
	CONSTRAINT FK_VEN_CON FOREIGN KEY (CONCESIONARIO) REFERENCES CONCE_CONCESIONARIO(CIF),
	CONSTRAINT PK_VENTAS PRIMARY KEY (CONCESIONARIO,CLIENTE,COCHE)	
);

CREATE TABLE CONCE_DISTRIBUCION(
	CONCESIONARIO decimal(8,0),
	COCHE varchar(8),
	CANTIDAD decimal(3,0),
	CONSTRAINT FK_DIS_COCH FOREIGN KEY (COCHE) REFERENCES CONCE_COCHE(CODIGO),
	CONSTRAINT FK_DIS_CON FOREIGN KEY (CONCESIONARIO) REFERENCES CONCE_CONCESIONARIO(CIF),
	CONSTRAINT PK_DISTRIB PRIMARY KEY (CONCESIONARIO,COCHE),
	CONSTRAINT CK_CANT_COCHE CHECK(CANTIDAD>=0 AND CANTIDAD BETWEEN 0 AND 999)
);

ALTER TABLE CONCE_COCHE
ADD PRECIO_BASE decimal(7,2);
ALTER TABLE CONCE_COCHE
ADD CONSTRAINT PRECIO_BASE CHECK(PRECIO_BASE > 0);
ALTER TABLE CONCE_VENTAS
ADD PRECIO_VENTA decimal(7,2);
ALTER TABLE CONCE_VENTAS
ADD CONSTRAINT PRECIO_VENTA CHECK(PRECIO_VENTA > 0);



/* Insertar ciudades */

INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Alicante',100000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Murcia',50000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Madrid',200000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Barcelona',199999);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Ibiza',10000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Petrer',10000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Monóvar',3000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Elda',10000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Villena',10000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Novelda',40000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Valencia',100000);
INSERT INTO CONCE_CIUDAD (NOMBRE,NHABITANTES)
VALUES ('Zaragoza',30000);

/* Insertar Concesionarios */

INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (44554433, 'Fercar', 'Alicante');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (85543123, 'Mult Car', 'Alicante');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (77323232, 'Motor Sport', 'Murcia');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (85643123, 'BMW Villa de campo', 'Madrid');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (76543213, 'Todo motor', 'Madrid');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (98654678, 'Tope Gama', 'Madrid');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (11232123, 'BMW Barna', 'Barcelona');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (54345432, 'Tot Turbo', 'Barcelona');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (32323232, '4 rodes', 'Ibiza');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (56429642, 'Grant Turismo', 'Alicante');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (11111111, 'Móvil Begar', 'Petrer');
INSERT INTO CONCE_CONCESIONARIO (CIF, NOMBRE, CIUDAD)
VALUES (1222222, 'Automóviles Alpe', 'Petrer');


/* Insertar Marcas */

INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('BMW', 'Barcelona');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('AUDI', 'Madrid');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Citroen', 'Alicante');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Seat', 'Madrid');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('KIA', 'Petrer');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Nissan', 'Valencia');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Renault', 'Barcelona');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Opel', 'Zaragoza');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Ford', 'Valencia');
INSERT INTO CONCE_MARCA (NOMBRE, CIUDAD)
VALUES ('Mercedes', 'Alicante');

/* Insertar Coches*/


INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('BMWe86', 'BMW Serie 1', 'BMW',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('BMWe46', 'BMW Serie 3', 'BMW',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('BMWe34', 'BMW Serie 5', 'BMW',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('BMWm45', 'BMW Serie 7', 'BMW',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('BMWe87', 'BMW Serie 4', 'BMW',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('A3', 'AUDI A3', 'AUDI',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('A5', 'AUDI A5', 'AUDI',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('A6Q', 'AUDI A6 QUATTRO', 'AUDI',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('C4C', 'C4', 'Citroen',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('C5C', 'C5', 'Citroen',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('IBIZA', 'Ibiza', 'Seat',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('KCEED', 'CEED', 'KIA',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('KSPORT', 'SPORTAGE', 'KIA',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('KRIO', 'RIO', 'KIA',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('NISQA', 'QASQAI', 'Nissan',1000.12);
INSERT INTO CONCE_COCHE (CODIGO, NOMBRE, MARCA, PRECIO_BASE)
VALUES ('NISPU', 'PULSAR', 'Nissan',1000.12);

/* Insertar Clientes*/

INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (24583143 , 'Álvaro', 'Naranjo', 'Monóvar');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (65344533 , 'Silvia', 'Pérez', 'Elda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (44545433, 'Francisco', 'Vicedo', 'Alicante');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (14123233, 'Jemima', 'García', 'Monóvar');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (44567676, 'Isela', 'Guerrero', 'Madrid');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (44599887, 'Pascual', 'Bazán', 'Elda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (44512333, 'David', 'Ruiz', 'Villena');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (67453423, 'Álvaro', 'Alted', 'Petrer');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (87643455, 'Sergio', 'Sepulcre', 'Elda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (76357844, 'Marcos', 'Vicente', 'Novelda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (76411111, 'Carlos', 'Lencina', 'Elda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (11111112, 'José Miguel', 'Martón', 'Novelda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (22222211, 'Andrés', 'Pérez', 'Madrid');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (00000031, 'Jorge', 'Candel', 'Petrer');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (12299999, 'Ricardo', 'Mancheño', 'Monóvar');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (12345678, 'Kevin', 'Esteve', 'Elda');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (98765432, 'Nacho', 'Fernández', 'Petrer');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (90876542, 'Ignacio', 'Sanchis', 'Petrer');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (00987619, 'Santiago', 'Amorós', 'Petrer');
INSERT INTO CONCE_CLIENTE (DNI, NOMBRE, APELLIDO1, CIUDAD)
VALUES (23287490, 'Enrique', 'Sánchez', 'Madrid');

/*Insertar Ventas */
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (44554433, 24583143, 'A3', 'rojo', STR_TO_DATE('12-07-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 65344533, 'BMWe86', 'blanco', STR_TO_DATE('21-06-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 44545433, 'BMWe46', 'azul', STR_TO_DATE('01-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 14123233, 'BMWe34', 'blanco', STR_TO_DATE('22-06-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (77323232, 44567676, 'C5C', 'negro', STR_TO_DATE('21-06-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (85643123, 44545433, 'IBIZA', 'azul', STR_TO_DATE('21-06-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 44512333, 'KRIO', 'rojo', STR_TO_DATE('01-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 67453423, 'KRIO', 'amarillo', STR_TO_DATE('02-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 87643455, 'KRIO', 'rojo', STR_TO_DATE('01-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 76357844, 'KRIO', 'blanco', STR_TO_DATE('02-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 76411111, 'BMWe86', 'negro', STR_TO_DATE('01-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (56429642, 11111112, 'IBIZA', 'azul', STR_TO_DATE('02-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (85543123, 22222211, 'KCEED', 'azul', STR_TO_DATE('01-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 00000031, 'KSPORT', 'negro', STR_TO_DATE('02-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 12299999, 'KRIO', 'blanco', STR_TO_DATE('03-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (77323232, 12345678, 'NISQA', 'blanco', STR_TO_DATE('03-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (85643123, 98765432, 'NISPU', 'gris', STR_TO_DATE('03-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 90876542, 'BMWe86', 'gris', STR_TO_DATE('16-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (85543123, 00987619, 'IBIZA', 'rojo', STR_TO_DATE('16-08-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 23287490, 'KCEED', 'blanco', STR_TO_DATE('15-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 44545433, 'KSPORT', 'azul', STR_TO_DATE('15-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (32323232, 00987619, 'IBIZA', 'blanco', STR_TO_DATE('16-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (11111111, 00987619, 'BMWe86', 'negro', STR_TO_DATE('20-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 76411111, 'KRIO', 'blanco', STR_TO_DATE('22-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (85543123, 65344533, 'NISQA', 'blanco', STR_TO_DATE('30-09-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (1222222, 44545433, 'KRIO', 'gris', STR_TO_DATE('27-10-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (54345432, 24583143, 'A3', 'gris', STR_TO_DATE('28-10-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (54345432, 65344533, 'A5', 'negro', STR_TO_DATE('29-10-2019','%d-%m-%Y'),1000.12);
INSERT INTO CONCE_VENTAS (CONCESIONARIO, CLIENTE, COCHE, COLOR, FECHA,PRECIO_VENTA)
VALUES (54345432, 12345678, 'A3', 'azul', STR_TO_DATE('20-12-2019','%d-%m-%Y'),1000.12);

/*Insertar Distribución */

INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (44554433, 'A3', 4);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (11111111, 'BMWe86', 10);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (11111111, 'BMWe46', 11);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (11111111, 'BMWe34', 5);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (77323232, 'C5C', 7);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (85643123, 'IBIZA', 6);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (1222222, 'KRIO', 25);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (56429642, 'IBIZA', 8);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (85543123, 'KCEED', 9);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (1222222, 'KSPORT', 12);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (77323232, 'NISQA', 6);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (85643123, 'NISPU', 8);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (1222222, 'KCEED', 14);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (32323232, 'IBIZA', 17);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (85543123, 'NISQA', 5);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (54345432, 'A3', 9);
INSERT INTO CONCE_DISTRIBUCION (CONCESIONARIO, COCHE, CANTIDAD)
VALUES (54345432, 'A5', 3);

-- COMPROBACIÓN CON SELECT

SELECT * FROM CONCE_CIUDAD;
SELECT * FROM CONCE_MARCA;
SELECT * FROM CONCE_COCHE;
SELECT * FROM CONCE_CONCESIONARIO;
SELECT * FROM CONCE_CLIENTE;
SELECT * FROM CONCE_VENTAS;
SELECT * FROM CONCE_DISTRIBUCION;
