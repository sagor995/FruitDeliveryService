-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2019 at 03:42 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fruit_ds`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(100) NOT NULL,
  `admin_email` varchar(255) NOT NULL,
  `admin_pass` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_email`, `admin_pass`) VALUES
(1, 's@mail.com', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `product_id` int(11) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`product_id`, `ip_address`, `quantity`) VALUES
(4, '192.168.177.1', 3),
(6, '192.168.177.1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_ip` varchar(255) NOT NULL,
  `customer_name` text NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_pass` varchar(100) NOT NULL,
  `customer_country` text NOT NULL,
  `customer_city` text NOT NULL,
  `customer_contact` varchar(255) NOT NULL,
  `customer_address` text NOT NULL,
  `customer_gender` varchar(100) NOT NULL,
  `customer_image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_ip`, `customer_name`, `customer_email`, `customer_pass`, `customer_country`, `customer_city`, `customer_contact`, `customer_address`, `customer_gender`, `customer_image`) VALUES
(1, '192.168.177.1', 'Sagor Ahamed', 'sa@mail.com', '56789', 'Bangladesh', 'Dhaka', '	01767898765', 'Dhanmondi23', 'male', '2wr-00001-1.png'),
(2, '192.168.177.1', 'Samual', 'sam@mail.com', '12345', 'Bangladesh', 'Dhaka', '0167778812', 'Dhanmondi 18.', 'male', 'c_img.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE `faq` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `faq`
--

INSERT INTO `faq` (`id`, `question`, `answer`) VALUES
(1, 'What areas do you deliver to?', 'For our fresh fruit delivery, we cover the whole of the Country.'),
(2, 'Do I have to have a weekly delivery?', 'No, deliveries can be made on a daily, weekly, fortnightly or monthly basis or as & when required!'),
(3, 'Do you provide vegetables too?', 'Yes. We provide vegetables too.'),
(4, 'Are your fruit and vegetables organic?', 'All our fruit and vegetables for our fruit boxes are delivered fresh from the fruit market.');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_info`
--

CREATE TABLE `invoice_info` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_ip` varchar(100) NOT NULL,
  `card_num` varchar(200) NOT NULL,
  `card_name` varchar(100) NOT NULL,
  `card_address` varchar(100) NOT NULL,
  `card_mm` int(11) DEFAULT NULL,
  `card_yy` int(11) DEFAULT NULL,
  `card_cvc` int(11) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `paid_via` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `product_names` text NOT NULL,
  `product_qtys` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice_info`
--

INSERT INTO `invoice_info` (`id`, `customer_id`, `customer_ip`, `card_num`, `card_name`, `card_address`, `card_mm`, `card_yy`, `card_cvc`, `product_quantity`, `total_price`, `date`, `status`, `paid_via`, `phone`, `product_names`, `product_qtys`) VALUES
(18, 1, '::1', '0', 'Sagor Ahamed', 'Dhanmondi', 0, 0, 0, 1, 633, '2018/07/24', 'pending', 'Cash', '	01767898765', '', ''),
(19, 1, '::1', '2147483647', 'Nabil Ahamed', 'asdas', 8, 19, 123, 1, 633, '2018/07/24', 'pending', 'Card', '	01767898765', '', ''),
(20, 1, '::1', '2147483647', 'Sam', 'asdas', 12, 12, 213, 1, 1265, '2018/07/24', 'pending', 'Card', '	01767898765', '', ''),
(21, 1, '::1', '0', 'Sagor Ahamed', 'Dhanmondi', 0, 0, 0, 1, 5750, '2018/07/24', 'pending', 'Cash', '	01767898765', '', ''),
(22, 1, '::1', '2147483647', 'Sagor Ahamed', 'Hazaribag', 8, 19, 150, 1, 3795, '2018/07/24', 'pending', 'Card', '	01767898765', '', ''),
(28, 1, '192.168.177.1', '123123123', 'asdsad', 'asdasd', 11, 22, 213, 1, 230, '2019/10/15', 'pending', 'Card', '	01767898765', '3', '1'),
(29, 1, '192.168.177.1', 'Trx122131208923123', 'Sagor', 'sadasdasd', NULL, NULL, NULL, 1, 1121, '2019/10/15', 'pending', 'Cash', '	01767898765', '3,4', '2,1');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `customer_ip` varchar(255) NOT NULL,
  `customer_name` varchar(150) NOT NULL,
  `customer_email` varchar(150) NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `customer_ip`, `customer_name`, `customer_email`, `subject`, `message`) VALUES
(4, '::2', 'Sumon', 'sumon123@mail.com', 'urgent', 'Hello World1'),
(5, '192.168.177.1', 'Rahim', 'rahim@mail.com', '12345', 'Hello World');

-- --------------------------------------------------------

--
-- Table structure for table `others`
--

CREATE TABLE `others` (
  `id` int(11) NOT NULL,
  `header_image` varchar(100) NOT NULL,
  `ads_cover_image` varchar(100) NOT NULL,
  `ads_center_image` varchar(100) NOT NULL,
  `slide_image_1` varchar(100) NOT NULL,
  `slide_image_2` varchar(100) NOT NULL,
  `slide_image_3` varchar(100) NOT NULL,
  `slide_image_4` varchar(100) NOT NULL,
  `slide_image_5` varchar(100) NOT NULL,
  `slide_image_6` varchar(100) NOT NULL,
  `news_feed` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `others`
--

INSERT INTO `others` (`id`, `header_image`, `ads_cover_image`, `ads_center_image`, `slide_image_1`, `slide_image_2`, `slide_image_3`, `slide_image_4`, `slide_image_5`, `slide_image_6`, `news_feed`) VALUES
(2, 'header3.png', 'bg3.jpg', 'center_banner.jpg', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', 'img6.jpg', 'Welcome to FruitEats. Fruits you love, delivered to you. With FruitEats, get your fruit delivered to your doorstep within an hour!.');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_type` int(11) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_description` text NOT NULL,
  `product_image` text NOT NULL,
  `product_keyword` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_type`, `product_title`, `product_price`, `product_description`, `product_image`, `product_keyword`) VALUES
(1, 1, 'Green Coconut  Daab', 70, '2 pcs.', 'Green Coconut Daab.jpg', 'fruit, daab, coconut, green.'),
(3, 1, 'Gala Apple', 200, '50 gram.', 'red_apple.png', 'fruit, apple, red.'),
(4, 1, 'Red grapes', 125, '250gram.', 'red_pinapple.png', 'fruit, grapes.'),
(5, 1, 'Green Coconut  Daab', 70, '2 pcs.', 'Green Coconut Daab.jpg', 'fruit, daab, coconut, green.'),
(6, 1, 'Ashsini Mango', 150, '1Kg.', 'ashsini_mango.jpg', 'mango, fruit, Ashsini Mango.');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `date` varchar(100) NOT NULL,
  `amnt_of_total_qty` int(11) NOT NULL,
  `total_qty_sold` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE `types` (
  `type_id` int(11) NOT NULL,
  `type_title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`type_id`, `type_title`) VALUES
(1, 'Fresh Fruits'),
(2, 'Fresh Vegetables');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_info`
--
ALTER TABLE `invoice_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `others`
--
ALTER TABLE `others`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `faq`
--
ALTER TABLE `faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `invoice_info`
--
ALTER TABLE `invoice_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `others`
--
ALTER TABLE `others`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `types`
--
ALTER TABLE `types`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
