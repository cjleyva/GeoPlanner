-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-09-2022 a las 23:01:21
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
-- Estructura de tabla para la tabla `legalizacion_gastos_detalles`
--

CREATE TABLE `legalizacion_gastos_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `id_legalizacion_gasto` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla legalizacion de gastos',
  `fecha_gasto` date NOT NULL COMMENT 'Fecga cuando se realiza el gasto',
  `nombre_tercero_gasto` varchar(255) NOT NULL COMMENT 'Nombre del tercero que hace el gasto',
  `numero_identificacion_gasto` varchar(255) NOT NULL COMMENT 'El numero de identificacion del tercero que hace el gasto',
  `id_param_concepto_gasto` bigint(20) UNSIGNED NOT NULL COMMENT 'El tipo de concepto por el cual se hace el gasto que puede ser hotel,alimentacion,combustible,peajes,parqueadero,transporte,comunicacion,representacion,correo,papeleria copias fax y otros\r\n',
  `valor_gasto` decimal(18,2) NOT NULL COMMENT 'Valor por el cual se hace el gasto',
  `numero_soporte` varchar(255) NOT NULL COMMENT 'El numero del soporte que recibe el tercero la hora del gasto',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
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
-- Indices de la tabla `legalizacion_gastos_detalles`
--
ALTER TABLE `legalizacion_gastos_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_legalizacion_gasto` (`id_legalizacion_gasto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `legalizacion_gastos_detalles`
--
ALTER TABLE `legalizacion_gastos_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `legalizacion_gastos_detalles`
--
ALTER TABLE `legalizacion_gastos_detalles`
  ADD CONSTRAINT `legalizacion_gastos_detalles_ibfk_1` FOREIGN KEY (`id_legalizacion_gasto`) REFERENCES `legalizacion_gastos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
