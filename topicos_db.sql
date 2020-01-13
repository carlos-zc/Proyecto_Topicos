-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-01-2020 a las 18:21:01
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `topicos_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` double NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipio` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ejemplo.png',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `nombre`, `tipo`, `precio`, `descripcion`, `municipio`, `foto`, `user_id`, `user_name`, `created_at`, `updated_at`) VALUES
(1, 'Casa en la playa', 'Casa', 20000, NULL, 'Puerto Cabello', '1578894007.jpeg', 1, 'Carlos Zapata', '2020-01-13 05:39:06', '2020-01-13 05:40:07'),
(2, 'Casa en la Pradera', 'Quinta', 40000, NULL, 'Guacara', 'ejemplo.png', 2, 'Peter Prueba', '2020-01-13 05:44:36', '2020-01-13 05:44:36'),
(3, 'Proban2', 'Townhouse', 12500, NULL, 'San Diego', '1578894336.jpeg', 2, 'Peter Prueba', '2020-01-13 05:45:37', '2020-01-13 05:45:37'),
(4, 'Casa en el árbol', 'Casa', 300, NULL, 'Bejuma', 'ejemplo.png', 2, 'Peter Prueba', '2020-01-13 05:46:46', '2020-01-13 05:46:46'),
(5, 'Comprala', 'Apartamento', 8800, NULL, 'Miranda', 'ejemplo.png', 2, 'Peter Prueba', '2020-01-13 05:47:21', '2020-01-13 05:47:21'),
(6, 'Casona with piscina', 'Townhouse', 22500, NULL, 'Guacara', '1578894500.jpeg', 2, 'Peter Prueba', '2020-01-13 05:48:08', '2020-01-13 05:48:21'),
(7, 'Ganaderia', 'Quinta', 50000, NULL, 'Bejuma', 'ejemplo.png', 2, 'Peter Prueba', '2020-01-13 05:50:06', '2020-01-13 05:50:06'),
(8, 'Chozita', 'Casa', 33000, NULL, 'Naguanagua', '1578894724.jpeg', 1, 'Carlos Zapata', '2020-01-13 05:52:04', '2020-01-13 05:52:04'),
(9, 'Sendo Pent-House 7 pisos', 'Apartamento', 180000, NULL, 'Valencia', '1578894828.jpeg', 1, 'Carlos Zapata', '2020-01-13 05:53:49', '2020-01-13 05:53:49'),
(10, 'Casa sin baño', 'Casa', 82, NULL, 'San Joaquín', 'ejemplo.png', 1, 'Carlos Zapata', '2020-01-13 05:54:48', '2020-01-13 05:54:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_01_09_194149_create_inmuebles_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'perfil.png',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `city`, `state`, `ci`, `birth`, `active`, `type`, `photo`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Carlos Zapata', 'carloszapatac17@gmail.com', NULL, '$2y$10$h.kdQYRaKlbsaQgV3gnQ/OUJ4ui.SMPG3E8fbTUxjxFbQrVBKGYta', 'Valencia', 'Carabobo', '27488851', '1998-02-17', 1, 'user', '1578894075.png', NULL, '2020-01-13 05:27:07', '2020-01-13 05:41:17'),
(2, 'Peter Prueba', 'peter@prueba.com', NULL, '$2y$10$qRLO0ae8JsuIi6jM6jlcMu973VWdK1DmXZEyKhaAudES5rwtMc1KC', 'Lugar', 'Bolívar', '31431431', '2020-01-01', 0, 'user', 'perfil.png', NULL, '2020-01-13 05:42:41', '2020-01-13 05:43:43'),
(3, 'Ericka Torphy', 'tania.barrows@example.org', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '22239543', NULL, 0, 'user', 'perfil.png', 'tDwEnsQAkG', '2020-01-13 05:59:23', '2020-01-13 05:59:23'),
(4, 'Dameon Douglas', 'yost.sierra@example.org', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '29730611', NULL, 0, 'user', 'perfil.png', 'UrYuG65HEF', '2020-01-13 05:59:23', '2020-01-13 05:59:23'),
(5, 'Lacy Rosenbaum DVM', 'dfeest@example.org', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '43448126', NULL, 0, 'user', 'perfil.png', 't51AJzQ8C3', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(6, 'Mr. Lavon Abernathy', 'candice11@example.com', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '20802681', NULL, 0, 'user', 'perfil.png', 'ZD0KHtRy8L', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(7, 'Prof. Ruthe Thiel DVM', 'zack16@example.net', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '37875351', NULL, 0, 'user', 'perfil.png', 'xpxqyihKUL', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(8, 'Mattie Sawayn', 'reichert.myrtle@example.net', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '40482993', NULL, 0, 'user', 'perfil.png', 'GygZyCqZDH', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(9, 'Dameon Macejkovic', 'emoen@example.com', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '48070165', NULL, 0, 'user', 'perfil.png', '4UB8ee2bf6', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(10, 'Stephan Sawayn MD', 'legros.christ@example.com', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '19020201', NULL, 0, 'user', 'perfil.png', 'DlzYH0LFLq', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(11, 'Griffin Abernathy', 'chester53@example.org', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '1809378', NULL, 0, 'user', 'perfil.png', 'tm6DfVaSI8', '2020-01-13 05:59:24', '2020-01-13 05:59:24'),
(12, 'Toby Gislason', 'lourdes.hickle@example.com', '2020-01-13 05:59:23', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, '42546117', NULL, 0, 'user', 'perfil.png', 'Hw8qIrRjYN', '2020-01-13 05:59:24', '2020-01-13 05:59:24');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inmuebles_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD CONSTRAINT `inmuebles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
