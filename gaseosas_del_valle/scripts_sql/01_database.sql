DROP DATABASE IF EXISTS gaseosas_del_valle;
CREATE DATABASE gaseosas_del_valle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gaseosas_del_valle;

CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(200) NOT NULL,
    capacidad_almacenamiento INT NOT NULL CHECK (capacidad_almacenamiento >= 0),
    encargado VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    identificacion VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    volumen_ml INT NOT NULL CHECK (volumen_ml > 0),
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT NOT NULL DEFAULT 10 CHECK (stock_minimo >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE auditoria_precios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auditoria_producto FOREIGN KEY (id_producto) 
        REFERENCES productos(id_producto) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    total_sin_iva DECIMAL(12,2) DEFAULT 0.00,
    total_con_iva DECIMAL(12,2) DEFAULT 0.00,
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY (id_cliente) 
        REFERENCES clientes(id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pedidos_sede FOREIGN KEY (id_sede) 
        REFERENCES sedes(id_sede) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE detalle_pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) 
        REFERENCES pedidos(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) 
        REFERENCES productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO sedes (nombre_sede, ubicacion, capacidad_almacenamiento, encargado) VALUES
('Sede Principal Girón', 'Calle 15 # 22-10, Girón', 50000, 'Carlos Mendoza'),
('Sede Bucaramanga', 'Carrera 27 # 45-08, Bucaramanga', 75000, 'Martha Rodríguez'),
('Sede Piedecuesta', 'Anillo Vial Km 3, Piedecuesta', 40000, 'Jorge Gómez');

INSERT INTO clientes (nombre_completo, identificacion, direccion, telefono, correo_electronico) VALUES
('Supermercado El Paisa', '900123456-1', 'Cra 10 # 12-05, Girón', '3151234567', 'paisa_giron@gmail.com'),
('Tienda La Doña', '63456789', 'Calle 8 # 4-12, Bucaramanga', '3109876543', 'ladona_bca@hotmail.com'),
('Restaurante El Portal', '900987654-3', 'Cl 3 # 12-20, Piedecuesta', '3204567890', 'elportal_pie@gmail.com'),
('MiniMercado San José', '1098765432', 'Cra 15 # 30-11, Girón', '3001112233', 'sanjose_giron@gmail.com');

INSERT INTO productos (nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo) VALUES
('Gaseosa Kolita 1.5L', 'Personal', 4500.00, 1500, 120, 30),
('Gaseosa Manzana 2.5L', 'Familiar', 7500.00, 2500, 15, 20),
('Gaseosa Naranja 350ml', 'Personal', 2500.00, 350, 200, 50),
('Agua Cristalina 600ml', 'Agua', 1800.00, 600, 8, 25),
('Soda Refrescante 1L', 'Mezcladores', 3200.00, 1000, 85, 20);