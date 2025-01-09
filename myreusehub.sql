-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 28, 2024 at 10:19 AM
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
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `seller_id`, `name`, `description`, `image_url`, `price`, `quantity`) VALUES
(7, 2, 'Sertifikat AMD', 'Lumayan buat TAK bisa dipake', 'assets/uploads/cbe7688b-418e-473c-9239-e495c05fd4fe.jpg', 2000000, 1),
(8, 3, 'Tahu goreng', 'Lebih enak dari tempe goreng sebelah', 'assets/uploads/de806ae5-9cdf-42fb-915b-74d3f2c46821.jpg', 15000, 500),
(10, 2, 'Manusia', 'Dijual orang asia, asal bandung, umur 22. kontak', 'assets/uploads/797c4e57-27a6-445b-8b51-6bf1a5bb7dd2.jpg', 1000, 120),
(11, 2, 'Lemari', 'Lemari murah, bagus untuk di kamar tidur!', 'assets/uploads/c22e0ba2-f844-4720-ad69-a0febcfc8db5.webp', 500000, 500),
(12, 3, 'New York', 'We selling new york city up in here', 'assets/uploads/10536756-37b3-4f07-be6b-2708f05799ea.webp', 1e16, 1),
(14, 3, 'Discord', 'We sell discord too! BUY BUY BUY NOW!!!!!', 'assets/uploads/b72982bf-79f5-4965-af5e-1344d765d878.png', 1028371412513, 1),
(15, 3, 'Manila', 'WHAT?!?!??!?!', 'assets/uploads/31a3298e-f3ab-4918-94cd-af40954c8fe5.webp', 1203871298312, 1),
(16, 2, 'Youtube', 'Yeah youtube fell off, we selling it', 'assets/uploads/bcb79073-0903-4c27-a471-5c16260d93f4.png', 12038971298312, 1),
(17, 3, 'Maxap', 'Maxap dijual :v', 'assets/uploads/0304ead2-8373-4cac-894b-6fa7484d793b.jpg', 10000, 1);

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
  `rating` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(2, 'my@gmail.com', 'aktsar', '801fd3d2ab3eadcfbf7e765a6ed5bbc69a28bcfbbad9e4b362b822f69d12e56f', '088888', 'Mars'),
(3, '123', '123', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '123', '123');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
