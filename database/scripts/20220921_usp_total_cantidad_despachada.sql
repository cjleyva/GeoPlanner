CREATE PROCEDURE `usp_total_cantidad_despachada`(IN `p_id_pedido` INT)
    NO SQL
SELECT
SUM(iodd.total_cantidad_despachada) as total_cantidad_despachada
FROM inv_ordenes_despacho_detalles  iodd
INNER JOIN
inv_ordenes_despacho iod ON
 iodd.id_orden_despacho = iod.id
 WHERE
 iod.id_pedido = p_id_pedido AND iodd.deleted_at is null