-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-09-2022 a las 23:02:48
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
-- Estructura de tabla para la tabla `legalizacion_gastos`
--

CREATE TABLE `legalizacion_gastos` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `id_user` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla usuarios',
  `numero_identificacion_legalizacion` varchar(255) NOT NULL COMMENT 'El numero de identidicacion del nonbre de usuario',
  `fecha_legalizacion` date NOT NULL COMMENT 'Fecha en la que se pacta la legalizacion del gasto',
  `ciudad_legaclizacion` varchar(255) NOT NULL COMMENT 'Ciudad donde se hace la legalizacion del gasto',
  `concepto_legalizacion` varchar(255) NOT NULL COMMENT 'Concepto por el cual se hace la legalizacion del gasto',
  `valor_anticipo_legalizacion` decimal(18,2) DEFAULT NULL COMMENT 'El valor del anticipo de la legalizacion del gasto',
  `total_legalizacion` decimal(18,6) DEFAULT NULL COMMENT 'El total de la legalizacion del gasto',
  `excedente_faltante_legalizacion` decimal(18,2) DEFAULT NULL COMMENT 'Es el excedente o el faltante de la legalizacion del gasto',
  `observaciones_legalizacion` text COMMENT 'Si la legalizacion de gasto lleva alguna observacion',
  `id_param_estado` int(11) NOT NULL DEFAULT '1' COMMENT 'Estados que controlan la legalizacion de gastos, en el caso 1=en En registro, 2=Pendiente autorizar, 3=Autorizado, 4=Rechazado, ',
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
-- Indices de la tabla `legalizacion_gastos`
--
ALTER TABLE `legalizacion_gastos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `legalizacion_gastos`
--
ALTER TABLE `legalizacion_gastos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `legalizacion_gastos`
--
ALTER TABLE `legalizacion_gastos`
  ADD CONSTRAINT `legalizacion_gastos_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
