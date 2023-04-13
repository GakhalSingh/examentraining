-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 13 apr 2023 om 13:49
-- Serverversie: 10.4.24-MariaDB
-- PHP-versie: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `imdb`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230413094528', '2023-04-13 11:46:28', 391);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `episode`
--

CREATE TABLE `episode` (
  `id` int(11) NOT NULL,
  `serie_id` int(11) NOT NULL,
  `season` int(11) NOT NULL,
  `part` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `episode`
--

INSERT INTO `episode` (`id`, `serie_id`, `season`, `part`, `name`, `duration`) VALUES
(1, 3, 1, 1, 'Episode #1.1\r\n', '00:58:00'),
(2, 3, 1, 2, 'Episode #1.2\r\n', '00:58:00'),
(3, 2, 1, 1, 'Chapter 1: Stranger in a Strange Land\r\n', '00:38:00'),
(4, 2, 1, 2, 'Chapter 2: The Tribes of Tatooine\r\n', '00:51:00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `genre`
--

INSERT INTO `genre` (`id`, `name`) VALUES
(1, 'comedy'),
(2, 'drama'),
(3, 'action'),
(4, 'fantasy'),
(5, 'crime'),
(6, 'sci-fi'),
(8, 'exam'),
(9, 'test'),
(10, 'horror');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `serie`
--

CREATE TABLE `serie` (
  `id` int(11) NOT NULL,
  `relation_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `serie`
--

INSERT INTO `serie` (`id`, `relation_id`, `title`, `description`, `year`) VALUES
(1, 6, 'The Mandolorian ', 'The Mandalorian is een liveactionserie in het Star Wars-universum op het streamingplatform Disney+. De serie werd bedacht door Jon Favreau en geproduceerd door Lucasfilm. Hij speelt zich af tussen de films Return of the Jedi en The Force Awakens. Het tite', 2019),
(2, 6, 'The Book of Boba Fett', 'The Book of Boba Fett is een Amerikaanse sci-fi televisieserie. De serie maakt deel uit van de Star Wars-franchise en is een spin-off van de serie The Mandalorian en gaat over de premiejager Boba Fett.', 2021),
(3, 5, 'Peaky Blinders', 'Peaky Blinders is een Britse historische dramaserie van Steven Knight. De serie gaat over de Peaky Blinders, een criminele bende uit Birmingham, en hun activiteiten in Birmingham kort na de Eerste Wereldoorlog.\r\n', 2022);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexen voor tabel `episode`
--
ALTER TABLE `episode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_DDAA1CDAD94388BD` (`serie_id`);

--
-- Indexen voor tabel `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexen voor tabel `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AA3A93343256915B` (`relation_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `episode`
--
ALTER TABLE `episode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT voor een tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `serie`
--
ALTER TABLE `serie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `episode`
--
ALTER TABLE `episode`
  ADD CONSTRAINT `FK_DDAA1CDAD94388BD` FOREIGN KEY (`serie_id`) REFERENCES `serie` (`id`);

--
-- Beperkingen voor tabel `serie`
--
ALTER TABLE `serie`
  ADD CONSTRAINT `FK_AA3A93343256915B` FOREIGN KEY (`relation_id`) REFERENCES `genre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
