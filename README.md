# Distribuidora-de-Gaseosas-del-Valle-S.A.

Gaseosas del Valle S.A. es una empresa distribuidora autorizada de bebidas gaseosas en el municipio de Girón, con planes de expansión hacia Bucaramanga y Piedecuesta.

 Actualmente gestionan los pedidos y el control de stock en hojas de cálculo, lo cual ha generado errores de registro, pérdida de datos y falta de trazabilidad sobre las ventas.

La gerencia busca implementar una base de datos relacional en MySQL que permita administrar productos, clientes, pedidos y sedes de distribución, además de automatizar tareas críticas como el cálculo de totales, la verificación de stock y el registro de auditorías al cambiar precios.

Objetivo general

Diseñar e implementar una base de datos relacional en MySQL que soporte la gestión integral de productos, clientes, pedidos y sedes de la empresa, incluyendo funciones, triggers, vistas y consultas analíticas para apoyar la toma de decisiones comerciales y logísticas.

Objetivos específicos

    Modelar correctamente las entidades del sistema con sus relaciones (1–N, N–N).
    Implementar funciones para automatizar cálculos (IVA, disponibilidad de stock).
    Desarrollar triggers que aseguren la integridad de los datos y generen auditorías automáticas.
    Construir consultas combinadas con JOIN, IN, LIKE, BETWEEN y subconsultas.
    Crear vistas que consoliden la información de ventas y stock por sede o cliente.
    Entregar documentación técnica y evidencias de ejecución.

Requerimientos funcionales
1. Gestión de Productos

    Campos: id_producto, nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo.
    Controlar actualizaciones de precio y stock.
    Auditar cada cambio de precio en una tabla auditoria_precios.

2. Gestión de Clientes

    Campos: id_cliente, nombre_completo, identificacion, direccion, telefono, correo_electronico.
    Permitir búsquedas por nombre o parte del nombre.

3. Gestión de Sedes

    Campos: id_sede, nombre_sede, ubicacion, capacidad_almacenamiento, encargado.
    Relacionar cada pedido con la sede desde la que se despacha.

4. Gestión de Pedidos

    Campos: id_pedido, fecha_pedido, id_cliente, id_sede, total_sin_iva, total_con_iva.
    Tabla intermedia detalle_pedido con: id_pedido, id_producto, cantidad, subtotal.
    Validar el stock disponible antes de confirmar el pedido.


Funciones requeridas (CREATE FUNCTION)

    fn_calcular_total_con_iva(id_pedido)
     Calcula el total con IVA del pedido (19%) a partir de la suma de subtotales.
    
    fn_validar_stock(id_producto, cantidad)
     Retorna un mensaje indicando si hay suficiente stock antes de confirmar el pedido.


Triggers requeridos (CREATE TRIGGER)

    tr_actualizar_stock
     Al insertar un detalle de pedido, descuenta automáticamente la cantidad vendida del stock.
    
    tr_auditar_cambio_precio
     Al actualizar el campo precio en la tabla productos, registra la fecha, el precio anterior y el nuevo en una tabla auditoria_precios.


Consultas SQL requeridas

    Consultar los productos con stock por debajo del mínimo.
    Consultar los pedidos realizados entre dos fechas (BETWEEN).
    Listar los productos más vendidos (con JOIN y GROUP BY).
    Mostrar clientes y la cantidad de pedidos realizados.
    Buscar clientes por nombre parcial usando LIKE.
    Consultar productos de ciertas categorías usando IN.
    Mostrar el cliente con mayor número de pedidos (subconsulta).
    Consultar pedidos y sus totales agrupados por sede.


Vistas requeridas (CREATE VIEW)

    vista_resumen_pedidos_por_sede
     Muestra la cantidad total de pedidos y ventas por sede.
    
    vista_productos_bajo_stock
     Lista productos con stock_actual <= stock_minimo.
    
    vista_clientes_activos
     Muestra clientes con al menos un pedido registrado.

Resultado esperado

Entregables

    Script database.sql con la creación de tablas y relaciones.
    Script functions.sql con funciones personalizadas.
    Script triggers.sql con los triggers implementados.
    Script views_and_queries.sql con vistas y consultas complejas.
    README técnico o informe con:

    Descripción del proyecto.
    Modelo entidad–relación (puede ser en diagram.net o Lucidchart).
    Explicación de cada función y trigger.
    Ejemplos de consultas y capturas de resultados.
    Recomendaciones para la expansión futura del sistema.