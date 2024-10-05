DROP PROCEDURE `ups_listado_detallado_comision_venta`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ups_listado_detallado_comision_venta`(IN `p_id_user` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE) NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER SELECT
    p.id AS id_pedido,
    u.name as nombre_vendedor,
    p.fecha_pedido as fecha,
    p.vlr_subtotal,
   IFNULL((p.vlr_subtotal / 100) * 5,0) AS comision
 
FROM
    inv_pedidos p
LEFT JOIN users u ON
    p.id_user = u.id

WHERE
   ( p.id_user = p_id_user OR p_id_user = -99 ) AND p.fecha_pedido >= p_fecha_inicio AND p.fecha_pedido <= p_fecha_fin AND p.deleted_at IS NULL AND p.id_param_estado = 3
       
    UNION ALL
    
    SELECT
    'Total' as id_pedido,
    u.name AS nombre_vendedor,
    ' ' AS fecha,
    SUM(p.vlr_subtotal), 
   SUM(IFNULL((p.vlr_subtotal / 100) * 5,0)) AS comision
   
   FROM
    inv_pedidos p
LEFT JOIN users u ON
    p.id_user = u.id
    WHERE
   ( p.id_user = p_id_user OR p_id_user = -99 ) AND p.fecha_pedido >= p_fecha_inicio AND p.fecha_pedido <= p_fecha_fin AND p.deleted_at IS NULL AND p.id_param_estado = 3
    
    GROUP BY
   u.name