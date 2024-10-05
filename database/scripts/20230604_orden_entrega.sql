-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-06-2023 a las 14:55:47
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
-- Estructura de tabla para la tabla `inv_orden_entrega`
--

CREATE TABLE `inv_orden_entrega` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `id_compra` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla orden de compra',
  `fecha_orden_entrega` date NOT NULL COMMENT 'Fecha cuando se genera la orden de entrega',
  `id_proveedor` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla terceros',
  `numero _identificacion_proveedor` varchar(255) NOT NULL COMMENT 'Numero de identificación del proveedor',
  `telefono_proveedor` varchar(255) NOT NULL COMMENT 'Teléfono del proveedor',
  `direccion_entrega` varchar(255) NOT NULL COMMENT 'Dirección de la orden de entrega',
  `contacto_entrega_compra` varchar(255) NOT NULL COMMENT 'Contacto que se encarga de la entrega',
  `fecha_entrega` date NOT NULL COMMENT 'Fecha cuando se entrega la orden de compra',
  `id_municipio_entrega` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla municipios',
  `nombre_transportador` varchar(255) NOT NULL COMMENT 'Nombre de la persona que hace el transporte de la orden de entrega',
  `numero_cedula_transportador` varchar(255) NOT NULL COMMENT 'Numero de cedula del transportador	',
  `vehiculo_transporte` varchar(255) NOT NULL COMMENT 'Nombre del vehículo	',
  `placa_vehiculo` varchar(255) NOT NULL COMMENT 'Placa del vehículo	',
  `observaciones_entrega` text COMMENT 'Observaciones de la entrega',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación	',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT '	Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inv_orden_entrega_detalles`
--

CREATE TABLE `inv_orden_entrega_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabala',
  `id_orden_entrega` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la orden de entrega',
  `id_detalle_orden_compra` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla ordenes de compra detalles',
  `id_producto` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla productos',
  `cantidad_entregada` decimal(18,2) NOT NULL COMMENT 'Cantidad de orden entregada',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación	',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición	',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación	',
  `created_by` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea	',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita	',
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inv_orden_entrega`
--
ALTER TABLE `inv_orden_entrega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_municipio_entrega` (`id_municipio_entrega`);

--
-- Indices de la tabla `inv_orden_entrega_detalles`
--
ALTER TABLE `inv_orden_entrega_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orden_entrega` (`id_orden_entrega`),
  ADD KEY `id_detalle_orden_compra` (`id_detalle_orden_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inv_orden_entrega`
--
ALTER TABLE `inv_orden_entrega`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- AUTO_INCREMENT de la tabla `inv_orden_entrega_detalles`
--
ALTER TABLE `inv_orden_entrega_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabala';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inv_orden_entrega`
--
ALTER TABLE `inv_orden_entrega`
  ADD CONSTRAINT `inv_orden_entrega_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `inv_orden_compra` (`id`),
  ADD CONSTRAINT `inv_orden_entrega_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `terceros` (`id`),
  ADD CONSTRAINT `inv_orden_entrega_ibfk_3` FOREIGN KEY (`id_municipio_entrega`) REFERENCES `municipios` (`id`);

--
-- Filtros para la tabla `inv_orden_entrega_detalles`
--
ALTER TABLE `inv_orden_entrega_detalles`
  ADD CONSTRAINT `inv_orden_entrega_detalles_ibfk_1` FOREIGN KEY (`id_orden_entrega`) REFERENCES `inv_orden_entrega` (`id`),
  ADD CONSTRAINT `inv_orden_entrega_detalles_ibfk_2` FOREIGN KEY (`id_detalle_orden_compra`) REFERENCES `inv_orden_compra_detalles` (`id`),
  ADD CONSTRAINT `inv_orden_entrega_detalles_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `inv_productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
