SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `gescom` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gescom`;

CREATE TABLE `categories` (
  `cat_id` int NOT NULL,
  `cat_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cat_parent_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `customers` (
  `cus_id` int NOT NULL,
  `cus_lastname` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_firstname` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_address` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_zipcode` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_city` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_countries_id` char(3) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_mail` varchar(75) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cus_phone` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cus_password` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_add_date` datetime NOT NULL,
  `cus_update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `details` (
  `det_id` int NOT NULL,
  `det_price` decimal(6,2) NOT NULL,
  `det_quantity` int DEFAULT NULL,
  `pro_id` int DEFAULT NULL,
  `ord_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `orders` (
  `ord_id` int NOT NULL,
  `ord_order_date` date NOT NULL,
  `ord_ship_date` date DEFAULT NULL,
  `ord_bill_date` date DEFAULT NULL,
  `ord_reception_date` date DEFAULT NULL,
  `ord_status` varchar(25) COLLATE utf8mb4_general_ci NOT NULL,
  `cus_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `products` (
  `pro_id` int NOT NULL,
  `pro_ref` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `pro_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `pro_desc` text COLLATE utf8mb4_general_ci NOT NULL,
  `pro_price` decimal(6,2) NOT NULL,
  `pro_stock` smallint DEFAULT NULL,
  `pro_color` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pro_picture` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pro_add_date` date NOT NULL,
  `pro_update_date` datetime NOT NULL,
  `pro_publish` tinyint NOT NULL,
  `sup_id` int DEFAULT NULL,
  `cat_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `suppliers` (
  `sup_id` int NOT NULL,
  `sup_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `sup_city` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `sup_address` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `sup_email` varchar(75) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sup_phone` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`cus_id`);

ALTER TABLE `details`
  ADD PRIMARY KEY (`det_id`),
  ADD KEY `pro_id` (`pro_id`),
  ADD KEY `ord_id` (`ord_id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`ord_id`),
  ADD KEY `cus_id` (`cus_id`);

ALTER TABLE `products`
  ADD PRIMARY KEY (`pro_id`),
  ADD UNIQUE KEY `cat_id` (`cat_id`),
  ADD KEY `sup_id` (`sup_id`);

ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`sup_id`);


ALTER TABLE `orders`
  MODIFY `ord_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `products`
  MODIFY `pro_id` int NOT NULL AUTO_INCREMENT;


ALTER TABLE `details`
  ADD CONSTRAINT `details_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `products` (`pro_id`),
  ADD CONSTRAINT `details_ibfk_2` FOREIGN KEY (`ord_id`) REFERENCES `orders` (`ord_id`);

ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`cus_id`);

ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`sup_id`) REFERENCES `suppliers` (`sup_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
