-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 09, 2025 at 04:44 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myreusehub`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `seller_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_url` text NOT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `seller_id`, `name`, `description`, `image_url`, `price`, `quantity`, `deleted`) VALUES
(7, 2, 'Sertifikat AMD', 'Lumayan buat TAK bisa dipake', 'assets/uploads/cbe7688b-418e-473c-9239-e495c05fd4fe.jpg', 2000000, 1, 1),
(8, 3, 'Tahu goreng', 'Lebih enak dari tempe goreng sebelah', 'assets/uploads/de806ae5-9cdf-42fb-915b-74d3f2c46821.jpg', 15000, 500, 0),
(10, 2, 'Flutter Course', 'Menjual course flutter dengan harga paling murah!', 'assets/uploads/0cd92a6f-c6dc-4679-aade-f6410e66498b.jpg', 100000, 110, 1),
(11, 2, 'Lemari', 'Lemari murah, bagus untuk di kamar tidur!', 'assets/uploads/c22e0ba2-f844-4720-ad69-a0febcfc8db5.webp', 500000, 480, 1),
(12, 3, 'New York', 'We\'re bringing the energy of New York City right here to you. With a vibe that\'s as vibrant and dynamic as the city itself, we offer an experience that captures the essence of one of the most iconic places in the world. Whether it\'s the hustle of the streets, the bright lights, or the limitless opportunities, we\'re selling the spirit of New York City up in here, and we\'re ready to share it with you.', 'assets/uploads/10536756-37b3-4f07-be6b-2708f05799ea.webp', 1e16, 1, 0),
(14, 3, 'Discord', 'We sell discord too! BUY BUY BUY NOW!!!!!', 'assets/uploads/b72982bf-79f5-4965-af5e-1344d765d878.png', 1028371412513, 1, 0),
(16, 2, 'Youtube', 'Yeah youtube fell off, we selling it!', 'assets/uploads/bcb79073-0903-4c27-a471-5c16260d93f4.png', 12038971298312, 1, 0),
(18, 3, 'Tenzen', 'svrtgndsc', 'assets/uploads/12c5261b-efb6-4a5e-95db-1f344e7c93d9.jpg', 1456722, 12456, 0),
(19, 4, 'What is this bruh', 'I dont know who this guy is', 'assets/uploads/e2b2e66a-e2e3-424b-ac82-d9745897f502.webp', 120000, 41, 0),
(20, 3, 'Cute cat', 'Our cat is very cute, not for sell tho, you can only see it', 'assets/uploads/d2fe1074-7715-49a3-9ab3-2627c3a41f74.gif', 10000000, 100, 0),
(22, 5, 'pisgor', 'Enak', 'assets/uploads/dca65181-315d-4487-87a9-0cdc133196d9.jpeg', 10000, 980, 0),
(26, 8, 'Tuyul', 'DIJAMIN balik modal dalam 1 hari', 'assets/uploads/0dbe8a1f-7416-4c42-9ac4-f0d89f5bb2a3.jpg', 10000, 4990, 0),
(27, 10, 'Pisang Goreng', 'Pisgor telyu', 'assets/uploads/371eaef9-016b-4fb4-8b80-dfddac9d2523.jpeg', 15000, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `buyer_id` int NOT NULL,
  `quantity` int NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `rating` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `product_id`, `buyer_id`, `quantity`, `payment_method`, `address`, `rating`) VALUES
(3, 19, 3, 5, 'COD', '123', 1),
(4, 12, 2, 1, 'E-Money', 'Mars Selatan IX no 27', 5),
(5, 20, 5, 1, 'COD', '124', -1),
(6, 20, 6, 1, 'COD', '100', -1),
(7, 20, 6, 4, 'COD', '100', -1),
(8, 11, 8, 5, 'Virtual Account', '122', -1),
(9, 19, 2, 4, 'COD', 'Mars Selatan IX no 27', 5),
(10, 11, 3, 5, 'COD', '123', 3),
(11, 11, 3, 10, 'COD', '123', 5),
(12, 26, 3, 10, 'E-Money', '123', 5),
(13, 22, 3, 10, 'Transfer', '123', 4),
(14, 10, 3, 10, 'Virtual Account', '123', 5),
(15, 22, 10, 10, 'E-Money', 'bebas', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` longtext NOT NULL,
  `phone_number` longtext NOT NULL,
  `address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `password`, `phone_number`, `address`) VALUES
(2, 'aktsar@gmail.com', 'aktsar', '801fd3d2ab3eadcfbf7e765a6ed5bbc69a28bcfbbad9e4b362b822f69d12e56f', '08888888', 'Mars'),
(3, '123', '123', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '123', '123'),
(4, 'bruh@gmail.com', 'bruh', 'dba192dd92517b0d7eb21bca28fd6a5f2ce3e8eed45e0eb8cffc6cfd24eb5b1e', '123456', 'bruh street'),
(5, '124', '124', '6affdae3b3c1aa6aa7689e9b6a7b3225a636aa1ac0025f490cca1285ceaf1487', '124', '124'),
(6, '100', '100', 'ad57366865126e55649ecb23ae1d48887544976efea46a48eb5d85a6eeb4d306', '100', '100'),
(7, '90', '90', '69f59c273b6e669ac32a6dd5e1b2cb63333d8b004f9696447aee2d422ce63763', '90', '90'),
(8, '122', '122', '1be00341082e25c4e251ca6713e767f7131a2823b0052caf9c9b006ec512f6cb', '122', '122'),
(9, 'skiibidi@toilet.com', 'skibidi', 'e97624552d22866f0810c92bf410a97e20c6fda9f4e69c060a2a88fc5d9ecff2', '000555', 'toilet terdekat'),
(10, 'bebas@gmail.com', 'bebas', 'f23eba166ab323f5f390910cc70d7e13488aedcd323b019384131e5d5211a594', '000', 'bebas');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `buyer_id` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
