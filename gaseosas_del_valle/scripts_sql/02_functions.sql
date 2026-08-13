USE gaseosas_del_valle;

DELIMITER $$

DROP FUNCTION IF EXISTS fn_calcular_total_con_iva$$
CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_subtotal_sum DECIMAL(12,2);
    DECLARE v_total_con_iva DECIMAL(12,2);

    SELECT IFNULL(SUM(subtotal), 0.00) INTO v_subtotal_sum
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    SET v_total_con_iva = v_subtotal_sum * 1.19;
    RETURN v_total_con_iva;
END$$

DROP FUNCTION IF EXISTS fn_validar_stock$$
CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_stock_actual INT;

    SELECT stock_actual INTO v_stock_actual
    FROM productos
    WHERE id_producto = p_id_producto;

    IF v_stock_actual IS NULL THEN
        RETURN 'ERROR: Producto no existe.';
    ELSEIF v_stock_actual >= p_cantidad THEN
        RETURN CONCAT('STOCK DISPONIBLE: Quedarán ', (v_stock_actual - p_cantidad), ' unidades.');
    ELSE
        RETURN CONCAT('INSUFICIENTE: Disponible (', v_stock_actual, '), Solicitado (', p_cantidad, ').');
    END IF;
END$$

DELIMITER ;