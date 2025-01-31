-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 31, 2025 at 09:45 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel app`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotels table`
--

DROP TABLE IF EXISTS `hotels table`;
CREATE TABLE IF NOT EXISTS `hotels table` (
  `HotelID` int(11) NOT NULL,
  `Hotel_name` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Address` text NOT NULL,
  `Star_rate` int(11) NOT NULL,
  `Description` text NOT NULL,
  `Amenities` json NOT NULL,
  `ImageURLs` text NOT NULL,
  PRIMARY KEY (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rooms table`
--

DROP TABLE IF EXISTS `rooms table`;
CREATE TABLE IF NOT EXISTS `rooms table` (
  `RoomID` int(11) NOT NULL,
  `HotelID` int(11) NOT NULL,
  `Room_type` enum('Single','Double','Suite') NOT NULL,
  `Occupancy_adults` int(11) NOT NULL,
  `Occupancy_children` int(11) NOT NULL,
  `Price_per_night` decimal(10,2) NOT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Amenities` json NOT NULL,
  `Bed_type` enum('King','Queen','Twin') NOT NULL,
  PRIMARY KEY (`RoomID`),
  UNIQUE KEY `Foreign Key` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rooms table`
--
ALTER TABLE `rooms table`
  ADD CONSTRAINT `rooms table_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
