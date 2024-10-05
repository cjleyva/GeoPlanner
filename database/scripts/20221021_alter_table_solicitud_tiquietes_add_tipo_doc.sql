ALTER TABLE `solictud_tiquetes_hotel` 
ADD COLUMN `id_param_tipo_documento` BIGINT(20) UNSIGNED NOT NULL DEFAULT 3 AFTER `nombre_apellido`;

INSERT INTO `parametricas` (`id`, `categoria`, `valor`, `texto`, `descripcion`, `orden`, `estado`, `created_at`, `created_by`) VALUES ('52', 'tercero_param_tipo_documento', '5', 'Pasaporte', 'Tipo de documento pasaporte', '500', '1', '2022-10-21 15:54:42', '0');

