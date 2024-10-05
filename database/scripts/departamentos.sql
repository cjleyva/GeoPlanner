-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-08-2022 a las 13:16:45
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
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Identificador de la tabla',
  `codigo_departamento` varchar(10) NOT NULL COMMENT 'codigo divipola del departamento',
  `nombre_departamento` varchar(500) NOT NULL COMMENT 'nombre del departamento',
  `id_param_zona` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'zona en la cual se encuentra el departamento',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creacion',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de edición',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Fecha de eliminación',
  `created_by` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Usuario que crea',
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que edita',
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Usuario que elimina'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `codigo_departamento`, `nombre_departamento`, `id_param_zona`, `created_at`, `updated_at`, `deleted_at`, `created_by`, `updated_by`, `deleted_by`) VALUES
(1, '05', 'Antioquia', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(2, '08', 'Atlántico', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(3, '11', 'Bogota D.C.', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(4, '13', 'Bolívar', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(5, '15', 'Boyacá', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(6, '17', 'Caldas', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(7, '18', 'Caquetá', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(8, '19', 'Cauca', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(9, '20', 'Cesar', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(10, '23', 'Córdoba', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(11, '25', 'Cundinamarca', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(12, '27', 'Chocó', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(13, '41', 'Huila', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(14, '44', 'La Guajira', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(15, '47', 'Magdalena', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(16, '50', 'Meta', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(17, '52', 'Nariño', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(18, '54', 'Norte De Santander', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(19, '63', 'Quindio', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(20, '66', 'Risaralda', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(21, '68', 'Santander', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(22, '70', 'Sucre', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(23, '73', 'Tolima', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(24, '76', 'Valle Del Cauca', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(25, '81', 'Arauca', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(26, '85', 'Casanare', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(27, '86', 'Putumayo', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(28, '88', 'San Andrés', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(29, '91', 'Amazonas', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(30, '94', 'Guainía', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(31, '95', 'Guaviare', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(32, '97', 'Vaupés', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL),
(33, '99', 'Vichada', 6, '2022-08-12 00:12:17', NULL, NULL, 0, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `departamentos_id_param_zona_idx` (`id_param_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla', AUTO_INCREMENT=34;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `departamentos_id_param_zonaXparametricas_fk` FOREIGN KEY (`id_param_zona`) REFERENCES `parametricas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
