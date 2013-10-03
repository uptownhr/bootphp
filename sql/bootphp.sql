-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: proccrm
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.12.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Authenticator`
--

DROP TABLE IF EXISTS `Authenticator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Authenticator` (
  `authenticator_id` int(11) NOT NULL AUTO_INCREMENT,
  `authenticator_user_id` int(11) DEFAULT NULL,
  `authenticator_secret` varchar(16) DEFAULT NULL,
  `authenticator_sms` varchar(64) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `deleted` datetime DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`authenticator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Authenticator`
--

LOCK TABLES `Authenticator` WRITE;
/*!40000 ALTER TABLE `Authenticator` DISABLE KEYS */;
INSERT INTO `Authenticator` VALUES (1,5,'7FLPGWSTSY76RE3L','323123456',NULL,1,NULL,'2013-10-02 07:23:08');
/*!40000 ALTER TABLE `Authenticator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `category` varchar(128) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `path` varchar(512) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`category_id`),
  KEY `path` (`path`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (11,'Post','General',0,'11','2013-09-03 18:14:24','2013-09-03 11:14:24',NULL,1),(14,'Post','test3',11,'11,14','2013-09-03 20:55:35','2013-09-03 13:55:35',NULL,1),(15,'Post','test4',11,'11,15','2013-09-03 20:57:34','2013-09-03 13:57:34',NULL,1),(16,'Post','test5',14,'11,14,16','2013-09-03 20:57:54','2013-09-03 13:57:54',NULL,1),(17,'Post','test6',14,'17','2013-09-04 18:47:00','2013-09-04 11:57:57',NULL,1);
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hit`
--

DROP TABLE IF EXISTS `Hit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hit` (
  `hit_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `ip` varchar(32) DEFAULT '',
  `page` varchar(64) NOT NULL,
  `request_method` enum('GET','POST') NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hit_id`),
  KEY `page` (`page`),
  KEY `ip` (`ip`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hit`
--

LOCK TABLES `Hit` WRITE;
/*!40000 ALTER TABLE `Hit` DISABLE KEYS */;
/*!40000 ALTER TABLE `Hit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Page`
--

DROP TABLE IF EXISTS `Page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Page` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `view_script` varchar(32) NOT NULL,
  `title` varchar(128) NOT NULL,
  `permalink` varchar(512) NOT NULL,
  `src` enum('none','file','html') NOT NULL DEFAULT 'file',
  `file` varchar(128) NOT NULL,
  `html` text NOT NULL,
  `rank` tinyint(4) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Page`
--

LOCK TABLES `Page` WRITE;
/*!40000 ALTER TABLE `Page` DISABLE KEYS */;
INSERT INTO `Page` VALUES (1,'layout','About Us','/page/about','file','page/about.phtml','<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS--><img alt=\" \" class=\"img-align-left\" height=\"66\" src=\"/themes/adventure/images/icons/idea.png\" width=\"66\" />\r\n	<h4>\r\n		Our Vision</h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia. Quaere allocutus ait regem ut sua etiam quantitas non solutionem invenisti.</p>\r\n	<br />\r\n	<ul class=\"round-list\">\r\n		<li>\r\n			Site Redesign</li>\r\n		<li>\r\n			Custom CMS Developmet</li>\r\n		<li>\r\n			Custom Booking System</li>\r\n		<li>\r\n			SEO Optimization</li>\r\n		<li>\r\n			Our Web Hosting Solution</li>\r\n	</ul>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS--><img alt=\" \" class=\"img-align-left\" height=\"66\" src=\"/themes/adventure/images/icons/check-box.png\" width=\"66\" />\r\n	<h4>\r\n		Our talented team</h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia. Quaere allocutus ait regem ut sua etiam quantitas non solutionem invenisti.</p>\r\n	<br />\r\n	<ul class=\"round-list\">\r\n		<li>\r\n			Site Redesign</li>\r\n		<li>\r\n			Custom CMS Developmet</li>\r\n		<li>\r\n			Custom Booking System</li>\r\n		<li>\r\n			SEO Optimization</li>\r\n		<li>\r\n			Our Web Hosting Solution</li>\r\n	</ul>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth last\">\r\n	<!-- COLUMN STARTS--><img alt=\" \" class=\"img-align-left\" height=\"66\" src=\"/themes/adventure/images/icons/display.png\" width=\"66\" />\r\n	<h4>\r\n		How to Apply?</h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia. Quaere allocutus ait regem ut sua etiam quantitas non solutionem invenisti.</p>\r\n	<br />\r\n	<ul class=\"round-list\">\r\n		<li>\r\n			Site Redesign</li>\r\n		<li>\r\n			Custom CMS Developmet</li>\r\n		<li>\r\n			Custom Booking System</li>\r\n		<li>\r\n			SEO Optimization</li>\r\n		<li>\r\n			Our Web Hosting Solution</li>\r\n	</ul>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"horizontal-line\">\r\n	&nbsp;</div>\r\n<p>\r\n	Concordi fabricata ait regem Ardalio nos comitem in deinde cepit roseo ruens sed dominum oculos. Hanc nec caecatus dum est Apollonius. Atque album Apolloni dicere communicabilis omnibus. Archistrate accepta quaestionum ut a his domino nostrud, scilicet in fuerat eum ego Pentapolim Cyrenaeorum tertia. Valde agam eam eos est Apollonius mihi esse more fuerit mitti.Mariae maximas hanc si mihi esse deprecor Athenagora mihi Tyrum ad quia ei primum subsannio oculos ut libertatem accipies.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.Taliarchum in deinde cepit roseo commendavit fideliter harena in lucem!</p>\r\n',1,'2011-10-27 06:44:32','2012-03-03 09:13:08',NULL,1),(2,'layout','Services','/page/services','html','page/services.phtml','<p>\r\n	<img alt=\" \" src=\"/themes/adventure/images/our-services.png\" /></p>\r\n<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS-->\r\n	<h4>\r\n		Our Vision</h4>\r\n	<p>\r\n		Jien Framework wants to be the fastest CMS around with a concret MVC structure.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS-->\r\n	<h4>\r\n		Our talented team</h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia. Quaere allocutus ait regem ut sua etiam quantitas non solutionem invenisti.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth last\">\r\n	<!-- COLUMN STARTS-->\r\n	<h4>\r\n		How to Find Us?</h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia. Quaere allocutus ait regem ut sua etiam quantitas non solutionem invenisti.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"horizontal-line\">\r\n	&nbsp;</div>\r\n<h4>\r\n	Why Choose &quot;Adventure&quot; for Your Business</h4>\r\n<p>\r\n	Concordi fabricata ait regem Ardalio nos comitem in deinde cepit roseo ruens sed dominum oculos. Hanc nec caecatus dum est Apollonius. Atque album Apolloni dicere communicabilis omnibus. Archistrate accepta quaestionum ut a his domino nostrud, scilicet in fuerat eum ego Pentapolim Cyrenaeorum tertia. Valde agam eam eos est Apollonius mihi esse more fuerit mitti.Mariae maximas hanc si mihi esse deprecor Athenagora mihi Tyrum ad quia ei primum subsannio oculos ut libertatem accipies.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.Taliarchum in deinde cepit roseo commendavit fideliter harena in lucem!</p>\r\n<div class=\"horizontal-line\">\r\n	&nbsp;</div>\r\n<h4>\r\n	Latest Projects</h4>\r\n<div class=\"one-fourth\">\r\n	<p>\r\n		<a class=\"portfolio-item-preview\" data-rel=\"prettyPhoto\" href=\"/themes/adventure/images/slideshow/slide-01.jpg\"><img alt=\" \" class=\"portfolio-img pretty-box\" height=\"145\" src=\"/themes/adventure/images/portfolio/portfolio-img-04.jpg\" width=\"210\" /></a></p>\r\n	<h4>\r\n		<a href=\"#\">Awesome Design</a></h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia.Amice suspiciosa mare non solutionem.</p>\r\n	<p>\r\n		<a href=\"#\">View Entire Portfolio</a></p>\r\n</div>\r\n<div class=\"one-fourth\">\r\n	<p>\r\n		<a class=\"portfolio-item-preview\" data-rel=\"prettyPhoto\" href=\"/themes/adventure/images/slideshow/slide-01.jpg\"><img alt=\" \" class=\"portfolio-img pretty-box\" height=\"145\" src=\"/themes/adventure/images/portfolio/portfolio-img-03.jpg\" width=\"210\" /></a></p>\r\n	<h4>\r\n		<a href=\"#\">Awesome Design</a></h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia.Amice suspiciosa mare non solutionem.</p>\r\n</div>\r\n<div class=\"one-fourth last\">\r\n	<p>\r\n		<a class=\"portfolio-item-preview\" data-rel=\"prettyPhoto\" href=\"/themes/adventure/images/slideshow/slide-01.jpg\"><img alt=\" \" class=\"portfolio-img pretty-box\" height=\"145\" src=\"/themes/adventure/images/portfolio/portfolio-img-01.jpg\" width=\"210\" /></a></p>\r\n	<h4>\r\n		<a href=\"#\">Awesome Design</a></h4>\r\n	<p>\r\n		Lorem ipsum dolor sit amet, tollite fit manibus individuationis omnibus civitas ad quia.Amice suspiciosa mare non solutionem.</p>\r\n</div>\r\n<p>\r\n	&nbsp;</p>\r\n',6,'2011-11-06 05:24:16','2011-11-06 01:17:05',NULL,1),(3,'layout','Our Team','/page/team','html','','<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS-->\r\n	<p>\r\n		<img alt=\"\" height=\"120\" src=\"/themes/adventure/images/team/member-1.jpg\" width=\"220\" /></p>\r\n	<h4>\r\n		John Smith</h4>\r\n	<ul class=\"team-social-icons\">\r\n		<li>\r\n			<img alt=\"facebook\" height=\"16\" src=\"/themes/adventure/images/icons/facebook.png\" width=\"16\" /><a href=\"#\">Facebook</a></li>\r\n		<li>\r\n			<img alt=\"twitter\" height=\"16\" src=\"/themes/adventure/images/icons/twitter.png\" width=\"16\" /><a href=\"#\">Twitter</a></li>\r\n	</ul>\r\n	<br />\r\n	<p>\r\n		Cras ultrices sollicitudin neque in fermentum. Mauris euismod dapibus sem nec rutrum. Aliquam ac convallis mauris. Lorem ipsum dolor sit amet.</p>\r\n	<p>\r\n		Etiam ut auctor nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In sem turpis, auctor venenatis fringilla.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth\">\r\n	<!-- COLUMN STARTS-->\r\n	<p>\r\n		<img alt=\"\" height=\"120\" src=\"/themes/adventure/images/team/member-2.jpg\" width=\"220\" /></p>\r\n	<h4>\r\n		Jane Smith</h4>\r\n	<ul class=\"team-social-icons\">\r\n		<li>\r\n			<img alt=\"facebook\" height=\"16\" src=\"/themes/adventure/images/icons/dribbble.png\" width=\"16\" /><a href=\"#\">Dribbble</a></li>\r\n		<li>\r\n			<img alt=\"twitter\" height=\"16\" src=\"/themes/adventure/images/icons/twitter.png\" width=\"16\" /><a href=\"#\">Twitter</a></li>\r\n	</ul>\r\n	<br />\r\n	<p>\r\n		Cras ultrices sollicitudin neque in fermentum. Mauris euismod dapibus sem nec rutrum. Aliquam ac convallis mauris. Lorem ipsum dolor sit amet.</p>\r\n	<p>\r\n		Etiam ut auctor nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In sem turpis, auctor venenatis fringilla.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-fourth last\">\r\n	<!-- COLUMN STARTS-->\r\n	<p>\r\n		<img alt=\"\" height=\"120\" src=\"/themes/adventure/images/team/member-3.jpg\" width=\"220\" /></p>\r\n	<h4>\r\n		John Doe</h4>\r\n	<ul class=\"team-social-icons\">\r\n		<li>\r\n			<img alt=\"facebook\" height=\"16\" src=\"/themes/adventure/images/icons/vimeo.png\" width=\"16\" /><a href=\"#\">Vimeo</a></li>\r\n		<li>\r\n			<img alt=\"twitter\" height=\"16\" src=\"/themes/adventure/images/icons/twitter.png\" width=\"16\" /><a href=\"#\">Twitter</a></li>\r\n	</ul>\r\n	<br />\r\n	<p>\r\n		Cras ultrices sollicitudin neque in fermentum. Mauris euismod dapibus sem nec rutrum. Aliquam ac convallis mauris. Lorem ipsum dolor sit amet.</p>\r\n	<p>\r\n		Etiam ut auctor nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In sem turpis, auctor venenatis fringilla.</p>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"horizontal-line\">\r\n	&nbsp;</div>\r\n<p>\r\n	Concordi fabricata ait regem Ardalio nos comitem in deinde cepit roseo ruens sed dominum oculos. Hanc nec caecatus dum est Apollonius. Atque album Apolloni dicere communicabilis omnibus. Archistrate accepta quaestionum ut a his domino nostrud, scilicet in fuerat eum ego Pentapolim Cyrenaeorum tertia. Valde agam eam eos est Apollonius mihi esse more fuerit mitti.Mariae maximas hanc si mihi esse deprecor Athenagora mihi Tyrum ad quia ei primum subsannio oculos ut libertatem accipies.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.Taliarchum in deinde cepit roseo commendavit fideliter harena in lucem!</p>\r\n<p>\r\n	Concordi fabricata ait regem Ardalio nos comitem in deinde cepit roseo ruens sed dominum oculos. Hanc nec caecatus dum est Apollonius. Atque album Apolloni dicere communicabilis omnibus. Archistrate accepta quaestionum ut a his domino nostrud, scilicet in fuerat eum ego Pentapolim Cyrenaeorum tertia. Valde agam eam eos est Apollonius mihi esse more fuerit mitti.Mariae maximas hanc si mihi esse deprecor Athenagora mihi Tyrum ad quia ei primum subsannio oculos ut libertatem accipies.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.</p>\r\n<p>\r\n	Adipiscing enixa ait mea ego Pentapolim Cyrenaeorum tertia veni mei locupletatus abscede dicentem. Duc quia illum in rei completo litus tuos ratio indue villicus potest in modo invenit Boreas quam crucis corpore expandit te.Taliarchum in deinde cepit roseo commendavit fideliter harena in lucem!</p>\r\n',3,'2011-11-06 06:55:56','2011-11-06 01:16:48',NULL,1),(4,'layout','Testimonials','/page/testimonials','file','page/testimonials.phtml','<div class=\"one-third-big\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-left\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-2.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-third-big last\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-right\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-3.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-third-big\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-left\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-4.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-third-big last\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-right\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-5.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-third-big\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-left\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-6.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n<!-- COLUMN ENDS-->\r\n<div class=\"one-third-big last\">\r\n	<!-- COLUMN STARTS-->\r\n	<blockquote class=\"blockquote-right\">\r\n		<img alt=\" \" class=\"img-align-left\" height=\"60\" src=\"/themes/adventure/images/avatar-1.jpg\" width=\"60\" />\r\n		<p>\r\n			Donec ac cursus turpis. Vivamus vel luctus ligula. Donec ante turpis, pellentesque eget luctus a, pellentesque placerat magna. Integer in ligula elementum mi placerat sollicitudin. Phasellus varius leo vel nisi pretium pharetra. Etiam ornare quam eget nunc imperdiet varius.<br />\r\n			<span><strong><a href=\"#\">John Doe</a></strong>, Some Business.</span></p>\r\n	</blockquote>\r\n</div>\r\n',4,'2011-11-06 06:59:42','2011-11-06 01:22:21',NULL,1),(5,'index','Contact Us','/contact','none','','',50,'2011-11-06 07:21:48','2011-11-06 01:14:10',NULL,1),(6,'pricing.phtml','Pricing','/page/pricing','','page/faq.phtml','<p>\r\n	PRICING</p>\r\n',2,'2011-11-06 07:35:12','2011-11-06 00:53:52','2011-11-06 00:53:52',0),(7,'pricing','Pricing','/page/pricing','none','','',7,'2011-11-06 09:18:39','2011-11-06 01:21:24',NULL,1);
/*!40000 ALTER TABLE `Page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post`
--

DROP TABLE IF EXISTS `Post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `category_id` int(11) NOT NULL,
  `status` enum('pending','published') NOT NULL,
  `subject` varchar(256) NOT NULL,
  `message` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`post_id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post`
--

LOCK TABLES `Post` WRITE;
/*!40000 ALTER TABLE `Post` DISABLE KEYS */;
INSERT INTO `Post` VALUES (1,5,0,'published','testtest','<p>test</p>\r\n','2013-09-03 15:27:52','2013-09-04 09:24:27',NULL,1);
/*!40000 ALTER TABLE `Post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Provider`
--

DROP TABLE IF EXISTS `Provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL,
  `deleted` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Provider`
--

LOCK TABLES `Provider` WRITE;
/*!40000 ALTER TABLE `Provider` DISABLE KEYS */;
INSERT INTO `Provider` VALUES (1,'website','2011-11-02 05:16:23','0000-00-00 00:00:00','0000-00-00 00:00:00',1),(2,'facebook','2011-11-02 05:16:48','0000-00-00 00:00:00','0000-00-00 00:00:00',1),(3,'twitter','2011-11-02 05:16:53','0000-00-00 00:00:00','0000-00-00 00:00:00',1);
/*!40000 ALTER TABLE `Provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(32) NOT NULL,
  `parent_id` tinyint(4) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL,
  `deleted` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'guest',0,'2011-10-27 02:13:00','2013-09-27 15:05:25','0000-00-00 00:00:00',1),(2,'member',1,'2011-10-27 02:13:10','2011-11-06 20:20:16','0000-00-00 00:00:00',1),(3,'underwriter',2,'2011-10-27 02:13:41','2012-11-07 17:35:48','0000-00-00 00:00:00',1),(10,'moderator',0,'2011-10-27 02:13:47','2011-11-06 20:20:30','0000-00-00 00:00:00',1),(11,'admin',10,'2011-10-27 02:13:52','2011-11-06 20:20:35','0000-00-00 00:00:00',1);
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL DEFAULT '1',
  `uid` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT '1',
  `username` varchar(64) NOT NULL,
  `password` varchar(60) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `email` varchar(64) NOT NULL,
  `birthday` date DEFAULT NULL,
  `b_fname` varchar(64) NOT NULL,
  `b_lname` varchar(64) NOT NULL,
  `b_addr1` varchar(128) NOT NULL,
  `b_addr2` varchar(128) NOT NULL,
  `b_city` varchar(128) NOT NULL,
  `b_state` varchar(2) NOT NULL,
  `b_zip` int(11) NOT NULL,
  `b_country` varchar(32) NOT NULL,
  `phone` varchar(32) NOT NULL,
  `comment` text,
  `token` varchar(1024) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `deleted` datetime DEFAULT NULL,
  `accessed` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (5,1,0,11,'admin','$2a$08$LtbZ7x22f4uYzlBJz.2nBuIg2L5HiX0APDWPJZT0Tv1pkVvs6BYqS','male','admin@jaequery.com','1982-01-06','Jae','Lee','12908 bloomfield st.','#101','studio city','CA',91604,'United States','3234205970','Test','','2011-10-11 15:40:41','2013-09-27 14:20:55','0000-00-00 00:00:00','2013-09-27 14:20:55',1),(69,1,0,2,'test','$2a$08$QkswNFwphmA5afKq7hxRkebQO1YVr7crwz9BaE8RsR6FuMmTKpvre','male','test',NULL,'','','','','','',0,'','',NULL,NULL,'2012-11-15 22:36:57','2012-11-15 14:36:57',NULL,'2012-11-15 14:36:57',1),(72,1,0,2,'jaequery@gmail.com','$2a$08$XZ.6CEUUx5gTuDHD25Fs4ueyKqbXihv7C2UZxCQaZkhyrvgaIHd9G','male','jaequery@gmail.com',NULL,'Jae','Lee','15303 Ventura Blvd Ste.','123','sherman oaks','CA',12341,'','','hey wtf',NULL,'2012-11-16 23:47:11','2012-12-03 16:15:04',NULL,'2012-12-03 16:14:53',1),(77,1,0,2,'test@test.com','$2a$08$59wKGdKXjCwB41HMJNWFQekv.6kWVjKE52nAW6pyZC2p1TtlF84MS','male','test@test.com',NULL,'jung','ji','15303 Ventura Blvd Ste.','#101','Los Angeless','CA',91604,'','3234205970','Hi there','cus_0qsNghHoKf88vG','2012-11-20 20:47:43','2012-12-06 13:16:43',NULL,'2012-12-06 13:16:43',1),(78,1,0,2,'uptownhr@gmail.com','$2a$08$uU3q1uQXB79TBF1mWhN3FutGrsv4vVwYeCEzNHz1z1xlovJYo7iNq','male','uptownhr@gmail.com',NULL,'JAMES','LEE','13914 Fenton Ave','','','CA',91342,'','',NULL,NULL,'2012-11-21 23:01:14','2013-05-14 14:18:04','2013-05-14 14:18:04','2012-11-21 15:01:14',0),(79,1,0,11,'jekabs','$2a$08$1jbxzEcP5ZiQlKidXXUyseRfHiAcRqPKnMM/cSHHLa7vNCpjQmwuG','male','jekabs_sliede@hotmail.com','0000-00-00','jekabs','sliede','1242 s barrington ave','','los angeles','Ca',90025,'United States','3234205970','','','2013-05-21 16:59:23','2013-05-21 10:03:34',NULL,'2013-05-21 10:03:34',1);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-03 12:40:06
