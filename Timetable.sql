/*
SQLyog Enterprise - MySQL GUI v6.56
MySQL - 5.5.5-10.1.13-MariaDB : Database - time_table
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`time_table` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `time_table`;

/*Table structure for table `all_teachers` */

DROP TABLE IF EXISTS `all_teachers`;

CREATE TABLE `all_teachers` (
  `sn` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `experience` int(10) NOT NULL,
  `year` int(10) NOT NULL,
  `semester` int(10) NOT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `all_teachers` */

-- insert  into `all_teachers`(`sn`,`name`,`email`,`subject`,`experience`,`year`,`semester`) values (1,'facultythree','facultythree@gmail.com','Chemistry',0,1,1),(2,'facultytewelve','facultytewelve@gmail.com','Data Science',0,1,1),(3,'facultyeleven','facultyeleven@gmail.com','Machines',0,1,1),(4,'facultynine','facultynine@gmail.com','English',0,1,2),(5,'facultyseven','facultyseven@gmail.com','Natural Science',0,1,2),(6,'facultyeleven','facultyeleven@gmail.com','Robotics',0,1,2),(7,'facultytwo','facultytwo@gmail.com','Science',0,1,2),(8,'facultytewelve','facultytewelve@gmail.com','ML',0,2,1),(9,'facultyone','facultyone@gmail.com','Maths',0,2,1),(10,'facultyseven','facultyseven@gmail.com','physics',0,2,1),(11,'facultyten','facultyten@gmail.com','Zoology',0,3,2);

/*Table structure for table `all_teachers_labs` */

DROP TABLE IF EXISTS `all_teachers_labs`;

CREATE TABLE `all_teachers_labs` (
  `sn` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `experience` int(10) NOT NULL,
  `year` int(10) NOT NULL,
  `semester` int(10) NOT NULL,
  `lab` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `all_teachers_labs` */

-- insert  into `all_teachers_labs`(`sn`,`name`,`email`,`experience`,`year`,`semester`,`lab`) values (1,'facultyfive','facultyfive@gmail.com',0,1,1,'Chemistry'),(2,'facultytewelve','facultytewelve@gmail.com',0,1,1,'Data Science'),(3,'facultythree','facultythree@gmail.com',0,1,1,'Science'),(4,'facultynine','facultynine@gmail.com',0,1,2,'English'),(5,'facultytewelve','facultytewelve@gmail.com',0,1,2,'ML'),(6,'facultyten','facultyten@gmail.com',0,2,2,'Zoology'),(7,'facultyeight','facultyeight@gmail.com',0,3,1,'Natural Science'),(8,'facultyseven','facultyseven@gmail.com',0,3,2,'physics'),(9,'facultyone','facultyone@gmail.com',0,4,1,'Maths');

/*Table structure for table `class_lab` */

DROP TABLE IF EXISTS `class_lab`;

CREATE TABLE `class_lab` (
  `SN` int(10) NOT NULL AUTO_INCREMENT,
  `Year` int(10) NOT NULL,
  `Semester` int(10) NOT NULL,
  `Lab` varchar(100) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `class_lab` */

-- insert  into `class_lab`(`SN`,`Year`,`Semester`,`Lab`) values (1,1,1,'Data Science'),(2,1,1,'Chemistry'),(3,1,2,'English'),(4,1,2,'ML'),(5,2,1,'Chemistry'),(6,2,1,'biology'),(7,2,2,'ML'),(8,2,2,'Zoology'),(9,3,1,'Natural Science'),(10,3,1,'Zoology'),(11,3,2,'physics'),(12,3,2,'Chemistry'),(13,4,1,'Maths'),(14,4,1,'ML'),(15,4,2,'Data Science'),(16,4,2,'Science');

/*Table structure for table `class_subz` */

DROP TABLE IF EXISTS `class_subz`;

CREATE TABLE `class_subz` (
  `SN` int(10) NOT NULL AUTO_INCREMENT,
  `Year` int(10) NOT NULL,
  `Semester` int(10) NOT NULL,
  `Subject` varchar(100) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Data for the table `class_subz` */

-- insert  into `class_subz`(`SN`,`Year`,`Semester`,`Subject`) values (1,1,1,'Chemistry'),(2,1,1,'Data Science'),(3,1,1,'Machines'),(4,1,1,'biology'),(5,1,2,'English'),(6,1,2,'Natural Science'),(7,1,2,'Science'),(8,1,2,'Robotics'),(9,2,1,'Science'),(10,2,1,'Maths'),(11,2,1,'ML'),(12,2,1,'physics'),(13,2,2,'Robotics'),(14,2,2,'biology'),(15,2,2,'Science'),(16,2,2,'Machines'),(17,3,1,'Chemistry'),(18,3,1,'Data Science'),(19,3,1,'English'),(20,3,1,'Maths'),(21,3,2,'physics'),(22,3,2,'biology'),(23,3,2,'Zoology'),(24,3,2,'Robotics'),(25,4,1,'Natural Science'),(26,4,1,'physics'),(27,4,1,'Maths'),(28,4,1,'biology'),(29,4,2,'Data Science'),(30,4,2,'biology'),(31,4,2,'Robotics'),(32,4,2,'Natural Science');

/*Table structure for table `register` */

DROP TABLE IF EXISTS `register`;

CREATE TABLE `register` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `subject1` varchar(100) NOT NULL DEFAULT 'pending',
  `subject2` varchar(100) NOT NULL DEFAULT 'pending',
  `subject3` varchar(100) NOT NULL DEFAULT 'pending',
  `experience` int(10) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `register` */

-- insert  into `register`(`name`,`email`,`password`,`subject1`,`subject2`,`subject3`,`experience`) values ('facultyeight','facultyeight@gmail.com','1234','Natural Science','pending','pending',4),('facultyeleven','facultyeleven@gmail.com','1234','Robotics','Machines','pending',10),('facultyfive','facultyfive@gmail.com','1234','Chemistry','pending','pending',8),('facultyfour','facultyfour@gmail.com','1234','Chemistry','pending','biology',8),('facultynine','facultynine@gmail.com','1234','English','pending','pending',6),('facultyone','facultyone@gmail.com','1234','Maths','pending','pending',4),('facultyseven','facultyseven@gmail.com','1234','Natural Science','physics','pending',6),('facultysix','facultysix@gmail.com','1234','Natural Science','pending','pending',6),('facultyten','facultyten@gmail.com','1234','Zoology','pending','pending',6),('facultytewelve','facultytewelve@gmail.com','1234','Data Science','ML','pending',12),('facultythree','facultythree@gmail.com','1234','Chemistry','physics','biology',12),('facultytwo','facultytwo@gmail.com','1234','Science','pending','pending',5);

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `Slno` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `year` varchar(200) DEFAULT NULL,
  `sem` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `contact` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Slno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `students` */

/*Table structure for table `time_table` */

DROP TABLE IF EXISTS `time_table`;

CREATE TABLE `time_table` (
  `sn` int(10) NOT NULL AUTO_INCREMENT,
  `day` varchar(100) NOT NULL,
  `period` int(10) NOT NULL,
  `faculty` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `year` int(10) NOT NULL,
  `semester` int(10) NOT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=latin1;

/*Data for the table `time_table` */

-- insert  into `time_table`(`sn`,`day`,`period`,`faculty`,`subject`,`year`,`semester`) values (1,'Monday',2,'facultyeleven','Machines',1,1),(2,'Monday',7,'facultytewelve','Data Science',1,1),(3,'Monday',3,'facultythree','Chemistry',1,1),(4,'Monday',6,'facultytewelve','Data Science',1,1),(5,'Monday',1,'facultyeleven','Machines',1,1),(6,'Monday',4,'facultythree','Chemistry',1,1),(7,'Monday',5,'facultytewelve','Data Science',1,1),(8,'Monday',5,'facultyeleven','Robotics',1,2),(9,'Monday',3,'facultynine','English',1,2),(10,'Monday',2,'facultyseven','Natural Science',1,2),(11,'Monday',1,'facultytwo','Science',1,2),(12,'Monday',6,'facultyseven','Natural Science',1,2),(13,'Monday',4,'facultynine','English',1,2),(14,'Monday',7,'facultyeleven','Robotics',1,2),(15,'Monday',4,'facultyseven','physics',2,1),(16,'Monday',7,'facultyone','Maths',2,1),(17,'Monday',2,'facultytewelve','ML',2,1),(18,'Monday',6,'facultyone','Maths',2,1),(19,'Monday',1,'facultyseven','physics',2,1),(20,'Monday',3,'facultytewelve','ML',2,1),(21,'Monday',5,'Gap period','Gap period',2,1),(22,'Monday',4,'facultyten','Zoology',3,2),(23,'Monday',2,'facultyten','Zoology',3,2),(24,'Monday',5,'facultyten','Zoology',3,2),(25,'Monday',3,'facultyten','Zoology',3,2),(26,'Monday',6,'facultyten','Zoology',3,2),(27,'Monday',7,'facultyten','Zoology',3,2),(28,'Monday',1,'facultyten','Zoology',3,2),(29,'Tuesday',1,'facultyeleven','Machines',1,1),(30,'Tuesday',7,'facultytewelve','Data Science',1,1),(31,'Tuesday',4,'facultythree','Chemistry',1,1),(32,'Tuesday',2,'facultyeleven','Machines',1,1),(33,'Tuesday',5,'facultytewelve','Data Science',1,1),(34,'Tuesday',6,'facultythree','Chemistry',1,1),(35,'Tuesday',3,'facultyeleven','Machines',1,1),(36,'Tuesday',4,'facultyeleven','Robotics',1,2),(37,'Tuesday',6,'facultynine','English',1,2),(38,'Tuesday',7,'facultyseven','Natural Science',1,2),(39,'Tuesday',3,'facultytwo','Science',1,2),(40,'Tuesday',5,'facultyeleven','Robotics',1,2),(41,'Tuesday',1,'facultyseven','Natural Science',1,2),(42,'Tuesday',2,'facultytwo','Science',1,2),(43,'Tuesday',2,'facultyseven','physics',2,1),(44,'Tuesday',6,'facultytewelve','ML',2,1),(45,'Tuesday',5,'facultyone','Maths',2,1),(46,'Tuesday',4,'facultyone','Maths',2,1),(47,'Tuesday',1,'facultytewelve','ML',2,1),(48,'Tuesday',3,'facultyseven','physics',2,1),(49,'Tuesday',7,'Gap period','Gap period',2,1),(50,'Tuesday',7,'facultyten','Zoology',3,2),(51,'Tuesday',4,'facultyten','Zoology',3,2),(52,'Tuesday',2,'facultyten','Zoology',3,2),(53,'Tuesday',5,'facultyten','Zoology',3,2),(54,'Tuesday',3,'facultyten','Zoology',3,2),(55,'Tuesday',6,'facultyten','Zoology',3,2),(56,'Tuesday',1,'facultyten','Zoology',3,2),(57,'Wednesday',7,'facultytewelve','Data Science',1,1),(58,'Wednesday',1,'facultyeleven','Machines',1,1),(59,'Wednesday',6,'facultythree','Chemistry',1,1),(60,'Wednesday',5,'facultytewelve','Data Science',1,1),(61,'Wednesday',2,'facultythree','Chemistry',1,1),(62,'Wednesday',4,'facultyeleven','Machines',1,1),(63,'Wednesday',3,'facultytewelve','Data Science',1,1),(64,'Wednesday',7,'facultyseven','Natural Science',1,2),(65,'Wednesday',3,'facultyeleven','Robotics',1,2),(66,'Wednesday',1,'facultytwo','Science',1,2),(67,'Wednesday',4,'facultynine','English',1,2),(68,'Wednesday',2,'facultyeleven','Robotics',1,2),(69,'Wednesday',6,'facultytwo','Science',1,2),(70,'Wednesday',5,'facultyseven','Natural Science',1,2),(71,'Wednesday',6,'facultytewelve','ML',2,1),(72,'Wednesday',3,'facultyseven','physics',2,1),(73,'Wednesday',1,'facultyone','Maths',2,1),(74,'Wednesday',4,'facultyone','Maths',2,1),(75,'Wednesday',2,'facultytewelve','ML',2,1),(76,'Wednesday',5,'Gap period','Gap period',2,1),(77,'Wednesday',7,'Gap period','Gap period',2,1),(78,'Wednesday',1,'facultyten','Zoology',3,2),(79,'Wednesday',5,'facultyten','Zoology',3,2),(80,'Wednesday',2,'facultyten','Zoology',3,2),(81,'Wednesday',7,'facultyten','Zoology',3,2),(82,'Wednesday',4,'facultyten','Zoology',3,2),(83,'Wednesday',6,'facultyten','Zoology',3,2),(84,'Wednesday',3,'facultyten','Zoology',3,2),(85,'Thursday',6,'facultythree','Chemistry',1,1),(86,'Thursday',4,'facultytewelve','Data Science',1,1),(87,'Thursday',2,'facultyeleven','Machines',1,1),(88,'Thursday',1,'facultyeleven','Machines',1,1),(89,'Thursday',5,'facultythree','Chemistry',1,1),(90,'Thursday',7,'facultytewelve','Data Science',1,1),(91,'Thursday',3,'facultytewelve','Data Science',1,1),(92,'Thursday',4,'facultyseven','Natural Science',1,2),(93,'Thursday',2,'facultytwo','Science',1,2),(94,'Thursday',3,'facultynine','English',1,2),(95,'Thursday',7,'facultyeleven','Robotics',1,2),(96,'Thursday',1,'facultytwo','Science',1,2),(97,'Thursday',5,'facultynine','English',1,2),(98,'Thursday',6,'facultyeleven','Robotics',1,2),(99,'Thursday',7,'facultyseven','physics',2,1),(100,'Thursday',3,'facultyone','Maths',2,1),(101,'Thursday',6,'facultytewelve','ML',2,1),(102,'Thursday',5,'facultyseven','physics',2,1),(103,'Thursday',1,'facultyone','Maths',2,1),(104,'Thursday',2,'facultytewelve','ML',2,1),(105,'Thursday',4,'facultyone','Maths',2,1),(106,'Thursday',6,'facultyten','Zoology',3,2),(107,'Thursday',1,'facultyten','Zoology',3,2),(108,'Thursday',5,'facultyten','Zoology',3,2),(109,'Thursday',7,'facultyten','Zoology',3,2),(110,'Thursday',2,'facultyten','Zoology',3,2),(111,'Thursday',4,'facultyten','Zoology',3,2),(112,'Thursday',3,'facultyten','Zoology',3,2),(113,'Friday',3,'facultytewelve','Data Science',1,1),(114,'Friday',4,'facultythree','Chemistry',1,1),(115,'Friday',5,'facultyeleven','Machines',1,1),(116,'Friday',7,'facultyeleven','Machines',1,1),(117,'Friday',2,'facultythree','Chemistry',1,1),(118,'Friday',1,'facultytewelve','Data Science',1,1),(119,'Friday',6,'facultyeleven','Machines',1,1),(120,'Friday',5,'facultynine','English',1,2),(121,'Friday',6,'facultyseven','Natural Science',1,2),(122,'Friday',3,'facultyeleven','Robotics',1,2),(123,'Friday',2,'facultytwo','Science',1,2),(124,'Friday',4,'facultytwo','Science',1,2),(125,'Friday',1,'facultynine','English',1,2),(126,'Friday',7,'Gap period','Gap period',1,2),(127,'Friday',5,'facultyone','Maths',2,1),(128,'Friday',4,'facultytewelve','ML',2,1),(129,'Friday',2,'facultyseven','physics',2,1),(130,'Friday',1,'facultyone','Maths',2,1),(131,'Friday',6,'facultytewelve','ML',2,1),(132,'Friday',3,'facultyseven','physics',2,1),(133,'Friday',7,'facultytewelve','ML',2,1),(134,'Friday',4,'facultyten','Zoology',3,2),(135,'Friday',6,'facultyten','Zoology',3,2),(136,'Friday',5,'facultyten','Zoology',3,2),(137,'Friday',3,'facultyten','Zoology',3,2),(138,'Friday',1,'facultyten','Zoology',3,2),(139,'Friday',7,'facultyten','Zoology',3,2),(140,'Friday',2,'facultyten','Zoology',3,2),(141,'Saturday',5,'facultyeleven','Machines',1,1),(142,'Saturday',7,'facultytewelve','Data Science',1,1),(143,'Saturday',3,'facultythree','Chemistry',1,1),(144,'Saturday',6,'facultytewelve','Data Science',1,1),(145,'Saturday',2,'facultyeleven','Machines',1,1),(146,'Saturday',1,'facultythree','Chemistry',1,1),(147,'Saturday',4,'facultyeleven','Machines',1,1),(148,'Saturday',3,'facultynine','English',1,2),(149,'Saturday',1,'facultytwo','Science',1,2),(150,'Saturday',7,'facultyeleven','Robotics',1,2),(151,'Saturday',6,'facultyseven','Natural Science',1,2),(152,'Saturday',2,'facultynine','English',1,2),(153,'Saturday',4,'Gap period','Gap period',1,2),(154,'Saturday',5,'facultyseven','Natural Science',1,2),(155,'Saturday',4,'facultyone','Maths',2,1),(156,'Saturday',3,'facultytewelve','ML',2,1),(157,'Saturday',2,'facultyseven','physics',2,1),(158,'Saturday',1,'facultytewelve','ML',2,1),(159,'Saturday',5,'facultyone','Maths',2,1),(160,'Saturday',7,'facultyseven','physics',2,1),(161,'Saturday',6,'facultyone','Maths',2,1),(162,'Saturday',7,'facultyten','Zoology',3,2),(163,'Saturday',3,'facultyten','Zoology',3,2),(164,'Saturday',6,'facultyten','Zoology',3,2),(165,'Saturday',4,'facultyten','Zoology',3,2),(166,'Saturday',5,'facultyten','Zoology',3,2),(167,'Saturday',1,'facultyten','Zoology',3,2),(168,'Saturday',2,'facultyten','Zoology',3,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
