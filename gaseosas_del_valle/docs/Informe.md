# Informe Técnico: Sistema BD - Gaseosas del Valle S.A.

## 1. Descripción del Proyecto
Sistema relacional centralizado diseñado en MySQL para automatizar la gestión de pedidos, sedes, productos y clientes de Distribuidora de Gaseosas del Valle S.A., sustituyendo las hojas de cálculo previas.

## 2. Arquitectura de Base de Datos
- **Entidades Principales**: `sedes`, `clientes`, `productos`, `pedidos`.
- **Tabla Intermedia**: `detalle_pedido` (Relación N:M entre pedidos y productos).
- **Tabla de Auditoría**: `auditoria_precios` (Registro automático de variaciones de precios).

## 3. Lógica Almacenada
- **`fn_calcular_total_con_iva`**: Calcula el valor total sumando los subtotales de la tabla intermedia y aplicando la tasa del 19%.
- **`fn_validar_stock`**: Valida si existe la disponibilidad suficiente antes de la confirmación de la orden.
- **`tr_actualizar_stock`**: Disparador `AFTER INSERT` que descuenta automáticamente las unidades compradas del stock global.
- **`tr_auditar_cambio_precio`**: Disparador `AFTER UPDATE` que registra historiales de precios.

## 4. Recomendaciones para Expansión
1. Implementar autenticación por roles (Roles de Administrador vs Ventas).
2. Integrar indexación adicional en campos de frecuente búsqueda (`clientes.nombre_completo`).
3. Sincronizar el script de Python en una tarea programada (Cron Job / Windows Task Scheduler) para enviar los reportes de Excel e imágenes a correo electrónico diariamente.