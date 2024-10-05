DROP PROCEDURE `ups_listado_detallado_comision_venta`;
CREATE PROCEDURE `ups_listado_detallado_comision_venta`(IN `p_id_user` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE) NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
select 
u.name,
ip.id as id_pedido,
ip.fecha_pedido,
ip.vlr_subtotal,
iod.id as id_orden_despacho,
iod.fecha_despacho,
iod.fecha_entrega_pedido,
SUM((ipd.precio_total/ipd.cantidad)*iodd.total_cantidad_despachada) as valor_despacho,
(SUM((ipd.precio_total/ipd.cantidad)*iodd.total_cantidad_despachada) / 100) * 5 as comision

from inv_ordenes_despacho_detalles iodd 
JOIN inv_ordenes_despacho iod ON iod.id = iodd.id_orden_despacho AND iod.deleted_at is null
JOIN inv_pedidos_detalle ipd on ipd.id = iodd.id_detalle_pedido and ipd.deleted_at is null
JOIN inv_pedidos ip ON ip.id = ipd.id_pedido AND ip.deleted_at is null and (ip.id_param_estado = 3 or ip.id_param_estado = 5)
JOIN users u ON u.id = ip.id_user
WHERE
 ( ip.id_user = p_id_user OR p_id_user = -99 ) AND iod.fecha_entrega_pedido >= p_fecha_inicio AND iod.fecha_entrega_pedido <= p_fecha_fin AND iodd.deleted_at IS NULL
--   ( ip.id_user = 16 OR 16 = -99 ) AND iod.fecha_entrega_pedido >= '2022-10-01' AND iod.fecha_entrega_pedido <= '2022-10-10' AND iodd.deleted_at IS NULL
GROUP BY 
u.name,
ip.id,
ip.fecha_pedido,
ip.vlr_subtotal,
iod.id,
iod.fecha_despacho,
iod.fecha_entrega_pedido


UNION all 

SELECT  
u.name,
'Total' as id_pedido,
'',
'',
'',
'',
'',
SUM((ipd.precio_total/ipd.cantidad)*iodd.total_cantidad_despachada) as valor_despacho,
(SUM((ipd.precio_total/ipd.cantidad)*iodd.total_cantidad_despachada) / 100) * 5 as comision
   
  
from inv_ordenes_despacho_detalles iodd 
JOIN inv_ordenes_despacho iod ON iod.id = iodd.id_orden_despacho AND iod.deleted_at is null
JOIN inv_pedidos_detalle ipd on ipd.id = iodd.id_detalle_pedido and ipd.deleted_at is null
JOIN inv_pedidos ip ON ip.id = ipd.id_pedido AND ip.deleted_at is null and (ip.id_param_estado = 3 or ip.id_param_estado = 5)
JOIN users u ON u.id = ip.id_user
WHERE
 ( ip.id_user = p_id_user OR p_id_user = -99 ) AND iod.fecha_entrega_pedido >= p_fecha_inicio AND iod.fecha_entrega_pedido <= p_fecha_fin AND iodd.deleted_at IS NULL
  -- ( ip.id_user = 16 OR 16 = -99 ) AND iod.fecha_entrega_pedido >= '2022-10-01' AND iod.fecha_entrega_pedido <= '2022-10-10' AND iodd.deleted_at IS NULL
GROUP BY 
u.name;