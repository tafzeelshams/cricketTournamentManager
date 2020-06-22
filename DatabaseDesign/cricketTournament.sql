-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 29, 2019 at 12:16 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cricketTournament`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblBatting`
--

CREATE TABLE `tblBatting` (
  `BatsmanName` varchar(30) NOT NULL,
  `Runs` int(11) NOT NULL DEFAULT 0,
  `Balls` int(11) NOT NULL DEFAULT 0,
  `4s` int(11) NOT NULL DEFAULT 0,
  `6s` int(11) NOT NULL DEFAULT 0,
  `50s` int(11) NOT NULL DEFAULT 0,
  `100s` int(11) NOT NULL DEFAULT 0,
  `Outs` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblBestBowling`
--

CREATE TABLE `tblBestBowling` (
  `BowlerID` varchar(30) NOT NULL,
  `Wickets` int(11) NOT NULL,
  `Runs` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblBowling`
--

CREATE TABLE `tblBowling` (
  `BowerName` varchar(30) NOT NULL,
  `Balls` int(11) NOT NULL DEFAULT 0,
  `Runs` int(11) NOT NULL DEFAULT 0,
  `Maidens` int(11) NOT NULL DEFAULT 0,
  `Wickets` int(11) NOT NULL DEFAULT 0,
  `5W` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblHighestScore`
--

CREATE TABLE `tblHighestScore` (
  `BatsmanID` varchar(30) NOT NULL,
  `Highest` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblMatches`
--

CREATE TABLE `tblMatches` (
  `MatchID` int(11) NOT NULL,
  `Team1` varchar(5) NOT NULL,
  `Team2` varchar(5) NOT NULL,
  `Overs` int(11) NOT NULL DEFAULT 20,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Status` enum('UpComing','OnGoing','Completed') NOT NULL DEFAULT 'UpComing'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblPlayer`
--

CREATE TABLE `tblPlayer` (
  `PlayerName` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `Team` varchar(5) NOT NULL,
  `BattingStyle` enum('Right Hand Bat','Left Hand Bat') NOT NULL,
  `BowlingStyle` enum('Right Hand Bowl','Left Hand Bowl') NOT NULL,
  `Matches` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------

--
-- Table structure for table `tblResults`
--

CREATE TABLE `tblResults` (
  `MatchID` int(11) NOT NULL,
  `Team1` varchar(5) NOT NULL,
  `Team2` varchar(5) NOT NULL,
  `Inning1Score` varchar(10) NOT NULL,
  `Inning1Overs` varchar(5) NOT NULL,
  `Inning2Score` varchar(10) NOT NULL,
  `Inning2Overs` varchar(5) NOT NULL,
  `Winner` varchar(5) NOT NULL,
  `Summary` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tblTeams`
--

CREATE TABLE `tblTeams` (
  `DisplayName` varchar(5) NOT NULL,
  `TeamName` varchar(30) NOT NULL,
  `Captain` varchar(30) DEFAULT NULL,
  `WicketKeeper` varchar(30) DEFAULT NULL,
  `Played` int(11) NOT NULL DEFAULT 0,
  `Won` int(11) NOT NULL DEFAULT 0,
  `Lost` int(11) NOT NULL DEFAULT 0,
  `NoResult` int(11) NOT NULL DEFAULT 0,
  `Points` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblBatting`
--
ALTER TABLE `tblBatting`
  ADD PRIMARY KEY (`BatsmanName`) USING BTREE;

--
-- Indexes for table `tblBestBowling`
--
ALTER TABLE `tblBestBowling`
  ADD PRIMARY KEY (`BowlerID`,`Wickets`,`Runs`);

--
-- Indexes for table `tblBowling`
--
ALTER TABLE `tblBowling`
  ADD PRIMARY KEY (`BowerName`) USING BTREE;

--
-- Indexes for table `tblHighestScore`
--
ALTER TABLE `tblHighestScore`
  ADD PRIMARY KEY (`BatsmanID`,`Highest`) USING BTREE;

--
-- Indexes for table `tblMatches`
--
ALTER TABLE `tblMatches`
  ADD PRIMARY KEY (`MatchID`),
  ADD KEY `Team1` (`Team1`),
  ADD KEY `Team2` (`Team2`);

--
-- Indexes for table `tblPlayer`
--
ALTER TABLE `tblPlayer`
  ADD PRIMARY KEY (`PlayerName`),
  ADD KEY `Team` (`Team`);

--
-- Indexes for table `tblResults`
--
ALTER TABLE `tblResults`
  ADD PRIMARY KEY (`MatchID`),
  ADD KEY `tblResults_ibfk_1` (`Team1`),
  ADD KEY `tblResults_ibfk_2` (`Team2`),
  ADD KEY `tblResults_ibfk_3` (`Winner`);

--
-- Indexes for table `tblTeams`
--
ALTER TABLE `tblTeams`
  ADD PRIMARY KEY (`DisplayName`),
  ADD KEY `Captain` (`Captain`),
  ADD KEY `WicketKeeper` (`WicketKeeper`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblMatches`
--
ALTER TABLE `tblMatches`
  MODIFY `MatchID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblBatting`
--
ALTER TABLE `tblBatting`
  ADD CONSTRAINT `tblBatting_ibfk_1` FOREIGN KEY (`BatsmanName`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblBestBowling`
--
ALTER TABLE `tblBestBowling`
  ADD CONSTRAINT `tblBestBowling_ibfk_1` FOREIGN KEY (`BowlerID`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblBowling`
--
ALTER TABLE `tblBowling`
  ADD CONSTRAINT `tblBowling_ibfk_1` FOREIGN KEY (`BowerName`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblHighestScore`
--
ALTER TABLE `tblHighestScore`
  ADD CONSTRAINT `tblHighestScore_ibfk_1` FOREIGN KEY (`BatsmanID`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblMatches`
--
ALTER TABLE `tblMatches`
  ADD CONSTRAINT `tblMatches_ibfk_1` FOREIGN KEY (`Team1`) REFERENCES `tblTeams` (`DisplayName`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblMatches_ibfk_2` FOREIGN KEY (`Team2`) REFERENCES `tblTeams` (`DisplayName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblPlayer`
--
ALTER TABLE `tblPlayer`
  ADD CONSTRAINT `tblPlayer_ibfk_1` FOREIGN KEY (`Team`) REFERENCES `tblTeams` (`DisplayName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblResults`
--
ALTER TABLE `tblResults`
  ADD CONSTRAINT `tblResults_ibfk_1` FOREIGN KEY (`Team1`) REFERENCES `tblTeams` (`DisplayName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tblResults_ibfk_2` FOREIGN KEY (`Team2`) REFERENCES `tblTeams` (`DisplayName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tblResults_ibfk_3` FOREIGN KEY (`Winner`) REFERENCES `tblTeams` (`DisplayName`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tblResults_ibfk_4` FOREIGN KEY (`MatchID`) REFERENCES `tblMatches` (`MatchID`);

--
-- Constraints for table `tblTeams`
--
ALTER TABLE `tblTeams`
  ADD CONSTRAINT `tblTeams_ibfk_1` FOREIGN KEY (`Captain`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tblTeams_ibfk_2` FOREIGN KEY (`WicketKeeper`) REFERENCES `tblPlayer` (`PlayerName`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
