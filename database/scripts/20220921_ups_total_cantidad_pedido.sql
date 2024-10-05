CREATE PROCEDURE `ups_total_cantidad_pedido`(IN `p_id_pedido` INT)
    NO SQL
SELECT 
SUM((ipd.cantidad)+(ipd.bonificacion)) as total_cantidad_pedido
FROM `inv_pedidos_detalle` ipd 
INNER JOIN inv_pedidos ip ON
ipd.id_pedido = ip.id
WHERE 
ipd.id_pedido = p_id_pedido AND ipd.deleted_at is null