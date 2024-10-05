-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-05-2024 a las 04:18:54
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `geo_planer_localizacion`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ups_listado_detallado_comision_venta` (IN `p_id_user` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)  NO SQL select
u.name,
ip.id as id_pedido,
ip.fecha_pedido,
ip.vlr_subtotal,
iod.id as id_orden_despacho,
iod.fecha_despacho,
iod.fecha_entrega_pedido,
SUM((ipd.precio_total/ipd.cantidad)*iodd.cantidad_despachada) as valor_despacho,
(SUM((ipd.precio_total/ipd.cantidad)*iodd.cantidad_despachada) / 100) *  p.comision as comision

from inv_ordenes_despacho_detalles iodd
JOIN inv_ordenes_despacho iod ON iod.id = iodd.id_orden_despacho AND iod.deleted_at is null
JOIN inv_pedidos_detalle ipd on ipd.id = iodd.id_detalle_pedido and ipd.deleted_at is null
JOIN inv_pedidos ip ON ip.id = ipd.id_pedido AND ip.deleted_at is null and (ip.id_param_estado = 3 or ip.id_param_estado = 5)
JOIN users u ON u.id = ip.id_user
join inv_productos p on iodd.id_producto = p.id
WHERE
 ( ip.id_user = p_id_user OR p_id_user = -99 ) AND iod.fecha_entrega_pedido >= p_fecha_inicio AND iod.fecha_entrega_pedido <= p_fecha_fin AND iodd.deleted_at IS NULL

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
name,
'Total' as id_pedido,
'',
'',
'',
'',
'',
SUM(valor_despacho),
SUM(comision)
from 
(
select
u.name,
ip.id as id_pedido,
ip.fecha_pedido,
ip.vlr_subtotal,
iod.id as id_orden_despacho,
iod.fecha_despacho,
iod.fecha_entrega_pedido,
SUM((ipd.precio_total/ipd.cantidad)*iodd.cantidad_despachada) as valor_despacho,
(SUM((ipd.precio_total/ipd.cantidad)*iodd.cantidad_despachada) / 100) *  p.comision as comision

from inv_ordenes_despacho_detalles iodd
JOIN inv_ordenes_despacho iod ON iod.id = iodd.id_orden_despacho AND iod.deleted_at is null
JOIN inv_pedidos_detalle ipd on ipd.id = iodd.id_detalle_pedido and ipd.deleted_at is null
JOIN inv_pedidos ip ON ip.id = ipd.id_pedido AND ip.deleted_at is null and (ip.id_param_estado = 3 or ip.id_param_estado = 5)
JOIN users u ON u.id = ip.id_user
join inv_productos p on iodd.id_producto = p.id
WHERE
 ( ip.id_user = p_id_user OR p_id_user = -99 ) AND iod.fecha_entrega_pedido >= p_fecha_inicio AND iod.fecha_entrega_pedido <= p_fecha_fin AND iodd.deleted_at IS NULL

GROUP BY
u.name,
ip.id,
ip.fecha_pedido,
ip.vlr_subtotal,
iod.id,
iod.fecha_despacho,
iod.fecha_entrega_pedido
) A
group by name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ups_listado_detallado_orden_despacho` (IN `p_id_tercero` INT, IN `p_id_pedido` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)  NO SQL SELECT
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
iodd.cantidad_despachada,
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
(iod.id_tercero = p_id_tercero OR p_id_tercero = -99 ) AND ( iod.id_pedido = p_id_pedido OR p_id_pedido = -99 ) AND iod.fecha_despacho >= p_fecha_inicio AND iod.fecha_despacho <= p_fecha_fin AND iod.deleted_at IS NULL$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ups_total_cantidad_pedido` (IN `p_id_pedido` INT)  NO SQL SELECT 
SUM((ipd.cantidad)+(ipd.bonificacion)) as total_cantidad_pedido
FROM `inv_pedidos_detalle` ipd 
INNER JOIN inv_pedidos ip ON
ipd.id_pedido = ip.id
WHERE 
ipd.id_pedido = p_id_pedido AND ipd.deleted_at is null$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_consulta_cantidades_pedido_vs_despachos` (IN `p_id_user` INT, IN `p_id_pedido` INT, IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)   select
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
iodd.id_orden,
iodd.fecha_despacho,
iodd.fecha_entrega_pedido,
iodd.cantidad_despachada,
iodd.bonificacion_despachada,
iodd.total_cantidad_despachada

from
inv_pedidos ip inner join 
inv_pedidos_detalle ipd on ipd.id_pedido = ip.id and ipd.deleted_at is null left join 
(
    select 
    iodd1.bonificacion_despachada,
    iodd1.cantidad_despachada,
    iodd1.id_detalle_pedido,
    iodd1.total_cantidad_despachada,
    iod.id as id_orden,
    iod.fecha_despacho,
    iod.fecha_entrega_pedido
    from 
    inv_ordenes_despacho iod inner join 
	inv_ordenes_despacho_detalles iodd1 ON iod.id = iodd1.id_orden_despacho AND iod.deleted_at is null 
    where 
    iodd1.deleted_at is null 
    ) iodd on ipd.id = iodd.id_detalle_pedido
    left join 
terceros t ON t.id = ip.id_tercero AND t.deleted_at is null left join 
inv_productos ipr ON ipr.id = ipd.id_producto AND ipr.deleted_at is null

where 
( ip.id_tercero = p_id_user OR p_id_user = -99 ) AND 
( ip.id = p_id_pedido OR ( p_id_pedido = -99 and ip.fecha_pedido >= p_fecha_inicio and ip.fecha_pedido <= p_fecha_fin) ) 
AND ip.deleted_at is null$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_total_cantidad_despachada` (IN `p_id_pedido` INT)  NO SQL SELECT
SUM(iodd.total_cantidad_despachada) as total_cantidad_despachada
FROM inv_ordenes_despacho_detalles  iodd
INNER JOIN
inv_ordenes_despacho iod ON
 iodd.id_orden_despacho = iod.id
 WHERE
 iod.id_pedido = p_id_pedido AND iodd.deleted_at is null$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas`
--

CREATE TABLE `alertas` (
  `id` bigint UNSIGNED NOT NULL,
  `id_remitente` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'identificador del usuario que envia el mensaje',
  `id_destinatario` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'identificador del id usuario que recibe el mensaje',
  `origen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'modulo o pantalla de origen que esta enviando la alerta',
  `destino` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'link de destino al cual direccion el sistema al hacer clic en enviar',
  `titulo` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'título del mensaje',
  `mensaje` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'cuerpo del mesaje',
  `es_alerta` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'cuando es una alerta a pantalla',
  `es_mail` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Cuando es un mensaje a correo electronico',
  `email_enviado` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Cuando se envia el correo se actualiza este campo',
  `estado` int UNSIGNED NOT NULL DEFAULT '1' COMMENT 'si es 1 es creado, si es 2 es marcadado como leido, si es 0 es eliminado',
  `created_by` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'usuario que crea el registro',
  `updated_by` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'usuario que actualiza el registro',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `geo_localizacion`
--

CREATE TABLE `geo_localizacion` (
  `id` bigint UNSIGNED NOT NULL,
  `latitud` decimal(10,7) NOT NULL,
  `longitud` decimal(10,7) NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ciudad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL DEFAULT '0',
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `deleted_by` bigint UNSIGNED DEFAULT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `observaciones` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `geo_localizacion`
--

INSERT INTO `geo_localizacion` (`id`, `latitud`, `longitud`, `direccion`, `ciudad`, `created_at`, `updated_at`, `deleted_at`, `created_by`, `updated_by`, `deleted_by`, `id_usuario`, `fecha`, `observaciones`) VALUES
(1, -74.2990000, 4.6320000, NULL, NULL, '2024-05-21 06:20:58', '2024-05-22 05:22:56', '2024-05-22 05:22:56', 0, 1, 1, 1, '2024-05-21', 'Observaciones Observaciones'),
(2, 5.2523000, -72.7831000, NULL, NULL, '2024-05-21 23:33:10', '2024-05-22 05:24:08', '2024-05-22 05:24:08', 1, 1, 1, 1, '2024-05-21', NULL),
(3, 5.2523000, -72.7831000, NULL, NULL, '2024-05-22 01:37:06', '2024-05-22 01:37:06', NULL, 1, NULL, NULL, 1, '2024-05-20', NULL),
(4, 6.2518400, -75.5635900, NULL, NULL, '2024-05-22 01:38:51', '2024-05-22 01:59:37', NULL, 1, 1, NULL, 1, '2024-05-21', NULL),
(5, 3.5462500, -73.7068700, NULL, NULL, '2024-05-22 02:29:02', '2024-05-22 03:03:46', NULL, 1, 1, NULL, 1, '2024-05-21', NULL),
(6, 4.8587600, -74.0586600, NULL, NULL, '2024-05-22 03:22:33', '2024-05-22 05:23:34', NULL, 16, 1, NULL, 1, '2024-05-21', 'Coordenadas geográficas de Chía\r\nChía se encuentra en la latitud 4.85876 y longitud -74.05866. Hace parte del continente de América del Sur y está ubicado en el hemisferio norte.'),
(7, 5.2523000, -72.7831000, NULL, NULL, '2024-05-22 06:04:45', '2024-05-22 06:05:08', '2024-05-22 06:05:08', 1, NULL, 1, 1, '2024-05-22', NULL),
(8, 4.8587600, -74.0586600, NULL, NULL, '2024-05-22 06:07:35', '2024-05-22 06:07:35', NULL, 1, NULL, NULL, 1, '2024-05-22', NULL),
(9, 4.8587600, -74.0586600, NULL, NULL, '2024-05-22 06:10:29', '2024-05-22 06:10:29', NULL, 1, NULL, NULL, 1, '2024-05-22', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` int UNSIGNED NOT NULL DEFAULT '0',
  `order` smallint NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `name`, `slug`, `parent`, `order`, `enabled`, `created_at`, `updated_at`, `icon`) VALUES
(1, 'Administrador', 'administrador', 0, 100, 1, '2020-07-06 01:13:20', NULL, 'fas fa-cogs'),
(2, 'Contratos', 'contratos', 0, 200, 1, '2020-07-06 01:13:20', NULL, 'fas fa-edit'),
(3, 'Financiero', 'financiero', 0, 300, 1, '2020-07-06 01:13:20', NULL, 'fas fa-file-invoice-dollar'),
(4, 'Seguimiento', 'seguimiento', 0, 400, 1, '2020-07-06 01:13:20', NULL, 'fas fa-tachometer-alt'),
(5, 'Usuarios', 'usuarios.index', 1, 500, 1, '2020-07-06 01:13:20', NULL, 'fas fa-user'),
(6, 'Roles', 'roles.index', 1, 600, 1, '2020-07-06 01:13:20', NULL, 'fas fa-user-friends'),
(7, 'Permisos', 'permisosindex', 1, 700, 0, '2020-07-06 01:13:20', NULL, 'fas fa-users-cog'),
(8, 'Registro de contratos', 'contratosindex', 2, 800, 0, '2020-07-06 01:13:20', NULL, 'fas fa-file-contract'),
(9, 'Creacion PADs', 'creacionpads', 3, 900, 0, '2020-07-06 01:13:20', NULL, 'far fa-file-powerpoint'),
(10, 'Tablero de control', 'dashboard', 4, 1000, 0, '2020-07-06 01:13:20', NULL, 'fas fa-chart-pie'),
(11, 'Cambiar contraseña', 'usuarios.cambiar.contrasena', 1, 100, 1, '2020-07-06 01:13:20', NULL, 'fas fa-key'),
(12, 'Geo Localizacion', 'geoLcalizacion', 0, 1200, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_07_04_143222_create_permission_tables', 2),
(5, '2020_07_04_143857_create_notes_table', 3),
(6, '2020_07_06_002016_create_menus_table', 4),
(7, '2020_07_06_023354_create_alertas_table', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(10, 'App\\User', 1),
(10, 'App\\User', 4),
(10, 'App\\User', 8),
(10, 'App\\User', 11),
(31, 'App\\User', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notes`
--

CREATE TABLE `notes` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notes`
--

INSERT INTO `notes` (`id`, `title`, `content`, `created_at`, `updated_at`) VALUES
(1, 'Nota 1', 'contenido de la nota 1', NULL, NULL),
(2, 'nota 2', 'contenido de la nota 2', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametricas`
--

CREATE TABLE `parametricas` (
  `id` bigint UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `categoria` varchar(100) NOT NULL COMMENT 'Categoria de agrupacion de la parametrica',
  `valor` varchar(100) NOT NULL COMMENT 'Valor que tiene la parametrica',
  `texto` varchar(500) NOT NULL COMMENT 'texto que expone la parametrica',
  `descripcion` text NOT NULL COMMENT 'Descripcion de la parametrica',
  `orden` int NOT NULL DEFAULT '100' COMMENT 'Orden en el cual se muestran los datos cuando es un select o una lista',
  `estado` int NOT NULL DEFAULT '1' COMMENT 'Estado de la parametrica, si es 1 es activo, si es 0 es inactivo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint UNSIGNED DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `parametricas`
--

INSERT INTO `parametricas` (`id`, `categoria`, `valor`, `texto`, `descripcion`, `orden`, `estado`, `created_at`, `updated_at`, `deleted_at`, `created_by`, `updated_by`, `deleted_by`) VALUES
(1, 'tercero_param_tipo_persona', '1', 'Persona Natural', 'Tipo de persona natural', 100, 1, '2022-08-12 04:20:40', NULL, NULL, 0, NULL, NULL),
(2, 'tercero_param_tipo_persona', '2', 'Persona Jurídica', 'Tipo de persona jurídica', 200, 1, '2022-08-12 04:20:40', NULL, NULL, 0, NULL, NULL),
(3, 'tercero_param_tipo_documento', '1', 'Cédula Ciudadanía', 'Tipo de documento de cedula de cuidadania', 100, 1, '2022-08-12 04:53:42', NULL, NULL, 0, NULL, NULL),
(4, 'tercero_param_tipo_documento', '2', 'Nit', 'Tipo de documento nit', 200, 1, '2022-08-12 04:53:42', NULL, NULL, 0, NULL, NULL),
(5, 'tercero_param_tipo_documento', '3', 'Cédula Extranjería', 'Tipo de documento de cédula de ectranjería', 300, 1, '2022-08-12 04:53:42', NULL, NULL, 0, NULL, NULL),
(6, 'id_param_zona', '1', 'Colombia', 'todo el pais', 100, 1, '2022-08-12 05:12:04', NULL, NULL, 1, NULL, NULL),
(7, 'pedidos_param_forma_pago', '1', 'Crédito', 'Forma de pago de crédito', 100, 1, '2022-08-12 18:27:40', NULL, NULL, 0, NULL, NULL),
(8, 'pedidos_param_forma_pago', '2', 'Contado', 'Forma de pago de contado', 200, 1, '2022-08-12 18:27:40', NULL, NULL, 0, NULL, NULL),
(9, 'pedidos_param_dia_fecha_factura', '1', '30', 'Dias 30 de la fecha de la factura ', 100, 1, '2022-08-12 18:35:52', NULL, NULL, 0, NULL, NULL),
(10, 'pedidos_param_dia_fecha_factura', '2', '45', 'Dias 45 de la fecha de la factura', 200, 1, '2022-08-12 18:35:52', NULL, NULL, 0, NULL, NULL),
(11, 'pedidos_param_dia_fecha_factura', '3', '60', 'Dias 60 de la fecha de la factura', 300, 1, '2022-08-12 18:35:52', NULL, NULL, 0, NULL, NULL),
(12, 'pedidos_param_dia_fecha_factura', '4', '90', 'Dias 90 de la fecha de la factura', 400, 1, '2022-08-12 18:35:52', NULL, NULL, 0, NULL, NULL),
(13, 'pedidos_param_dia_fecha_factura', '5', '120', 'Dias 120 de la fecha de la factura', 500, 1, '2022-08-12 18:35:52', NULL, NULL, 0, NULL, NULL),
(16, 'id_param_clase', '1', 'FUNGICIDA', 'FUNGICIDA', 100, 1, '2022-08-12 21:54:16', NULL, NULL, 0, NULL, NULL),
(17, 'id_param_clase', '2', 'FERTILIZANTE', 'FERTILIZANTE', 200, 1, '2022-08-12 21:54:38', NULL, NULL, 0, NULL, NULL),
(18, 'pedido_param_moneda', '1', 'Pesos colombianos', 'Moneda local', 100, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(19, 'pedido_param_moneda', '2', 'Dolares Americanos', 'Moneda extranjera americana', 200, 1, '2022-08-16 14:55:41', NULL, NULL, 0, NULL, NULL),
(20, 'pedido_param_moneda', '3', 'Euros', 'Moneda extranjera europea', 300, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(21, 'pedido_param_estado', '1', 'En registro', 'primer estado del pedido', 100, 1, '2022-08-16 14:55:41', NULL, NULL, 0, NULL, NULL),
(22, 'pedido_param_estado', '2', 'Pendiente autorizar', 'Segundo estado del pedido esperando aprobación', 200, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(23, 'pedido_param_estado', '3', 'Autorizado', 'Pedido autorizado', 300, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(24, 'pedido_param_estado', '4', 'No Autorizado', 'Pedido rechazado o no autorizado', 400, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(25, 'pedido_param_condiciones_entrega', '1', 'Instalaciones del cliente', 'Instalaciones del cliente', 100, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(26, 'pedido_param_condiciones_entrega', '2', 'FOB', 'FOB', 200, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(27, 'pedido_param_condiciones_entrega', '3', 'CFR', 'CFR', 300, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(28, 'pedido_param_condiciones_entrega', '4', 'CIF', 'CIF', 400, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(29, 'pedido_param_condiciones_entrega', '4', 'DAP', 'DAP', 500, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(30, 'pedido_param_condiciones_entrega', '4', 'DDP', 'DDP', 600, 1, '2022-08-16 14:55:41', NULL, NULL, 1, NULL, NULL),
(31, 'pedidos_param_no_dias_facturas', '1', 'No aplica', 'No aplica dias por que el pago es de contado', 100, 1, '2022-08-25 23:52:37', NULL, NULL, 0, NULL, NULL),
(32, 'pedido_param_estado', '5', 'Despachado', 'Se cambia a estado despachada cuando el pedido ya no tiene ordenes de despacho pendiente', 500, 1, '2022-09-21 20:58:53', NULL, NULL, 0, NULL, NULL),
(33, 'legalizacion_gasto_param_concepto', '1', 'Hotel', 'Si el gasto fue de concepto  de hotel', 100, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(34, 'legalizacion_gasto_param_concepto', '2', 'Alimentación', 'Si el gasto fue de concepto de alimentación', 200, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(35, 'legalizacion_gasto_param_concepto', '3', 'Combustible', 'Si el gasto fue de concepto combustible', 300, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(36, 'legalizacion_gasto_param_concepto', '4', 'Peajes', 'Si el gasto fue de concepto de peajes', 400, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(37, 'legalizacion_gasto_param_concepto', '5', 'Parqueadero', 'Si el gasto fue de concepto de parqueadero', 500, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(38, 'legalizacion_gasto_param_concepto', '6', 'Transporte', 'Si el gasto fue de concepto de transporte', 600, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(39, 'legalizacion_gasto_param_concepto', '7', 'Comunicación', 'Si el gasto fue de concepto de comunicaión', 700, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(40, 'legalizacion_gasto_param_concepto', '8', 'Representacion', 'Si el gasto fue de concepto de representación', 800, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(41, 'legalizacion_gasto_param_concepto', '9', 'Correo', 'Si el gasto fue de concepto de correo', 900, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(42, 'legalizacion_gasto_param_concepto', '10', 'Papeleria,copias,fax', 'Si el gasto fue de concepto de papeleria,copias,fax', 1000, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(43, 'legalizacion_gasto_param_concepto', '11', 'Otros', 'Si el gasto fue de concepto de otros', 1100, 1, '2022-09-28 14:23:25', NULL, NULL, 0, NULL, NULL),
(44, 'legalizacion_gasto_param_estado', '1', 'En registro', 'Primer estado de legalizacion de gastos', 100, 1, '2022-09-28 14:23:37', NULL, NULL, 0, NULL, NULL),
(45, 'legalizacion_gasto_param_estado', '2', 'Pendiente autorizar', 'Segundo estado del pedido esperando aprobación', 200, 1, '2022-09-28 14:23:37', NULL, NULL, 0, NULL, NULL),
(46, 'legalizacion_gasto_param_estado', '3', 'Autorizado', 'Legalizacion de gasto autorizado', 300, 1, '2022-09-28 14:23:37', NULL, NULL, 0, NULL, NULL),
(47, 'legalizacion_gasto_param_estado', '4', 'Rechazado', 'Legalizacion de gastos rechazado o no autorizado', 400, 1, '2022-09-28 14:23:37', NULL, NULL, 0, NULL, NULL),
(48, 'solicitud_tiquetes_hotel_param_estado', '1', 'En registro', 'Primer estado de solicitud de tiquetes y hotel', 100, 1, '2022-10-06 02:01:53', NULL, NULL, 0, NULL, NULL),
(49, 'solicitud_tiquetes_hotel_param_estado', '2', 'Pendiente autorizar', 'Segundo estado de la solicitud de tiquetes y hotel', 200, 1, '2022-10-06 02:01:53', NULL, NULL, 0, NULL, NULL),
(50, 'solicitud_tiquetes_hotel_param_estado', '3', 'Autorizado', 'Solicitud de tiquetes y hotel autorizado', 300, 1, '2022-10-06 02:01:53', NULL, NULL, 0, NULL, NULL),
(51, 'solicitud_tiquetes_hotel_param_estado', '4', 'Rechazado', 'Solicitud de tiquetes y hotel rechazado o no autorizado', 400, 1, '2022-10-06 02:01:53', NULL, NULL, 0, NULL, NULL),
(52, 'tercero_param_tipo_documento', '4', 'Pasaporte', 'Tipo de documento pasaporte', 400, 1, '2022-10-21 15:54:42', NULL, NULL, 0, NULL, NULL),
(53, 'pedido_param_tipo_cliente', '1', 'Distribuidor', 'Tipo de cliente distribuidor', 100, 1, '2023-05-09 14:32:04', NULL, NULL, 0, NULL, NULL),
(54, 'pedido_param_tipo_cliente', '2', 'Dealer', 'Tipo de cliente dealer', 200, 1, '2023-05-09 14:32:04', NULL, NULL, 0, NULL, NULL),
(55, 'orden_compra_param_estado', '1', 'En registro', 'Primer estado de la orden de  campra en registro', 100, 1, '2023-06-03 22:09:35', NULL, NULL, 0, NULL, NULL),
(56, 'orden_compra_param_estado', '2', 'Pendiente autorizar', 'Segundo estado de la orden de compra esperando aprobación', 200, 1, '2023-06-03 22:09:35', NULL, NULL, 0, NULL, NULL),
(57, 'orden_compra_param_estado', '3', 'Autorizado', 'Orden de compra autorizada', 300, 1, '2023-06-03 22:09:35', NULL, NULL, 0, NULL, NULL),
(58, 'orden_compra_param_estado', '4', 'No Autorizado', 'Orden de compra rechazado o no autorizado', 400, 1, '2023-06-03 22:09:35', NULL, NULL, 0, NULL, NULL),
(59, 'orden_compra_param_estado', '5', 'Recibido', 'Se cambia a estado cuando la orden de compra esta en estado autorizado', 500, 1, '2023-06-03 22:09:35', NULL, NULL, 0, NULL, NULL),
(60, 'pedidos_param_dia_fecha_factura', '6', '180', 'Dias 180 de la fecha de la factura', 600, 1, '2023-12-04 18:35:52', NULL, NULL, 0, NULL, NULL),
(61, 'id_param_clase', '3', 'APLICACIÓN FOLIAR', 'APLICACIÓN FOLIAR', 300, 1, '2023-12-22 01:31:10', NULL, NULL, 0, NULL, NULL),
(62, 'id_param_clase', '4', 'FERTIRRIEGO Y DRENCH', 'FERTIRRIEGO Y DRENCH', 400, 1, '2023-12-22 01:31:10', NULL, NULL, 0, NULL, NULL),
(63, 'id_param_clase', '5', 'BIOESTIMULANTES Y BIOREGULADORES', 'BIOESTIMULANTES Y BIOREGULADORES', 500, 1, '2023-12-22 01:31:10', NULL, NULL, 0, NULL, NULL),
(64, 'id_param_clase', '6', 'COADYUVANTES', 'COADYUVANTES', 600, 1, '2023-12-22 01:31:10', NULL, NULL, 0, NULL, NULL),
(65, 'id_param_clase', '7', 'FERTILIZANTES GRANULADOS', 'FERTILIZANTES GRANULADOS', 700, 1, '2023-12-22 01:31:10', NULL, NULL, 0, NULL, NULL),
(66, 'id_param_correos', '1', 'maria.avila@imjagroindustrial.com', 'Correo que se registra para los pedidos', 100, 1, '2024-02-15 19:56:25', NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('yohana.garcia@auren.com.co', '$2y$10$XirQJLa1zlEZD0uGVEFiluCJwCwr.8TGUxiRtsljku4YD1Y0Z1qKu', '2022-10-06 18:34:31'),
('i.piedrahita@imjagroindustrial.com', '$2y$10$tg38nFni5Lvxv8pexy2wmOyIy4XqJaZwxXlcSKh0DFsdcqc3ZL2Sa', '2023-09-05 21:15:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'destroy_notes', 'web', '2020-07-04 14:57:03', '2020-07-04 14:57:03', NULL),
(2, 'administracion.roles.ver', 'web', '2020-07-13 14:15:13', '2020-07-13 14:15:13', NULL),
(3, 'administracion.roles.crear', 'web', '2020-07-13 14:15:13', '2020-07-13 14:15:13', NULL),
(4, 'administracion.roles.eliminar', 'web', '2020-07-13 14:15:13', '2020-07-13 14:15:13', NULL),
(5, 'administracion.roles.editar', 'web', '2020-07-13 14:15:13', '2020-07-13 14:15:13', NULL),
(6, 'administracion.roles.permisos', 'web', '2020-07-19 21:12:44', '2020-07-19 21:12:44', NULL),
(7, 'administracion.usuarios.ver', 'web', '2020-07-19 21:12:44', '2020-07-19 21:12:44', NULL),
(8, 'administracion.usuarios.crear', 'web', '2020-07-19 21:12:44', '2020-07-19 21:12:44', NULL),
(9, 'administracion.usuarios.editar', 'web', '2020-07-19 21:12:44', '2020-07-19 21:12:44', NULL),
(10, 'administracion.usuarios.eliminar', 'web', '2020-07-19 21:12:44', '2020-07-19 21:12:44', NULL),
(11, 'administracion.usuarios.cambiarcontraseña', 'web', '2020-07-21 03:47:15', '2020-07-21 03:47:15', NULL),
(68, 'geo_localizacion', 'web', '2024-05-22 05:39:30', '2024-05-22 05:39:30', NULL),
(69, 'geo_localizacion.index', 'web', '2024-05-22 05:39:30', '2024-05-22 05:39:30', NULL),
(70, 'geo_localizacion.crear', 'web', '2024-05-22 05:39:30', '2024-05-22 05:39:30', NULL),
(71, 'geo_localizacion.editar', 'web', '2024-05-22 05:39:30', '2024-05-22 05:39:30', NULL),
(72, 'geo_localizacion.eliminar', 'web', '2024-05-22 05:39:30', '2024-05-22 05:39:30', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(10, 'Administrador', 'web', '2020-07-13 16:52:28', '2020-07-13 16:52:28', NULL),
(31, 'Programador', 'web', '2024-05-21 23:16:50', '2024-05-21 23:16:50', NULL),
(32, 'Conductor', 'web', '2024-05-22 05:41:16', '2024-05-22 05:41:16', NULL),
(33, 'suspervisor', 'web', '2024-05-22 05:42:18', '2024-05-22 05:42:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 10),
(2, 10),
(3, 10),
(4, 10),
(5, 10),
(6, 10),
(7, 10),
(8, 10),
(9, 10),
(10, 10),
(11, 10),
(68, 10),
(69, 10),
(70, 10),
(71, 10),
(72, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Administrador', 'robinmp@gmail.com', NULL, '$2y$10$YY0PWmtUbUpw07E0UJsuUeZjXcp/OZkSHDxKHeLqYFGBSJ.ld8kJi', '79ucWY0tTdvUI6d4nxRaG7RshowgTd2iVm6Mxy9ubjh4k1c0p07dxk2c13up', '2020-07-04 13:46:35', '2022-10-03 21:24:52', NULL),
(9, 'Vendedor1 prueba', 'vendedor1@gmail.com1664832245', NULL, '$2y$10$32a9OWuV0GMSmBTqrjtnte/6FmuUu6C3bZVPUdF76HsAsI2jIbBeu', 'bc4hDRNeZ674J7JK0nYx4E0knEDQQ7ZSQNCRFmwBnSr6IO23QwhRsBNiMBiv', '2022-08-16 21:10:05', '2022-10-03 21:24:05', '2022-10-03 21:24:05'),
(10, 'Supervisor1 prueba', 'supervisor1@gmail.com1664832240', NULL, '$2y$10$EGAAwXv/KVpZK8MCH.HjWe1LkdtiluRegPjSfUlrtDLP97i6D6W0i', 'd1VMU6Kgu6JTjNwXjWgXOTzrecb4JUUacoS3KaOlFZpPfBsEms3Rr8YBydxL', '2022-08-16 21:17:41', '2022-10-03 21:24:00', '2022-10-03 21:24:00'),
(13, 'Iván Piedrahita', 'i.piedrahita@imjagroindustrial.com1716329498', NULL, '$2y$10$CSF/KEh0rqvZHYsXEeqbeeyswZJZVUOpRemtcP5.McBJ59aVEPxEa', '1JLwZRWICBKmr9JgYK7tVTi7vfeKwCHjImhZd8Ct7TQK0SsbX5suDfiFjdwf', '2022-08-19 15:29:39', '2024-05-21 22:11:38', '2024-05-21 22:11:38'),
(14, 'María Ávila', 'maria.avila@imjagroindustrial.com1716329491', NULL, '$2y$10$tdbBIN3qUarxZHpGF3J/ku8EIlotQQwPDD5SNET0vgO88E4VbcsV6', 'pYy7VylmjCwcHHuTNS4DSVqT8K96BkEuBJ96dYhBnuIJYvcT81ZbKUI8X3hF', '2022-08-19 15:30:15', '2024-05-21 22:11:31', '2024-05-21 22:11:31'),
(15, 'Jorge Hernandez', 'j.hernandez@imjagroindustrial.com1712161629', NULL, '$2y$10$kOd.KM4WcL8rahdWSEEdH.qPKP.yoxXmrqEI/M1PNAkiUmlEHSovi', 'M7Aub9PSndtZqeg3Vk0AWT9w4q5VNKKnSNT17Ovg5xjbW3M2KvtIaAnFZGTS', '2022-08-19 15:31:17', '2024-04-03 11:27:09', '2024-04-03 11:27:09'),
(16, 'Carlos Leyva', 'cjleyva0505@gmail.com', NULL, '$2y$10$2n7yAIwiV1uasEiDWiWIPuZJ6Qvw7r5aAf70qz65oXoRnT918uFim', 'uZFKLJUVc4sGbr1WlRWgO6AVfvGKSGMrsKPJcaDSI7kd7gLHrpMtiuQf9dkT', '2022-08-19 15:32:13', '2024-05-21 22:12:22', NULL),
(17, 'Auren', 'yohana.garcia@auren.com.co1716332394', NULL, '$2y$10$vzzsbmZwjSjRaVi/MaxCTOYDWsKpBfM3W2Jkcf3Dgvt3j/V9eHbkO', 'D1JtybepqAXyQDXlpMVJqnzD7gTeZIkTLzln2RFnyLSwiP4YhiRvNqGyzsR5', '2022-10-05 21:07:43', '2024-05-21 22:59:54', '2024-05-21 22:59:54'),
(18, 'Pruebas Amparo Leyva', 'amparo.leyva@sipse.com.co1683659220', NULL, '$2y$10$CZixpY63cH18ziE8i/2xMOIujh0YeC9H6bxq9.NPOgwH51meSC5U6', 'uNVN55Lk4QtRfS1dZLKLDrpxnkhfrd1TdKAqlPAL1Gd45VDOXCVhuO8Kllim', '2023-05-09 10:30:57', '2023-05-09 14:07:00', '2023-05-09 14:07:00'),
(19, 'Yohannis Camargo', 'y.camargo@imjagroindustrial.com1716329485', NULL, '$2y$10$CJwqGRMpQqt0D/9KOerMduMpt5Y1C/eo8.eU75WA91ua3sENSnaCa', 'dq0WOnyHhKQ0ZrikqySjDbWVKafemXt5wnVssIIkAwn3OAjz247TCOnDENN9', '2024-01-23 15:57:49', '2024-05-21 22:11:25', '2024-05-21 22:11:25');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `geo_localizacion`
--
ALTER TABLE `geo_localizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_slug_unique` (`slug`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `parametricas`
--
ALTER TABLE `parametricas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `geo_localizacion`
--
ALTER TABLE `geo_localizacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `notes`
--
ALTER TABLE `notes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `parametricas`
--
ALTER TABLE `parametricas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla', AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `geo_localizacion`
--
ALTER TABLE `geo_localizacion`
  ADD CONSTRAINT `geo_localizacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
