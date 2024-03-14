/*
SQLyog Enterprise - MySQL GUI v6.56
MySQL - 5.5.5-10.4.28-MariaDB : Database - time_table
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`time_table` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `all_teachers` */

insert  into `all_teachers`(`sn`,`name`,`email`,`subject`,`experience`,`year`,`semester`) values (1,'lohith','lohith@gmail.com','Alien',0,1,1),(2,'lakshmi','lakshmi@gmail.com','Boxing',0,1,1),(3,'nani','nani@gmail.com','Dragons',0,1,1),(4,'hari','hari@gmail.com','English',0,1,1),(5,'naveen','naveen@gmail.com','Html',0,1,2),(6,'jayanth','jayanth@gmail.com','Maths',0,1,2),(7,'likith','likith@gmail.com','html',0,2,1),(8,'kumar','kumar@gmail.com','js',0,2,1),(9,'jash','jash@gmail.com','physics',0,2,1),(10,'balaram','balaram@gmail.com','battle',0,2,2),(11,'lakshmi','lakshmi@gmail.com','civilization',0,2,2),(12,'jash','jash@gmail.com','computer',0,2,2),(13,'hari','hari@gmail.com','css',0,4,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `all_teachers_labs` */

insert  into `all_teachers_labs`(`sn`,`name`,`email`,`experience`,`year`,`semester`,`lab`) values (1,'lohith','lohith@gmail.com',0,1,1,'Alien'),(2,'lakshmi','lakshmi@gmail.com',0,1,1,'civilization'),(3,'nani','nani@gmail.com',0,1,1,'computer'),(4,'lakshmi','lakshmi@gmail.com',0,1,2,'Boxing'),(5,'nani','nani@gmail.com',0,2,1,'Dragons'),(6,'jayanth','jayanth@gmail.com',0,2,1,'Maths'),(7,'kumar','kumar@gmail.com',0,2,1,'Python3'),(8,'balaram','balaram@gmail.com',0,2,2,'battle'),(9,'hari','hari@gmail.com',0,3,1,'css'),(10,'kumar','kumar@gmail.com',0,3,2,'js'),(11,'jash','jash@gmail.com',0,3,2,'physics');

/*Table structure for table `class_lab` */

DROP TABLE IF EXISTS `class_lab`;

CREATE TABLE `class_lab` (
  `SN` int(10) NOT NULL AUTO_INCREMENT,
  `Year` int(10) NOT NULL,
  `Semester` int(10) NOT NULL,
  `Lab` varchar(100) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `class_lab` */

-- insert  into `class_lab`(`SN`,`Year`,`Semester`,`Lab`) values (1,1,1,'Alien'),(2,1,1,'civilization'),(3,1,2,'Boxing'),(4,1,2,'computer'),(5,2,1,'Dragons'),(6,2,1,'Maths'),(7,2,2,'computer'),(8,2,2,'battle'),(9,3,1,'Python'),(10,3,1,'css'),(11,3,2,'js'),(12,3,2,'physics'),(13,4,1,'Dragons'),(14,4,1,'Maths'),(15,4,2,'Python3'),(16,4,2,'computer');

/*Table structure for table `class_subz` */

DROP TABLE IF EXISTS `class_subz`;

CREATE TABLE `class_subz` (
  `SN` int(10) NOT NULL AUTO_INCREMENT,
  `Year` int(10) NOT NULL,
  `Semester` int(10) NOT NULL,
  `Subject` varchar(100) NOT NULL,
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `class_subz` */

-- insert  into `class_subz`(`SN`,`Year`,`Semester`,`Subject`) values (1,1,1,'Alien'),(2,1,1,'Boxing'),(3,1,1,'Dragons'),(4,1,1,'English'),(5,1,2,'Html'),(6,1,2,'Maths'),(7,1,2,'Python'),(8,1,2,'Python3'),(9,2,1,'physics'),(10,2,1,'maths'),(11,2,1,'js'),(12,2,1,'html'),(13,2,2,'computer'),(14,2,2,'civilization'),(15,2,2,'battle'),(16,2,2,'js'),(17,3,1,'Python3'),(18,3,1,'maths'),(19,3,1,'js'),(20,3,1,'civilization'),(21,3,2,'maths'),(22,3,2,'physics'),(23,3,2,'battle'),(24,3,2,'Python3'),(25,4,1,'computer'),(26,4,1,'Html'),(27,4,1,'Dragons'),(28,4,1,'Alien'),(29,4,2,'maths'),(30,4,2,'css'),(31,4,2,'battle'),(32,4,2,'Python3');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `register` */

-- insert  into `register`(`name`,`email`,`password`,`subject1`,`subject2`,`subject3`,`experience`) values ('balaram','balaram@gmail.com','123','Boxing','battle','Python',7),('hari','hari@gmail.com','123','css','English','maths',9),('jash','jash@gmail.com','123','physics','computer','maths',8),('jayanth','jayanth@gmail.com','123','Maths','Dragons','Python',3),('kumar','kumar@gmail.com','123','js','pending','pending',6),('lakshmi','lakshmi@gmail.com','123','Boxing','civilization','maths',7),('likith','likith@gmail.com','123','Boxing','html','maths',6),('lohith','lohith@gmail.com','123','Alien','css','js',3),('nani','nani@gmail.com','123','Boxing','Dragons','css',2),('naveen','naveen@gmail.com','123','css','Html','Python3',1);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `students` */

-- insert  into `students`(`Slno`,`name`,`email`,`year`,`sem`,`password`,`contact`,`address`) values (1,'nani','rakeshchenna@gmail.com','1','2','1234','7478757172','Hyderabad');

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
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `time_table` */

-- insert  into `time_table`(`sn`,`day`,`period`,`faculty`,`subject`,`year`,`semester`) values (1,'Monday',2,'nani','Dragons',1,1),(2,'Monday',5,'lohith','Alien',1,1),(3,'Monday',6,'lakshmi','Boxing',1,1),(4,'Monday',1,'hari','English',1,1),(5,'Monday',7,'hari','English',1,1),(6,'Monday',4,'nani','Dragons',1,1),(7,'Monday',3,'lakshmi','Boxing',1,1),(8,'Monday',3,'jayanth','Maths',1,2),(9,'Monday',6,'naveen','Html',1,2),(10,'Monday',7,'naveen','Html',1,2),(11,'Monday',4,'jayanth','Maths',1,2),(12,'Monday',5,'naveen','Html',1,2),(13,'Monday',2,'jayanth','Maths',1,2),(14,'Monday',1,'jayanth','Maths',1,2),(15,'Monday',2,'kumar','js',2,1),(16,'Monday',6,'likith','html',2,1),(17,'Monday',4,'jash','physics',2,1),(18,'Monday',1,'kumar','js',2,1),(19,'Monday',3,'likith','html',2,1),(20,'Monday',5,'jash','physics',2,1),(21,'Monday',7,'jash','physics',2,1),(22,'Monday',2,'jash','computer',2,2),(23,'Monday',7,'balaram','battle',2,2),(24,'Monday',1,'lakshmi','civilization',2,2),(25,'Monday',4,'lakshmi','civilization',2,2),(26,'Monday',6,'jash','computer',2,2),(27,'Monday',5,'balaram','battle',2,2),(28,'Monday',3,'jash','computer',2,2),(29,'Monday',3,'hari','css',4,2),(30,'Monday',2,'hari','css',4,2),(31,'Monday',6,'hari','css',4,2),(32,'Monday',4,'hari','css',4,2),(33,'Monday',5,'hari','css',4,2),(34,'Monday',1,'Gap period','Gap period',4,2),(35,'Monday',7,'Gap period','Gap period',4,2),(36,'Tuesday',5,'nani','Dragons',1,1),(37,'Tuesday',4,'lohith','Alien',1,1),(38,'Tuesday',2,'hari','English',1,1),(39,'Tuesday',7,'lakshmi','Boxing',1,1),(40,'Tuesday',3,'nani','Dragons',1,1),(41,'Tuesday',6,'lohith','Alien',1,1),(42,'Tuesday',1,'hari','English',1,1),(43,'Tuesday',6,'naveen','Html',1,2),(44,'Tuesday',4,'jayanth','Maths',1,2),(45,'Tuesday',7,'jayanth','Maths',1,2),(46,'Tuesday',2,'naveen','Html',1,2),(47,'Tuesday',3,'naveen','Html',1,2),(48,'Tuesday',5,'jayanth','Maths',1,2),(49,'Tuesday',1,'jayanth','Maths',1,2),(50,'Tuesday',2,'jash','physics',2,1),(51,'Tuesday',5,'likith','html',2,1),(52,'Tuesday',6,'kumar','js',2,1),(53,'Tuesday',1,'likith','html',2,1),(54,'Tuesday',3,'kumar','js',2,1),(55,'Tuesday',7,'jash','physics',2,1),(56,'Tuesday',4,'kumar','js',2,1),(57,'Tuesday',4,'lakshmi','civilization',2,2),(58,'Tuesday',6,'jash','computer',2,2),(59,'Tuesday',1,'balaram','battle',2,2),(60,'Tuesday',5,'balaram','battle',2,2),(61,'Tuesday',3,'lakshmi','civilization',2,2),(62,'Tuesday',2,'Gap period','Gap period',2,2),(63,'Tuesday',7,'Gap period','Gap period',2,2),(64,'Tuesday',5,'hari','css',4,2),(65,'Tuesday',3,'hari','css',4,2),(66,'Tuesday',7,'hari','css',4,2),(67,'Tuesday',4,'hari','css',4,2),(68,'Tuesday',6,'hari','css',4,2),(69,'Tuesday',1,'Gap period','Gap period',4,2),(70,'Tuesday',2,'Gap period','Gap period',4,2),(71,'Wednesday',3,'hari','English',1,1),(72,'Wednesday',1,'lohith','Alien',1,1),(73,'Wednesday',6,'lakshmi','Boxing',1,1),(74,'Wednesday',7,'nani','Dragons',1,1),(75,'Wednesday',2,'lohith','Alien',1,1),(76,'Wednesday',5,'lakshmi','Boxing',1,1),(77,'Wednesday',4,'nani','Dragons',1,1),(78,'Wednesday',6,'jayanth','Maths',1,2),(79,'Wednesday',1,'naveen','Html',1,2),(80,'Wednesday',3,'naveen','Html',1,2),(81,'Wednesday',5,'jayanth','Maths',1,2),(82,'Wednesday',7,'naveen','Html',1,2),(83,'Wednesday',4,'jayanth','Maths',1,2),(84,'Wednesday',2,'jayanth','Maths',1,2),(85,'Wednesday',2,'jash','physics',2,1),(86,'Wednesday',7,'kumar','js',2,1),(87,'Wednesday',3,'likith','html',2,1),(88,'Wednesday',5,'likith','html',2,1),(89,'Wednesday',4,'jash','physics',2,1),(90,'Wednesday',1,'kumar','js',2,1),(91,'Wednesday',6,'jash','physics',2,1),(92,'Wednesday',4,'lakshmi','civilization',2,2),(93,'Wednesday',1,'jash','computer',2,2),(94,'Wednesday',7,'balaram','battle',2,2),(95,'Wednesday',2,'lakshmi','civilization',2,2),(96,'Wednesday',5,'balaram','battle',2,2),(97,'Wednesday',3,'jash','computer',2,2),(98,'Wednesday',6,'Gap period','Gap period',2,2),(99,'Wednesday',7,'hari','css',4,2),(100,'Wednesday',4,'hari','css',4,2),(101,'Wednesday',5,'hari','css',4,2),(102,'Wednesday',1,'hari','css',4,2),(103,'Wednesday',2,'hari','css',4,2),(104,'Wednesday',6,'hari','css',4,2),(105,'Wednesday',3,'Gap period','Gap period',4,2),(106,'Thursday',6,'lohith','Alien',1,1),(107,'Thursday',2,'lakshmi','Boxing',1,1),(108,'Thursday',5,'nani','Dragons',1,1),(109,'Thursday',7,'hari','English',1,1),(110,'Thursday',4,'lohith','Alien',1,1),(111,'Thursday',1,'hari','English',1,1),(112,'Thursday',3,'lakshmi','Boxing',1,1),(113,'Thursday',6,'jayanth','Maths',1,2),(114,'Thursday',2,'naveen','Html',1,2),(115,'Thursday',1,'naveen','Html',1,2),(116,'Thursday',5,'jayanth','Maths',1,2),(117,'Thursday',4,'jayanth','Maths',1,2),(118,'Thursday',7,'naveen','Html',1,2),(119,'Thursday',3,'jayanth','Maths',1,2),(120,'Thursday',4,'kumar','js',2,1),(121,'Thursday',5,'likith','html',2,1),(122,'Thursday',3,'jash','physics',2,1),(123,'Thursday',2,'jash','physics',2,1),(124,'Thursday',1,'likith','html',2,1),(125,'Thursday',6,'kumar','js',2,1),(126,'Thursday',7,'likith','html',2,1),(127,'Thursday',4,'lakshmi','civilization',2,2),(128,'Thursday',2,'balaram','battle',2,2),(129,'Thursday',6,'jash','computer',2,2),(130,'Thursday',1,'balaram','battle',2,2),(131,'Thursday',7,'lakshmi','civilization',2,2),(132,'Thursday',5,'jash','computer',2,2),(133,'Thursday',3,'balaram','battle',2,2),(134,'Thursday',4,'hari','css',4,2),(135,'Thursday',2,'hari','css',4,2),(136,'Thursday',3,'hari','css',4,2),(137,'Thursday',5,'hari','css',4,2),(138,'Thursday',6,'hari','css',4,2),(139,'Thursday',1,'Gap period','Gap period',4,2),(140,'Thursday',7,'Gap period','Gap period',4,2),(141,'Friday',6,'lakshmi','Boxing',1,1),(142,'Friday',4,'hari','English',1,1),(143,'Friday',7,'lohith','Alien',1,1),(144,'Friday',2,'nani','Dragons',1,1),(145,'Friday',1,'lakshmi','Boxing',1,1),(146,'Friday',5,'lohith','Alien',1,1),(147,'Friday',3,'nani','Dragons',1,1),(148,'Friday',3,'jayanth','Maths',1,2),(149,'Friday',2,'naveen','Html',1,2),(150,'Friday',4,'jayanth','Maths',1,2),(151,'Friday',7,'naveen','Html',1,2),(152,'Friday',1,'naveen','Html',1,2),(153,'Friday',6,'jayanth','Maths',1,2),(154,'Friday',5,'jayanth','Maths',1,2),(155,'Friday',6,'likith','html',2,1),(156,'Friday',5,'jash','physics',2,1),(157,'Friday',4,'kumar','js',2,1),(158,'Friday',7,'kumar','js',2,1),(159,'Friday',2,'likith','html',2,1),(160,'Friday',1,'jash','physics',2,1),(161,'Friday',3,'jash','physics',2,1),(162,'Friday',2,'jash','computer',2,2),(163,'Friday',6,'balaram','battle',2,2),(164,'Friday',4,'lakshmi','civilization',2,2),(165,'Friday',1,'balaram','battle',2,2),(166,'Friday',3,'lakshmi','civilization',2,2),(167,'Friday',7,'jash','computer',2,2),(168,'Friday',5,'balaram','battle',2,2),(169,'Friday',5,'hari','css',4,2),(170,'Friday',2,'hari','css',4,2),(171,'Friday',6,'hari','css',4,2),(172,'Friday',7,'hari','css',4,2),(173,'Friday',1,'hari','css',4,2),(174,'Friday',3,'hari','css',4,2),(175,'Friday',4,'Gap period','Gap period',4,2),(176,'Saturday',3,'nani','Dragons',1,1),(177,'Saturday',1,'lohith','Alien',1,1),(178,'Saturday',2,'lakshmi','Boxing',1,1),(179,'Saturday',6,'hari','English',1,1),(180,'Saturday',7,'lohith','Alien',1,1),(181,'Saturday',4,'nani','Dragons',1,1),(182,'Saturday',5,'hari','English',1,1),(183,'Saturday',1,'jayanth','Maths',1,2),(184,'Saturday',3,'naveen','Html',1,2),(185,'Saturday',4,'jayanth','Maths',1,2),(186,'Saturday',7,'naveen','Html',1,2),(187,'Saturday',5,'jayanth','Maths',1,2),(188,'Saturday',2,'naveen','Html',1,2),(189,'Saturday',6,'naveen','Html',1,2),(190,'Saturday',5,'jash','physics',2,1),(191,'Saturday',3,'kumar','js',2,1),(192,'Saturday',4,'likith','html',2,1),(193,'Saturday',7,'jash','physics',2,1),(194,'Saturday',1,'likith','html',2,1),(195,'Saturday',2,'kumar','js',2,1),(196,'Saturday',6,'likith','html',2,1),(197,'Saturday',3,'lakshmi','civilization',2,2),(198,'Saturday',4,'jash','computer',2,2),(199,'Saturday',7,'balaram','battle',2,2),(200,'Saturday',1,'balaram','battle',2,2),(201,'Saturday',5,'lakshmi','civilization',2,2),(202,'Saturday',6,'jash','computer',2,2),(203,'Saturday',2,'balaram','battle',2,2),(204,'Saturday',7,'hari','css',4,2),(205,'Saturday',3,'hari','css',4,2),(206,'Saturday',1,'hari','css',4,2),(207,'Saturday',2,'hari','css',4,2),(208,'Saturday',4,'hari','css',4,2),(209,'Saturday',5,'Gap period','Gap period',4,2),(210,'Saturday',6,'Gap period','Gap period',4,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
