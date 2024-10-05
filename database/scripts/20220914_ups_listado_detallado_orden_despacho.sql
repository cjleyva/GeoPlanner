CREATE  PROCEDURE `ups_listado_detallado_orden_despacho`(IN `p_id_tercero` INT, IN `p_id_pedido` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)
    NO SQL
SELECT
iod.id,
iod.id_pedido,
iod.fecha_despacho,
iod.n_documento_cliente,
iod.direcion_entrega_pedido,
iod.contacto_entrega_pedido,
iod.fecha_entrega_pedido,
iod.telefono_cliente,
iod.correo_cliente,
t.nombre_tercero,
m.nombre_municipio,
d.nombre_departamento,
p.texto,
ip.nombre_producto,
iodd.cantidad,
iodd.lote,
iodd.fecha_vencimiento,
ipe.fecha_pedido
FROM 
inv_ordenes_despacho iod
INNER JOIN terceros t ON
t.id = iod.id_tercero
INNER JOIN municipios m ON
m.id = iod.id_municipio_entrega
INNER JOIN departamentos d ON
d.id = m.id_departamento
INNER JOIN parametricas p ON
p.id = iod.id_condicion_entrega
LEFT JOIN inv_ordenes_despacho_detalles iodd ON
iod.id = iodd.id_orden_despacho AND ISNULL (iodd.deleted_at)
LEFT JOIN inv_productos ip ON
ip.id = iodd.id_producto
INNER JOIN inv_pedidos ipe ON
ipe.id = iod.id_pedido  
WHERE
(iod.id_tercero = p_id_tercero OR p_id_tercero = -99 ) AND ( iod.id_pedido = p_id_pedido OR p_id_pedido = -99 ) AND iod.fecha_despacho >= p_fecha_inicio AND iod.fecha_despacho <= p_fecha_fin AND iod.deleted_at IS NULL