-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-05-2023 a las 19:41:21
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
-- Estructura de tabla para la tabla `inv_orden_compra`
--

CREATE TABLE `inv_orden_compra` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla	',
  `id_tercero` bigint(20) UNSIGNED NOT NULL COMMENT 'identificador de proveedor',
  `id_user` bigint(20) UNSIGNED NOT NULL COMMENT 'identificador del usuario que elabora la orden de compra',
  `id_param_forma_de_pago` bigint(20) UNSIGNED NOT NULL COMMENT 'forma de pago, efectivo, tarjeta, consignacion, cheque',
  `id_param_dias_factura` bigint(20) DEFAULT NULL COMMENT 'dias para la facturacion (30,60,90,180)',
  `fecha_orden_compra` date NOT NULL COMMENT 'Fecha de la solicitud de la orden',
  `fecha_entrega` date NOT NULL COMMENT 'Fecha de entrega de la orden de compra',
  `direccion_entrega` varchar(255) NOT NULL COMMENT ' dirección de la entrega ',
  `id_param_estado` int(11) NOT NULL DEFAULT '1' COMMENT 'Estados que controlan el pedido, en el caso 1=en creacion, 2=creado, pasa a aprobacion, 3=aprobado, 4=despachado, 5=entregado',
  `observaciones_compra` text COMMENT 'observaciones de la orden de compra',
  `valor_sub_total` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'sub total de la compra',
  `descuento_compra` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'descuento que se hace en la orden de compra',
  `valor_sub_total_menos_descuento` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'el valor total con el menos el descuento',
  `valor_impuesto` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'impuesto de la orden de compra',
  `valor_total` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'valor total de la orden de compra',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación	',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición	',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación	',
  `created_by` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea	',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita	',
  `deleted_by` bigint(20) DEFAULT NULL COMMENT 'Usuario que elimina	'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inv_orden_compra_detalles`
--

CREATE TABLE `inv_orden_compra_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `id_orden_compra` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla de la tabla orden de compra',
  `id_producto` bigint(20) UNSIGNED NOT NULL COMMENT 'identificador de la tabla productos',
  `cantidad` decimal(18,2) NOT NULL COMMENT 'cantidad del producto',
  `precio_unitario` decimal(18,0) NOT NULL DEFAULT '0' COMMENT 'precio unitario del producto',
  `precio_total` decimal(18,0) NOT NULL COMMENT 'precio total del producto según la cantidad',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '	Fecha de creación',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inv_orden_compra`
--
ALTER TABLE `inv_orden_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inv_orden_compra_ibfk_2` (`id_user`),
  ADD KEY `id_tercero` (`id_tercero`);

--
-- Indices de la tabla `inv_orden_compra_detalles`
--
ALTER TABLE `inv_orden_compra_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orden_compra` (`id_orden_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inv_orden_compra`
--
ALTER TABLE `inv_orden_compra`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla	';

--
-- AUTO_INCREMENT de la tabla `inv_orden_compra_detalles`
--
ALTER TABLE `inv_orden_compra_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inv_orden_compra`
--
ALTER TABLE `inv_orden_compra`
  ADD CONSTRAINT `inv_orden_compra_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `inv_orden_compra_ibfk_3` FOREIGN KEY (`id_tercero`) REFERENCES `terceros` (`id`);

--
-- Filtros para la tabla `inv_orden_compra_detalles`
--
ALTER TABLE `inv_orden_compra_detalles`
  ADD CONSTRAINT `inv_orden_compra_detalles_ibfk_1` FOREIGN KEY (`id_orden_compra`) REFERENCES `inv_orden_compra` (`id`),
  ADD CONSTRAINT `inv_orden_compra_detalles_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `inv_productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
