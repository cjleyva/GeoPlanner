-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 02-09-2022 a las 20:59:18
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
-- Estructura de tabla para la tabla `inv_ordenes_despacho_detalles`
--

CREATE TABLE `inv_ordenes_despacho_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Indentificador de la tabla',
  `id_orden_despacho` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla ordenes de pedidos',
  `id_producto` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla productos',
  `cantidad` decimal(18,2) NOT NULL COMMENT 'Cantidad del producto',
  `lote` varchar(255) NOT NULL COMMENT 'Numero de lote del despacho',
  `fecha_vencimiento` date NOT NULL COMMENT 'Fecha de vencimiento del despacho',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint(20) DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint(20) DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inv_ordenes_despacho_detalles`
--
ALTER TABLE `inv_ordenes_despacho_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orden_despacho` (`id_orden_despacho`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inv_ordenes_despacho_detalles`
--
ALTER TABLE `inv_ordenes_despacho_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Indentificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inv_ordenes_despacho_detalles`
--
ALTER TABLE `inv_ordenes_despacho_detalles`
  ADD CONSTRAINT `inv_ordenes_despacho_detalles_ibfk_1` FOREIGN KEY (`id_orden_despacho`) REFERENCES `inv_ordenes_despacho` (`id`),
  ADD CONSTRAINT `inv_ordenes_despacho_detalles_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `inv_productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
