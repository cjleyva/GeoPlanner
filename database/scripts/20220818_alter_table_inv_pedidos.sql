ALTER TABLE `inv_pedidos` 
CHANGE `contacto_pedido` `contacto_pedido` 
VARCHAR(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'Contacto, quien realiza y acepta el pedido', 
CHANGE `cargo` `cargo` 
VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'Cargo del contacto que realiza el pedido', 
CHANGE `numero_orden_de_compra` `numero_orden_de_compra` 
VARCHAR(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'numero de orden de compra'; 

ALTER TABLE `inv_pedidos` 
CHANGE `id_param_dias_factura` `id_param_dias_factura` 
BIGINT(20) UNSIGNED NULL COMMENT 'dias para la facturacion (30,60,90,180)'; 