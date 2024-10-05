-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 02-09-2022 a las 21:33:35
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
-- Estructura de tabla para la tabla `inv_ordenes_despacho`
--

CREATE TABLE `inv_ordenes_despacho` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `id_pedido` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla pedidos',
  `fecha_despacho` date NOT NULL COMMENT 'Fecha cuando se genera el despacho',
  `id_tercero` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla terceros',
  `n_documento_cliente` varchar(255) NOT NULL COMMENT 'Numero de identificacion del cliente',
  `correo_cliente` varchar(255) DEFAULT NULL COMMENT 'Correo del cliente',
  `telefono_cliente` varchar(255) NOT NULL COMMENT 'Telefono del cliente',
  `direcion_entrega_pedido` varchar(255) NOT NULL COMMENT 'Direccion de la entrega del pedido',
  `contacto_entrega_pedido` varchar(255) NOT NULL COMMENT 'Contacto que se encarga de la entrega del pedido',
  `fecha_entrega_pedido` varchar(255) NOT NULL COMMENT 'Fecha cuando se entrega el pedido',
  `id_municipio_entrega` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla municipios',
  `id_condicion_entrega` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la parametrica de tipo de condicion de entraga',
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
-- Indices de la tabla `inv_ordenes_despacho`
--
ALTER TABLE `inv_ordenes_despacho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_municipio_entrega` (`id_municipio_entrega`),
  ADD KEY `id_condicion_entrega` (`id_condicion_entrega`),
  ADD KEY `id_tercero` (`id_tercero`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inv_ordenes_despacho`
--
ALTER TABLE `inv_ordenes_despacho`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inv_ordenes_despacho`
--
ALTER TABLE `inv_ordenes_despacho`
  ADD CONSTRAINT `inv_ordenes_despacho_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `inv_pedidos` (`id`),
  ADD CONSTRAINT `inv_ordenes_despacho_ibfk_3` FOREIGN KEY (`id_municipio_entrega`) REFERENCES `municipios` (`id`),
  ADD CONSTRAINT `inv_ordenes_despacho_ibfk_4` FOREIGN KEY (`id_condicion_entrega`) REFERENCES `parametricas` (`id`),
  ADD CONSTRAINT `inv_ordenes_despacho_ibfk_5` FOREIGN KEY (`id_tercero`) REFERENCES `terceros` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
