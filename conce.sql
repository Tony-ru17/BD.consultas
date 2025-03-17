CREATE TABLE CONCE_CIUDAD(
    nombre_ciudad VARCHAR(20) PRIMARY KEY,
    num_habitantes NUMERIC(8) NOT NULL,
    CONSTRAINT ck_nombre_ciudad CHECK(nombre_ciudad IN('Alicante','Murcia','Madrid','Barcelona','Ibiza','Petrer'))
);

CREATE TABLE CONCE_CONCESIONARIO(
    CIF_conce NUMERIC(8) PRIMARY KEY,
    ciudad_nombre VARCHAR(20),
    CONSTRAINT fk_conce_ciudad FOREIGN KEY (ciudad_nombre) REFERENCES CONCE_CIUDAD(nombre_ciudad) ON DELETE CASCADE,
    nombre VARCHAR(15) NOT NULL,
    razon_social VARCHAR(200)
);
CREATE TABLE CONCE_MARCA(
    nombre_marca VARCHAR(15) PRIMARY KEY,
    ciudad_nombre VARCHAR(20),
    CONSTRAINT fk_marca_ciudad FOREIGN KEY (ciudad_nombre) REFERENCES CONCE_CIUDAD(nombre_ciudad) ON DELETE CASCADE,
    conce_CIF NUMERIC(8),
    CONSTRAINT fk_marca_conce FOREIGN KEY (conce_CIF) REFERENCES CONCE_CONCESIONARIO(CIF_conce) ON DELETE CASCADE
);

CREATE TABLE CONCE_COCHE(
    codigo_coche VARCHAR(10) PRIMARY KEY,
    conce_CIF NUMERIC(8),
    CONSTRAINT fk_coche_conce FOREIGN KEY (conce_CIF) REFERENCES CONCE_CONCESIONARIO(CIF_CONCE) ON DELETE CASCADE,
    marca_nombre VARCHAR(20),
    CONSTRAINT fk_coche_marca FOREIGN KEY(marca_nombre) REFERENCES CONCE_MARCA(nombre_marca) ON DELETE CASCADE,
    nombre VARCHAR(10),
    precio_base NUMERIC(6),
    CONSTRAINT nn_coche CHECK(nombre IS NOT NULL OR precio_base IS NOT NULL)
);
CREATE TABLE CONCE_CLIENTE(
    DNI_cliente VARCHAR(9) PRIMARY KEY,
    ciudad_nombre VARCHAR(20),
    CONSTRAINT fk_cliente_ciudad FOREIGN KEY(ciudad_nombre) REFERENCES CONCE_CIUDAD(nombre_ciudad) ON DELETE CASCADE,
    conce_CIF NUMERIC(8),
    CONSTRAINT fk_cliente_conce FOREIGN KEY (conce_CIF) REFERENCES CONCE_CONCESIONARIO(CIF_conce) ON DELETE CASCADE,
    nombre VARCHAR(10),
    apellido VARCHAR(10),
    CONSTRAINT nn_cliente CHECK (nombre IS NOT NULL OR apellido IS NOT NULL)
);
CREATE TABLE CONCE_VENTA(
    cliente_DNI VARCHAR(9),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_DNI) REFERENCES CONCE_CLIENTE(DNI_cliente),
    conce_CIF NUMERIC(8),
    CONSTRAINT fk_venta_conce FOREIGN KEY (conce_CIF) REFERENCES CONCE_CONCESIONARIO(CIF_conce),
    coche_codigo VARCHAR(10),
    CONSTRAINT fk_venta_coche FOREIGN KEY (coche_codigo) REFERENCES CONCE_COCHE(codigo_coche),

    fecha DATE,
    color VARCHAR(15),
    precio_venta NUMERIC(6),
    CONSTRAINT nn_venta CHECK(fecha IS NOT NULL OR color IS NOT NULL OR precio_venta IS NOT NULL) --Indica que fecha,color y precio_venta no deben ser nulos
);
CREATE TABLE CONCE_DISTRIBUCION(
   conce_CIF NUMERIC(8),
   CONSTRAINT fk_distribucion_conce FOREIGN KEY (conce_CIF) REFERENCES CONCE_CONCESIONARIO(CIF_conce),
   coche_codigo VARCHAR(10),
   CONSTRAINT fk_distribucion_coche FOREIGN KEY (coche_codigo) REFERENCES CONCE_COCHE(codigo_coche),
   cantidad NUMERIC(4) NOT NULL
);

DROP TABLE CONCE_DISTRIBUCION;
DROP TABLE CONCE_VENTA;
DROP TABLE CONCE_CLIENTE;
DROP TABLE CONCE_COCHE;
DROP TABLE CONCE_MARCA;
DROP TABLE CONCE_CONCESIONARIO;
DROP TABLE CONCE_CIUDAD;