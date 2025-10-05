-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-10-2025 a las 01:58:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hce`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipos_medicos`
--

CREATE TABLE `equipos_medicos` (
  `id` int(5) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `ubicacion` int(20) NOT NULL,
  `responsable` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipos_medicos`
--

INSERT INTO `equipos_medicos` (`id`, `codigo`, `marca`, `modelo`, `ubicacion`, `responsable`) VALUES
(1, 'EQ-001', 'Philips', 'HeartStart XL', 10, 112),
(2, 'EQ-002', 'GE', 'B105', 11, 113),
(3, 'EQ-003', 'Siemens', 'Somatom Go', 9, 115),
(4, 'EQ-004', 'Mindray', 'BeneVision N22', 5, 150),
(5, 'EQ-005', 'Medtronic', 'Puritan Bennett 840', 10, 58),
(13, 'EQ001', 'Siemens', 'MX100', 1, 1),
(14, 'EQ002', 'Philips', 'PR200', 2, 2),
(15, 'EQ003', 'GE', 'GE300', 3, 3),
(16, 'EQ004', 'Mindray', 'MR400', 4, 4),
(17, 'EQ005', 'Dräger', 'DR500', 5, 5),
(18, 'EQ006', 'Siemens', 'MX110', 6, 6),
(19, 'EQ007', 'Philips', 'PR210', 7, 7),
(20, 'EQ008', 'GE', 'GE310', 8, 8),
(21, 'EQ009', 'Mindray', 'MR410', 9, 9),
(22, 'EQ010', 'Dräger', 'DR510', 10, 10),
(23, 'EQ011', 'Siemens', 'MX120', 1, 11),
(24, 'EQ012', 'Philips', 'PR220', 2, 12),
(25, 'EQ013', 'GE', 'GE320', 3, 13),
(26, 'EQ014', 'Mindray', 'MR420', 4, 14),
(27, 'EQ015', 'Dräger', 'DR520', 5, 15),
(28, 'EQ016', 'Siemens', 'MX130', 6, 16),
(29, 'EQ017', 'Philips', 'PR230', 7, 17),
(30, 'EQ018', 'GE', 'GE330', 8, 18),
(31, 'EQ019', 'Mindray', 'MR430', 9, 19),
(32, 'EQ020', 'Dräger', 'DR530', 10, 20),
(33, 'EQ021', 'Siemens', 'MX140', 1, 2),
(34, 'EQ022', 'Philips', 'PR240', 2, 4),
(35, 'EQ023', 'GE', 'GE340', 3, 6),
(36, 'EQ024', 'Mindray', 'MR440', 4, 8),
(37, 'EQ025', 'Dräger', 'DR540', 5, 10),
(38, 'EQ026', 'Siemens', 'MX150', 6, 12),
(39, 'EQ027', 'Philips', 'PR250', 7, 14),
(40, 'EQ028', 'GE', 'GE350', 8, 16),
(41, 'EQ029', 'Mindray', 'MR450', 9, 18),
(42, 'EQ030', 'Dräger', 'DR550', 10, 20),
(43, 'EQ031', 'Siemens', 'MX160', 1, 3),
(44, 'EQ032', 'Philips', 'PR260', 2, 5),
(45, 'EQ033', 'GE', 'GE360', 3, 7),
(46, 'EQ034', 'Mindray', 'MR460', 4, 9),
(47, 'EQ035', 'Dräger', 'DR560', 5, 11),
(48, 'EQ036', 'Siemens', 'MX170', 6, 13),
(49, 'EQ037', 'Philips', 'PR270', 7, 15),
(50, 'EQ038', 'GE', 'GE370', 8, 17),
(51, 'EQ039', 'Mindray', 'MR470', 9, 19),
(52, 'EQ040', 'Dräger', 'DR570', 10, 1),
(53, 'EQ041', 'Siemens', 'MX180', 1, 20),
(54, 'EQ042', 'Philips', 'PR280', 2, 18),
(55, 'EQ043', 'GE', 'GE380', 3, 16),
(56, 'EQ044', 'Mindray', 'MR480', 4, 14),
(57, 'EQ045', 'Dräger', 'DR580', 5, 12),
(58, 'EQ046', 'Siemens', 'MX190', 6, 10),
(59, 'EQ047', 'Philips', 'PR290', 7, 8),
(60, 'EQ048', 'GE', 'GE390', 8, 6),
(61, 'EQ049', 'Mindray', 'MR490', 9, 4),
(62, 'EQ050', 'Dräger', 'DR590', 10, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(2) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `documento`, `nombre`, `apellido`) VALUES
(1, '1012164555', 'Juanito', 'Jimenez'),
(2, '4678154630', 'Maria Mercedez', 'Mesa Mejia'),
(5, '52164', 'Armando ', 'Mesa'),
(6, '546481', 'Sofia', 'Sarosa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responsables`
--

CREATE TABLE `responsables` (
  `id` int(5) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `documento` int(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `responsables`
--

INSERT INTO `responsables` (`id`, `codigo`, `documento`, `nombre`, `apellido`, `cargo`, `telefono`) VALUES
(1, 'RESP-01', 1011234567, 'Laura Lucía', 'Castro Carmona', 'Enfermera Jefe', '3101234567'),
(2, 'RESP-02', 1012234568, 'Andrés', 'Moreno', 'Médico Intensivista', '3102234568'),
(3, 'RESP-03', 1013234569, 'Sofía', 'Rojas', 'Ingeniera Biomédica', '3103234569'),
(4, 'RESP-04', 1014234570, 'Diego', 'Hernández', 'Técnico Biomédico', '3104234570'),
(5, 'RESP-05', 1015234571, 'Camila', 'Suárez', 'Jefa de Mantenimiento', '3105234571'),
(7, 'R001', 1003004001, 'Carlos', 'García', 'Médico', '3101111111'),
(8, 'R002', 1003004002, 'Ana', 'Martínez', 'Enfermera', '3101111112'),
(9, 'R003', 1003004003, 'Jorge', 'López', 'Técnico Biomédico', '3101111113'),
(10, 'R004', 1003004004, 'María', 'Hernández', 'Médico', '3101111114'),
(11, 'R005', 1003004005, 'Andrés', 'Ramírez', 'Enfermero', '3101111115'),
(12, 'R006', 1003004006, 'Lucía', 'Pérez', 'Técnico Biomédico', '3101111116'),
(13, 'R007', 1003004007, 'Sofía', 'Moreno', 'Médico', '3101111117'),
(14, 'R008', 1003004008, 'Felipe', 'Torres', 'Enfermero', '3101111118'),
(15, 'R009', 1003004009, 'Paula', 'Castro', 'Enfermera', '3101111119'),
(16, 'R010', 1003004010, 'Mateo', 'Rojas', 'Médico', '3101111120'),
(17, 'R011', 1003004011, 'Camila', 'Jiménez', 'Enfermera', '3101111121'),
(18, 'R012', 1003004012, 'David', 'Cruz', 'Técnico Biomédico', '3101111122'),
(19, 'R013', 1003004013, 'Laura', 'Gómez', 'Médico', '3101111123'),
(20, 'R014', 1003004014, 'Valentina', 'Suárez', 'Enfermera', '3101111124'),
(22, 'R016', 1003004016, 'Manuel', 'Ortega', 'Enfermero', '3101111126'),
(23, 'R017', 1003004017, 'Carolina', 'Córdoba', 'Médico', '3101111127'),
(24, 'R018', 1003004018, 'Esteban', 'Muñoz', 'Técnico Biomédico', '3101111128'),
(25, 'R019', 1003004019, 'Natalia', 'Reyes', 'Enfermera', '3101111129'),
(26, 'R020', 1003004020, 'Simón', 'Díaz', 'Médico', '3101111130');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `id` int(5) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`id`, `codigo`, `nombre`, `ubicacion`, `telefono`) VALUES
(1, 'UC-01', 'Urgencias Adultos', 'Piso 1 - Bloque A', '6041234567'),
(2, 'UC-02', 'Urgencias Pediátricas', 'Piso 1 - Bloque B', '6042234567'),
(3, 'UC-03', 'Unidad de Cuidados Intensivos', 'Piso 2 - Bloque A', '6043234567'),
(4, 'UC-04', 'Hospitalización General', 'Piso 3 - Bloque C', '6044234567'),
(10, 'UB001', 'Sala de Urgencias', 'Piso 1 - Ala Norte', '3001234567'),
(11, 'UB002', 'Quirófano 1', 'Piso 2 - Sector A', '3001234568'),
(12, 'UB003', 'Quirófano 2', 'Piso 2 - Sector B', '3001234569'),
(13, 'UB004', 'UCI Adultos', 'Piso 3 - Ala Este', '3001234570'),
(14, 'UB005', 'UCI Neonatal', 'Piso 3 - Ala Oeste', '3001234571'),
(15, 'UB006', 'Hospitalización A', 'Piso 4 - Sector A', '3001234572'),
(16, 'UB007', 'Hospitalización B', 'Piso 4 - Sector B', '3001234573'),
(17, 'UB008', 'Imagenología', 'Piso 1 - Ala Sur', '3001234574'),
(18, 'UB009', 'Laboratorio Clínico', 'Piso 1 - Ala Este', '3001234575'),
(19, 'UB010', 'Farmacia', 'Piso 1 - Ala Central', '3001234576');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `equipos_medicos`
--
ALTER TABLE `equipos_medicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `responsables`
--
ALTER TABLE `responsables`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `equipos_medicos`
--
ALTER TABLE `equipos_medicos`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `responsables`
--
ALTER TABLE `responsables`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
