CREATE PROCEDURE `usp_consulta_cantidades_pedido_vs_despachos`(IN `p_id_user` INT, IN `p_id_pedido` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER  select
ip.id as id_pedido,
ip.fecha_pedido,
ip.id_tercero,
t.nombre_tercero,
t.numero_documento,
ipd.id_producto,
ipr.referencia,
ipr.nombre_producto,
ipd.cantidad,
ipd.bonificacion,
ipd.cantidad + ipd.bonificacion as total_prod_ped,
iod.id as id_orden,
iod.fecha_despacho,
iod.fecha_entrega_pedido,
iodd.cantidad_despachada,
iodd.bonificacion_despachada,
iodd.total_cantidad_despachada

from
inv_ordenes_despacho_detalles iodd
JOIN inv_ordenes_despacho iod ON iod.id = iodd.id_orden_despacho AND iod.deleted_at is null
JOIN inv_pedidos_detalle ipd ON ipd.id = iodd.id_detalle_pedido AND ipd.deleted_at is null
JOIN inv_pedidos ip on ip.id = ipd.id_pedido AND ip.deleted_at is null
JOIN terceros t ON t.id = ip.id_tercero AND t.deleted_at is null
JOIN inv_productos ipr ON ipr.id = ipd.id_producto AND ipr.deleted_at is null

where 
( ip.id_tercero = p_id_user OR p_id_user = -99 ) AND 
( ip.id = p_id_pedido OR ( p_id_pedido = -99 and ip.fecha_pedido >= p_fecha_inicio and ip.fecha_pedido <= p_fecha_fin) ) AND iodd.deleted_at is null
