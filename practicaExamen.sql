

CREATE TABLE clientes (
                          id_cliente INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100),
                          email VARCHAR(100)
);

CREATE TABLE pedidos (
                         id_pedido INT AUTO_INCREMENT PRIMARY KEY,
                         id_cliente INT,
                         fecha DATE,
                         total DECIMAL(10,2),
                         FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Insertar clientes
INSERT INTO clientes (nombre, email) VALUES
                                         ('Ana Gómez', 'ana@example.com'),
                                         ('Luis Martínez', 'luis@example.com'),
                                         ('Carlos Ruiz', 'carlos@example.com');

-- Insertar pedidos
INSERT INTO pedidos (id_cliente, fecha, total) VALUES
                                                   (1, '2025-04-01', 100.50),
                                                   (1, '2025-04-10', 200.00),
                                                   (2, '2025-04-11', 150.75);

SELECT nombre
FROM clientes
WHERE NOT EXISTS (SELECT 1
              FROM pedidos
              WHERE clientes.id_cliente=pedidos.id_cliente);
SELECT nombre
FROM clientes
WHERE EXISTS (SELECT 1
             FROM pedidos
             WHERE clientes.id_cliente=pedidos.id_cliente
             GROUP BY (pedidos.id_cliente)
             HAVING COUNT(*)>=2);