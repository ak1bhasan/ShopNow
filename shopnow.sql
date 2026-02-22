-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2025 at 10:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopnow`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 2, '2025-12-12 06:03:04', '2025-12-12 06:03:04'),
(2, 3, '2025-12-12 09:49:48', '2025-12-12 09:49:48'),
(3, 4, '2025-12-12 14:14:18', '2025-12-12 14:14:18'),
(4, 5, '2025-12-12 18:18:44', '2025-12-12 18:18:44');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `slug`, `created_at`) VALUES
(1, 'Home & Office / LED Desk Lamps', 'home-and-office-/-led-desk-lamps', '2025-12-12 06:06:47'),
(2, 'Electronics', 'electronics', '2025-12-12 09:33:22'),
(3, 'Smart Devices', 'smart-devices', '2025-12-12 09:54:30'),
(4, 'Gadgets', 'gadgets', '2025-12-12 10:13:04'),
(5, 'Accessories', 'accessories', '2025-12-12 10:14:22');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` enum('Pending','Processing','Shipped','Delivered','Cancelled') NOT NULL,
  `shipping_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_price`, `order_date`, `status`, `shipping_address`) VALUES
(1, 3, 84.98, '2025-12-12 13:51:43', 'Delivered', 'Kumarpara, Sylhet'),
(2, 2, 329.95, '2025-12-12 15:47:25', 'Delivered', 'Maya Tower, Shibganj, Sylhet Sadar'),
(3, 4, 94.98, '2025-12-14 19:24:06', 'Delivered', 'Mia Fazil Chist'),
(5, 4, 29.99, '2025-12-14 19:20:15', 'Delivered', 'Mia Fazil Chist, Sylhet Sadar'),
(6, 5, 138.98, '2025-12-14 19:23:56', 'Shipped', 'Nobab Road, Sylhet Sadara'),
(7, 5, 74.98, '2025-12-14 19:23:58', 'Pending', 'Habiganj, Sadar'),
(8, 5, 29.99, '2025-12-14 19:23:59', 'Pending', 'Sylhet Sadar'),
(9, 5, 74.99, '2025-12-14 19:24:01', 'Shipped', 'Sylhet Sadar'),
(10, 5, 49.99, '2025-12-14 19:24:02', 'Pending', 'Nobab Road, Sylhet Sadar');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price_at_purchase`) VALUES
(1, 1, 4, 1, 24.99),
(2, 1, 2, 1, 59.99),
(3, 2, 16, 1, 119.99),
(4, 2, 24, 1, 99.99),
(5, 2, 15, 2, 14.99),
(6, 2, 3, 1, 79.99),
(7, 3, 13, 1, 19.99),
(8, 3, 7, 1, 74.99),
(9, 5, 12, 1, 29.99),
(10, 6, 16, 1, 119.99),
(11, 6, 27, 1, 18.99),
(12, 7, 21, 1, 44.99),
(13, 7, 1, 1, 29.99),
(14, 8, 12, 1, 29.99),
(15, 9, 7, 1, 74.99),
(16, 10, 10, 1, 49.99);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `method` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Success','Failed') NOT NULL,
  `payment_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `method`, `amount`, `status`, `payment_date`) VALUES
(1, 1, 'Simulated', 84.98, 'Success', '2025-12-12 09:51:11'),
(2, 2, 'Simulated', 329.95, 'Success', '2025-12-12 12:43:13'),
(3, 3, 'Simulated', 94.98, 'Success', '2025-12-12 15:45:49'),
(4, 5, 'Simulated', 29.99, 'Success', '2025-12-12 16:11:57'),
(5, 6, 'Simulated', 138.98, 'Success', '2025-12-12 18:20:39'),
(6, 7, 'Simulated', 74.98, 'Success', '2025-12-12 19:05:48'),
(7, 8, 'Simulated', 29.99, 'Success', '2025-12-14 18:51:45'),
(8, 9, 'Simulated', 74.99, 'Success', '2025-12-14 18:56:40'),
(9, 10, 'Simulated', 49.99, 'Success', '2025-12-14 19:18:48');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `name`, `image_url`, `description`, `price`, `stock`, `created_at`) VALUES
(1, 1, 'Minimalist LED desk lamps', 'https://images.pexels.com/photos/11784437/pexels-photo-11784437.jpeg', 'luminate your workspace with style and precision using our Adjustable LED Desk Lamp with Touch Control. Designed for modern homes, students, and professionals, this sleek lamp combines functionality with elegant design.\r\n\r\nWhether you’re studying, working late, or reading your favorite book, this LED lamp gives you the perfect lighting every time. Its smooth touch controls and customizable brightness levels ensure you always work comfortably without straining your eyes.', 29.99, 19, '2025-12-12 06:06:47'),
(2, 2, 'Wireless Bluetooth Headphones', 'https://images.pexels.com/photos/11199906/pexels-photo-11199906.jpeg', 'Enjoy a seamless audio experience with these wireless Bluetooth headphones designed for everyday use. Ideal for listening to music, taking calls, or watching videos, they offer comfort and dependable performance. Their modern design suits home, office, or travel environments, making them a practical choice for users who value convenience and wireless connectivity.', 59.99, 31, '2025-12-12 09:33:22'),
(3, 2, 'Smart Fitness Watch', 'https://images.pexels.com/photos/5081922/pexels-photo-5081922.jpeg', 'Stay connected to your daily routine with this smart fitness watch designed to support an active lifestyle. It helps users monitor activities and maintain awareness throughout the day. Suitable for casual users and fitness enthusiasts, it combines practical functionality with a clean design for comfortable all-day wear.', 79.99, 0, '2025-12-12 09:34:46'),
(4, 2, 'Portable Power Bank', 'https://images.pexels.com/photos/10104320/pexels-photo-10104320.jpeg', 'Keep your devices charged wherever you go with this portable power bank designed for daily convenience. Ideal for travel, work, or emergencies, it offers dependable charging when outlets are unavailable. Its compact design allows easy storage while supporting uninterrupted device usage throughout the day.', 24.99, 49, '2025-12-12 09:44:01'),
(6, 3, 'Smart Watch Series X', 'https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg', 'Stylish smartwatch with fitness tracking, heart rate monitoring, step counter, sleep analysis, and real-time notifications. Compatible with Android and iOS devices.', 89.99, 17, '2025-12-12 09:56:24'),
(7, 2, 'Mechanical Gaming Keyboard', 'https://images.pexels.com/photos/24181863/pexels-photo-24181863.jpeg', 'RGB backlit mechanical keyboard with durable tactile switches, anti-ghosting keys, and customizable lighting modes. Designed for gaming and professional typing.', 74.99, 19, '2025-12-12 10:11:44'),
(8, 4, 'Portable Bluetooth Speaker', 'https://images.pexels.com/photos/13658010/pexels-photo-13658010.jpeg', 'Compact and lightweight Bluetooth speaker delivering powerful sound and deep bass. Water-resistant design makes it perfect for outdoor and indoor use.', 39.99, 0, '2025-12-12 10:13:04'),
(9, 5, 'USB-C Fast Charging Hub', 'https://images.pexels.com/photos/7742589/pexels-photo-7742589.jpeg', 'Multi-port USB-C hub supporting fast charging, data transfer, HDMI output, and device connectivity. Ideal for laptops, tablets, and smartphones.', 29.99, 30, '2025-12-12 10:14:22'),
(10, 4, 'Noise Cancelling Earbuds', 'https://images.pexels.com/photos/6889216/pexels-photo-6889216.jpeg', 'True wireless earbuds with active noise cancellation, clear sound quality, touch controls, and portable charging case for extended usage.', 49.99, 25, '2025-12-12 10:18:22'),
(11, 3, 'Smart Home Security Camera', 'https://images.pexels.com/photos/29292011/pexels-photo-29292011.jpeg', 'Indoor smart security camera with HD video recording, night vision, motion detection, and mobile app support for real-time monitoring.', 64.99, 0, '2025-12-12 10:19:23'),
(12, 2, 'Adjustable LED Desk Lamp', 'https://images.pexels.com/photos/6368846/pexels-photo-6368846.jpeg', 'Modern LED desk lamp with adjustable brightness levels, touch controls, and energy-efficient lighting for study or workspace environments.', 29.99, 9, '2025-12-12 10:20:39'),
(13, 5, 'Smartphone Tripod Stand', 'https://images.pexels.com/photos/14541008/pexels-photo-14541008.jpeg', 'Flexible smartphone tripod stand with adjustable legs and secure grip. Ideal for photography, video recording, live streaming, and video calls.', 19.99, 14, '2025-12-12 10:23:08'),
(14, 5, 'Wireless Charging Pad', 'https://images.pexels.com/photos/7742585/pexels-photo-7742585.jpeg', 'Fast Wireless Charging Pad is a sleek and reliable charging solution designed for everyday use. It delivers efficient, high-speed wireless power to all Qi-enabled smartphones, eliminating the need for cables. The slim, non-slip design ensures stable placement on desks or nightstands, while built-in safety features protect against overheating and overcharging. Perfect for home or office, it combines convenience, performance, and modern style in one compact device.', 22.99, 7, '2025-12-12 11:08:45'),
(15, 3, 'Smart LED Light Bulb', 'https://images.pexels.com/photos/21284445/pexels-photo-21284445.jpeg', 'Smart LED Light Bulb transforms your space with convenient app-based control and customizable lighting. Easily adjust brightness, switch between multiple color modes, or set the perfect ambiance for any occasion using your smartphone. Designed for energy efficiency and long-lasting performance, it fits standard sockets and integrates seamlessly into modern smart homes, offering comfort, style, and control at your fingertips', 14.99, 12, '2025-12-12 11:10:25'),
(16, 2, 'Action Camera 4K', 'https://images.pexels.com/photos/4005568/pexels-photo-4005568.jpeg', 'Action Camera 4K is built to capture every adventure in stunning ultra-high definition. Featuring crisp 4K video recording, a wide-angle lens for immersive shots, and a durable waterproof casing, it’s perfect for outdoor sports and travel. Its compact, rugged design ensures reliable performance in extreme conditions, delivering sharp, vibrant footage wherever your journey takes you.', 119.99, 3, '2025-12-12 11:12:58'),
(17, 3, 'Smart Voice Assistant Speaker', 'https://images.pexels.com/photos/13696664/pexels-photo-13696664.jpeg', 'Smart Voice Assistant Speaker brings hands-free convenience and rich sound to your home. Equipped with a built-in voice assistant, it lets you play music, control smart devices, check information, and manage daily tasks using simple voice commands. The high-quality audio delivers clear vocals and balanced bass, making it ideal for entertainment, productivity, and seamless smart home integration.', 54.99, 13, '2025-12-12 11:14:23'),
(18, 5, 'Wireless Presentation Clicker', 'https://images.pexels.com/photos/16811946/pexels-photo-16811946.jpeg', 'Wireless Presentation Clicker is a reliable and easy-to-use remote designed for smooth, professional presentations. It features an integrated laser pointer for highlighting key points and a plug-and-play USB receiver for quick setup. With responsive buttons and a comfortable grip, it allows effortless slide navigation, helping you present confidently in meetings, classrooms, or conferences.', 18.99, 19, '2025-12-12 11:16:53'),
(19, 2, 'External SSD Drive 1TB', 'https://images.pexels.com/photos/4633278/pexels-photo-4633278.jpeg', 'External SSD Drive 1TB offers fast, reliable storage for work and travel. With high-speed data transfer and USB-C connectivity, it ensures quick access to large files, backups, and media. The compact, shock-resistant design provides durability and portability, making it ideal for professionals, creatives, and anyone needing secure, high-performance external storage on the go.', 129.99, 0, '2025-12-12 11:18:16'),
(20, 3, 'Smart Door Sensor', 'https://images.pexels.com/photos/20901468/pexels-photo-20901468.jpeg', 'Smart Door Sensor enhances home security by monitoring doors and windows in real time. It sends instant alerts and app notifications whenever an entry point is opened or closed, helping you stay informed from anywhere. Easy to install and energy efficient, it integrates seamlessly with smart home systems to provide added safety, convenience, and peace of mind.', 19.99, 13, '2025-12-12 11:19:31'),
(21, 2, 'Noise Reduction Desk Microphone', 'https://images.pexels.com/photos/4476138/pexels-photo-4476138.jpeg', 'Noise Reduction Desk Microphone delivers clear, professional-quality audio for meetings, streaming, and online communication. Featuring advanced noise reduction technology, it minimizes background sounds to keep your voice crisp and focused. The plug-and-play USB connection ensures easy setup, while the stable desk stand and sleek design make it ideal for home offices, gaming setups, and content creation.', 44.99, 24, '2025-12-12 11:21:38'),
(22, 5, 'Foldable Laptop Stand', 'https://images.pexels.com/photos/968631/pexels-photo-968631.jpeg', 'Foldable Laptop Stand is a lightweight and durable aluminum stand designed to improve comfort and productivity. Its ergonomic design elevates your laptop to promote better posture, reduce neck strain, and enhance airflow for efficient cooling. Fully foldable and portable, it’s easy to carry and ideal for home, office, or travel use.', 21.99, 0, '2025-12-12 11:23:10'),
(23, 5, 'Wireless Keyboard & Mouse Combo', 'https://images.pexels.com/photos/13325939/pexels-photo-13325939.jpeg', 'Wireless Keyboard & Mouse Combo is designed to enhance productivity with a comfortable, clutter-free workspace. Featuring reliable wireless connectivity, it ensures smooth, responsive performance for everyday tasks. The ergonomic keyboard offers quiet, efficient typing, while the precision mouse provides accurate control. Easy to set up and energy efficient, it’s ideal for home, office, or remote work environments.', 34.99, 25, '2025-12-12 12:23:03'),
(24, 2, 'VR Headset', 'https://images.pexels.com/photos/3405456/pexels-photo-3405456.jpeg', 'VR Headset delivers an immersive virtual reality experience that brings games, videos, and simulations to life. Designed for comfort and clarity, it offers a wide field of view and smooth visuals for realistic interaction. Easy to set up and compatible with a range of devices, it’s perfect for entertainment, learning, and exploring virtual worlds from home.', 99.99, 34, '2025-12-12 12:26:01'),
(25, 3, 'Smart Digital Alarm Clock', 'https://images.pexels.com/photos/9582658/pexels-photo-9582658.jpeg', 'Smart Digital Alarm Clock combines modern design with everyday functionality. Featuring a clear LED display, it shows time at a glance in any lighting condition. Built-in USB charging ports let you conveniently power your devices overnight. Compact and easy to use, it’s ideal for bedrooms, offices, or bedside tables, keeping you organized and charged.', 23.99, 35, '2025-12-12 12:28:49'),
(26, 4, 'Wireless Car Charger Mount', 'https://images.pexels.com/photos/5391509/pexels-photo-5391509.jpeg', 'Wireless Car Charger Mount offers fast and convenient charging while you drive. Featuring an intelligent auto-clamp design, it securely holds your smartphone in place as soon as it’s mounted. The wireless charging function eliminates cable clutter, while the adjustable mount ensures optimal viewing angles, making it a safe and practical accessory for everyday driving.', 31.99, 9, '2025-12-12 13:41:02'),
(27, 3, 'Smart Temperature Sensor', 'https://images.pexels.com/photos/32079708/pexels-photo-32079708.jpeg', 'Smart Temperature Sensor provides accurate monitoring of both temperature and humidity to help maintain a comfortable indoor environment. It delivers real-time data and app-based alerts, allowing you to track changes remotely and respond quickly. Compact and energy efficient, it integrates seamlessly with smart home systems, making it ideal for homes, offices, and storage areas.', 18.99, 24, '2025-12-12 13:43:36'),
(28, 5, 'USB Desk Fan', 'https://images.pexels.com/photos/5850342/pexels-photo-5850342.jpeg', 'USB Desk Fan is a compact and efficient cooling solution for work or home. Powered via USB, it easily connects to laptops, power banks, or adapters for flexible use. Designed with quiet operation, it delivers steady airflow without disturbing your focus. Lightweight and portable, it’s perfect for desks, study areas, and small personal spaces.', 15.99, 25, '2025-12-12 13:46:37'),
(29, 4, 'Bluetooth Car Audio Receiver', 'https://images.pexels.com/photos/11845200/pexels-photo-11845200.jpeg', 'Bluetooth Car Audio Receiver lets you stream music and take hands-free calls through your car’s audio system. Easily connect your smartphone via Bluetooth to enjoy wireless audio playback with clear sound quality. Compact and simple to install, it upgrades older car stereos, providing safer driving, convenient control, and a modern wireless listening experience on the road.', 26.99, 15, '2025-12-12 15:31:37'),
(30, 5, 'Earphone', 'https://images.pexels.com/photos/748599/pexels-photo-748599.jpeg', 'Experience clear, balanced sound with these modern wireless earphones designed for everyday use. They deliver rich audio, stable connectivity, and a comfortable in-ear fit for long listening sessions. Ideal for music, calls, workouts, and travel, the lightweight design ensures all-day comfort while the long-lasting battery keeps you connected wherever you go.', 30.99, 23, '2025-12-14 18:58:41');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `is_main` tinyint(1) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('user','admin') NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password_hash`, `phone`, `role`, `created_at`) VALUES
(1, 'admin123@gmail.com', 'admin@example.com', 'scrypt:32768:8:1$bOMPMd3Uq5b1aAEu$bf10ba8f88dc428217b9b95852855c5346f43c6f457a003b0e3778a7457d63b29dc2a8a05e8b90c3ac252e1e07203e23b47221b8012580aee825a4a1237093ff', NULL, 'admin', '2025-12-12 06:02:15'),
(2, 'Navid Zaman', 'navidzaman@gmail.com', 'scrypt:32768:8:1$oJQD13F9QWYzlHcy$c15147423688b4cb69ad65d78debbfae6912d047452105aeac08a10211011228df248fbfa209834bf5e6e3af0f0a13d423948ffd89c022bfc8a2dadd89d343d0', '0171', 'user', '2025-12-12 06:03:04'),
(3, 'Sadman Khan', 'shadmankhan123@gmail.com', 'scrypt:32768:8:1$8a6F5IX6TOj5I3qh$d524ebd551d0ddd4d3186133c6a1e3becffd358cee1896a9a85c8780edfd2d26b47d3b66706443ace04b44376cb06ace4ce9b096387ca15c4120637b293e8dd0', '0172', 'user', '2025-12-12 09:49:48'),
(4, 'Jibran Masum', 'jibranmasum@gmail.com', 'scrypt:32768:8:1$6OivxN8YcRVcIc3z$1d064b91f137dccc4c9d620fe29d83bfcaa1f65848899ec84bd43bb61e0f518058f500e3dd64768b9c4318fa1189ea927bd4080b9f4d344ab339b746c854e886', '0151', 'user', '2025-12-12 14:14:18'),
(5, 'Akib Hasan', 'akibhasan011@gmail.com', 'scrypt:32768:8:1$22cavYxKV4CrBSxy$4a0be0741b1df76d08c52ec965ee76a28e3fd6b98ceb2eb896dc76446e35e3f2e3c8a7abe334c0253fcb4a430b5e393af547184b9e36e5254264077c5b187f9f', '01701391505', 'user', '2025-12-12 18:18:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ix_categories_slug` (`slug`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `ix_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`),
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
