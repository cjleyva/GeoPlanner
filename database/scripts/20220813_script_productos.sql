INSERT INTO `terceros` 
(id, `es_proveedor`, es_cliente,`id_param_tipo_tercero`, `nombre_tercero`, `id_param_tipo_persona_contable`, `id_param_tipo_documento`, `numero_documento`, `direccion`, `id_municipio`, `telefono`, `contacto_principal`, `cargo`, `email`, `observaciones`, `created_at`, `created_by`) 
VALUES (1,'1', '0', '2', 'Coragro Organicos S.A.S', '2', '2', '900175560-9', 'Hacienda La MIel, Bodega Los Guayabos', '958', '3188636408', 'nd', 'nd', 'coragro@coragro.co', 'coragro@coragro.co; gerencia.comercial@coragro.co', current_timestamp(), '1');
;
INSERT INTO `terceros` 
(id,`es_proveedor`, es_cliente,`id_param_tipo_tercero`, `nombre_tercero`, `id_param_tipo_persona_contable`, `id_param_tipo_documento`, `numero_documento`, `direccion`, `id_municipio`, `telefono`, `contacto_principal`, `cargo`, `email`, `observaciones`, `created_at`, `created_by`) 
VALUES (2,'1', '0', '2', 'Ceradis Colombia Ltda.', '2', '2', '900254277-8', 'Calle 21 A 69 B 38 Barrio Montevideo', '149', '3175155229', 'nd', 'nd', 'ceradis.colombia@ceradis.com', null, current_timestamp(), '1');
;
INSERT INTO `parametricas` 
(id, `categoria`, `valor`, `texto`, `descripcion`, `orden`, `estado`) 
VALUES 
(16,'id_param_clase', '1', 'FUNGICIDA', 'FUNGICIDA', '100', '1');
INSERT INTO `parametricas` 
(id, `categoria`, `valor`, `texto`, `descripcion`, `orden`, `estado`) 
VALUES 
(17,'id_param_clase', '2', 'FERTILIZANTE', 'FERTILIZANTE', '200', '1');



insert into inv_productos
(id, id_tercero, referencia, referencia_proveedor, nombre_producto, id_param_clase, presentacion, precio_kilo, precio_por_presentacion, foto, observaciones, created_at,created_by)
values
(1, 2, 'P0001', '', 'ELIM 800 GR', 16, '800 GR', 34333, 34333,null, null, current_timestamp(),1)
,(2, 2, 'P0002', '', 'ELIM 5 KG', 16, '5 KG', 38667, 193335,null, null, current_timestamp(),1)
,(3, 2, 'P0003', '', 'ELIM 25 KG', 16, '25 KG', 36333, 908325,null, null, current_timestamp(),1)
,(4, 2, 'P0004', '', 'CERAQUINT SP 1 KG', 16, '1 KG', 58742, 58742,null, null, current_timestamp(),1)
,(5, 2, 'P0005', '', 'CERAQUINT SP 5 KG', 16, '5 KG', 56458, 282290,null, null, current_timestamp(),1)
,(6, 2, 'P0006', '', 'CERAQUINT SP 25 KG', 16, '25 KG', 54817, 1370425,null, null, current_timestamp(),1)
,(7, 2, 'P0007', '', 'MUSACARE SP 1 KG', 16, '1 KG', 58225, 58225,null, null, current_timestamp(),1)
,(8, 2, 'P0008', '', 'MUSACARE SP 5 KG', 16, '5 KG', 55917, 279585,null, null, current_timestamp(),1)
,(9, 2, 'P0009', '', 'MUSACARE SP 25 KG', 16, '25 KG', 54300, 1357500,null, null, current_timestamp(),1)
,(10, 2, 'P0010', '', 'FYTOFERT PK ZINCO 1 KG', 17, '1 KG', 46633, 46633,null, null, current_timestamp(),1)
,(11, 2, 'P0011', '', 'FYTOFERT PK ZINCO 5 KG', 17, '5 KG', 44733, 223665,null, null, current_timestamp(),1)
,(12, 2, 'P0012', '', 'FYTOFERT PK ZINCO 25 KG', 17, '25 KG', 10042, 251050,null, null, current_timestamp(),1)
,(13, 2, 'P0013', '', 'FYTOFERT PK 1 KG', 17, '1 KG', 56733, 56733,null, null, current_timestamp(),1)
,(14, 2, 'P0014', '', 'FYTOFERT PK 5 KG', 17, '5 KG', 54833, 274165,null, null, current_timestamp(),1)
,(15, 2, 'P0015', '', 'FYTOFERT PK 25 KG', 17, '25 KG', 53483, 1337075,null, null, current_timestamp(),1)
,(16, 2, 'P0016', '', 'MUSACARE CP  1 KG', 17, '1 KG', 61467, 61467,null, null, current_timestamp(),1)
,(17, 2, 'P0017', '', 'MUSACARE CP  5 KG', 17, '5 KG', 59183, 295915,null, null, current_timestamp(),1)
,(18, 2, 'P0018', '', 'MUSACARE CP  25 KG', 17, '25 KG', 57542, 1438550,null, null, current_timestamp(),1)
,(19, 1, 'P0019', '', 'CIMUS 50 KG', 17, '50 KG', 3600, 180000,null, null, current_timestamp(),1)
;
