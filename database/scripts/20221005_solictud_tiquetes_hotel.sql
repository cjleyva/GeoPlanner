-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-10-2022 a las 21:13:58
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
-- Estructura de tabla para la tabla `solictud_tiquetes_hotel`
--

CREATE TABLE `solictud_tiquetes_hotel` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `nombre_apellido` varchar(255) NOT NULL COMMENT 'Nombre y apellidos del que hace la solicitud',
  `numero_identificacion` varchar(255) NOT NULL COMMENT 'Numero de identificacion de la persona que hace la solicitud',
  `fecha_registro` date NOT NULL COMMENT 'Fecha de registro cuando se genera la solicitud',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de la nacimiento de la persona que hace la solicitud',
  `id_municipio_salida` bigint(20) UNSIGNED NOT NULL COMMENT 'Municipio donde se hace la salida',
  `fecha_hora_salida` datetime NOT NULL COMMENT 'Fecha y hora de la salida',
  `id_municipio_destino` bigint(20) UNSIGNED NOT NULL COMMENT 'Municipio del destino',
  `fecha_hora_destino` datetime NOT NULL COMMENT 'fecha y hora del destion',
  `nesecita_hotel` int(11) NOT NULL COMMENT 'Si nesecita hotel o no ',
  `motivo_viaje` text COMMENT 'Motivo del viaje',
  `observaciones` text COMMENT 'Observaciones',
  `id_param_estado` bigint(20) UNSIGNED NOT NULL COMMENT 'Estados que controlan la solicitud de tiquetes y hotel, en el caso 1=en En registro, 2=Pendiente autorizar, 3=Autorizado, 4=Rechazado',
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
-- Indices de la tabla `solictud_tiquetes_hotel`
--
ALTER TABLE `solictud_tiquetes_hotel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_municipio_salida` (`id_municipio_salida`),
  ADD KEY `id_municipio_destino` (`id_municipio_destino`),
  ADD KEY `id_param_estado` (`id_param_estado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `solictud_tiquetes_hotel`
--
ALTER TABLE `solictud_tiquetes_hotel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solictud_tiquetes_hotel`
--
ALTER TABLE `solictud_tiquetes_hotel`
  ADD CONSTRAINT `solictud_tiquetes_hotel_ibfk_1` FOREIGN KEY (`id_municipio_salida`) REFERENCES `municipios` (`id`),
  ADD CONSTRAINT `solictud_tiquetes_hotel_ibfk_2` FOREIGN KEY (`id_municipio_destino`) REFERENCES `municipios` (`id`),
  ADD CONSTRAINT `solictud_tiquetes_hotel_ibfk_3` FOREIGN KEY (`id_param_estado`) REFERENCES `parametricas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
