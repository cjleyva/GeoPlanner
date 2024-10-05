-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-08-2022 a las 13:36:50
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `imj_inventarios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametricas`
--

CREATE TABLE `parametricas` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `categoria` varchar(100) NOT NULL COMMENT 'Categoria de agrupacion de la parametrica',
  `valor` varchar(100) NOT NULL COMMENT 'Valor que tiene la parametrica',
  `texto` varchar(500) NOT NULL COMMENT 'texto que expone la parametrica',
  `descripcion` text NOT NULL COMMENT 'Descripcion de la parametrica',
  `orden` int(11) NOT NULL DEFAULT '100' COMMENT 'Orden en el cual se muestran los datos cuando es un select o una lista',
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT 'Estado de la parametrica, si es 1 es activo, si es 0 es inactivo',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `parametricas`
--

INSERT INTO `parametricas` (`id`, `categoria`, `valor`, `texto`, `descripcion`, `orden`, `estado`, `created_at`, `updated_at`, `deleted_at`, `created_by`, `updated_by`, `deleted_by`) VALUES
(1, 'tercero_param_tipo_persona', '1', 'Persona Natural', 'Tipo de persona natural', 100, 1, '2022-08-11 23:20:40', NULL, NULL, 0, NULL, NULL),
(2, 'tercero_param_tipo_persona', '2', 'Persona Jurídica', 'Tipo de persona jurídica', 200, 1, '2022-08-11 23:20:40', NULL, NULL, 0, NULL, NULL),
(3, 'tercero_param_tipo_documento', '1', 'Cédula Ciudadanía', 'Tipo de documento de cedula de cuidadania', 100, 1, '2022-08-11 23:53:42', NULL, NULL, 0, NULL, NULL),
(4, 'tercero_param_tipo_documento', '2', 'Nit', 'Tipo de documento nit', 200, 1, '2022-08-11 23:53:42', NULL, NULL, 0, NULL, NULL),
(5, 'tercero_param_tipo_documento', '3', 'Cédula Extranjería', 'Tipo de documento de cédula de ectranjería', 300, 1, '2022-08-11 23:53:42', NULL, NULL, 0, NULL, NULL),
(6, 'id_param_zona', '1', 'colombia', 'todo el pais', 100, 1, '2022-08-12 00:12:04', NULL, NULL, 1, NULL, NULL),
(7, 'pedidos_param_forma_pago', '1', 'Crédito', 'Forma de pago de crédito', 100, 1, '2022-08-12 13:27:40', NULL, NULL, 0, NULL, NULL),
(8, 'pedidos_param_forma_pago', '2', 'Contado', 'Forma de pago de contado', 200, 1, '2022-08-12 13:27:40', NULL, NULL, 0, NULL, NULL),
(9, 'pedidos_param_dia_fecha_factura', '1', '30', 'Dias 30 de la fecha de la factura ', 100, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(10, 'pedidos_param_dia_fecha_factura', '2', '45', 'Dias 45 de la fecha de la factura', 200, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(11, 'pedidos_param_dia_fecha_factura', '3', '60', 'Dias 60 de la fecha de la factura', 300, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(12, 'pedidos_param_dia_fecha_factura', '4', '90', 'Dias 90 de la fecha de la factura', 400, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(13, 'pedidos_param_dia_fecha_factura', '5', '120', 'Dias 120 de la fecha de la factura', 500, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(14, 'pedidos_param_dia_fecha_factura', '6', '150', 'Dias 150 de la fecha de la factura', 600, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL),
(15, 'pedidos_param_dia_fecha_factura', '7', '180', 'Dias 180 de la fecha de la factura', 700, 1, '2022-08-12 13:35:52', NULL, NULL, 0, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `parametricas`
--
ALTER TABLE `parametricas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `parametricas`
--
ALTER TABLE `parametricas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla', AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
