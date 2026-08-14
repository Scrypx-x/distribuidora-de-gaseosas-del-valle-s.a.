USE gaseosas_del_valle;

CREATE OR REPLACE VIEW vista_resumen_pedidos_por_sede AS
SELECT 
    s.id_sede,
    s.nombre_sede,
    COUNT(p.id_pedido) AS total_pedidos,
    IFNULL(SUM(p.total_con_iva), 0.00) AS total_ventas_con_iva
FROM sedes s
LEFT JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.id_sede, s.nombre_sede;

CREATE OR REPLACE VIEW vista_productos_bajo_stock AS
SELECT id_producto, nombre, categoria, stock_actual, stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;

CREATE OR REPLACE VIEW vista_clientes_activos AS
SELECT DISTINCT c.id_cliente, c.nombre_completo, c.identificacion, c.correo_electronico
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente;

INSERT INTO pedidos (id_cliente, id_sede) VALUES (1, 1);
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal) VALUES (1, 1, 10, 45000.00);

INSERT INTO pedidos (id_cliente, id_sede) VALUES (2, 2);
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal) VALUES (2, 3, 20, 50000.00);

SELECT * FROM productos WHERE stock_actual <= stock_minimo;

SELECT * FROM pedidos WHERE fecha_pedido BETWEEN '2026-01-01 00:00:00' AND '2026-12-31 23:59:59';

SELECT pr.id_producto, pr.nombre, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN productos pr ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_vendido DESC;

SELECT c.nombre_completo, COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo;

SELECT * FROM clientes WHERE nombre_completo LIKE '%San%';

SELECT * FROM productos WHERE categoria IN ('Personal', 'Familiar');

SELECT * FROM clientes 
WHERE id_cliente = (
    SELECT id_cliente 
    FROM pedidos 
    GROUP BY id_cliente 
    ORDER BY COUNT(id_pedido) DESC 
    LIMIT 1
);

SELECT s.nombre_sede, COUNT(p.id_pedido) as total_pedidos, SUM(p.total_con_iva) as acumulado_ventas
FROM sedes s
JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.id_sede, s.nombre_sede;