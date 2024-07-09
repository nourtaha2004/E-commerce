-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: newstore
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `quantity` bigint NOT NULL DEFAULT '100',
  `price` bigint NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`),
  KEY `fk_category_id` (`category_id`),
  KEY `idx_product_slug` (`slug`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (151,'Good Vibes Good Life',99,15,'good-vibes-good-life','A beautifully designed book full of inspiring quotes.',1),(152,'Think Like A Monk',100,14,'think-like-a-monk','Jay Shetty, social media superstar and host of the #1 podcast On Purpose.',1),(153,'The Mountain Is You',100,18,'the-mountain-is-you','This is a book about self-sabotage.',1),(154,'The Midnight Library',100,16,'the-midnight-library','Between life and death there is a library.',1),(155,'The Silent Patient',100,11,'the-silent-patient','Alicia Berenson’s life is seemingly perfect. One evening Alicia shoots him.',1),(156,'Rich Dad Poor Dad',100,20,'rich-dad-poor-dad','Robert developed his economic perspective from two different influences his two fathers.',1),(157,'The Alchemist',100,7,'the-alchemist','An boy travels from Spain to the Egyptian desert in search of a treasure buried near the Pyramids.',1),(158,'Eleanor And Park',100,12,'eleanor-and-park','Set over one school year in 1986, Eleanor & Park is the story of two star-crossed misfits.',1),(159,'Layla',100,9,'layla','An unexpected attack leaves Layla fighting for her life.',1),(160,'As Good As Dead',100,10,'as-good-as-dead','By the end of this mystery series, you will never think of good girls the same way again.',1),(161,'Code Of The Extraordinary Mind',100,12,'code-of-the-extraordinary-mind','What if you questioned everything you know and threw out all the pieces that hold you back?',1),(162,'For The Wolf',100,11,'for-the-wolf','The first daughter is for the Throne. The second daughter is for the Wolf.',1),(163,'It Starts With Us',100,10,'it-starts-with-us','Before It Ends with Us, it started with Atlas.',1),(164,'Love On The Brain',100,9,'love-on-the-brain','Rom-com in which a scientist is forced to work on a project with her nemesis.',1),(165,'You Have Reached Sam',100,11,'you-have-reached-sam','Heartbroken, Julie skips her boyfriend Sam funeral, and tries everything to forget him.',1),(166,'Atomic Habits',100,16,'atomic-habits','No matter your goals, Atomic Habits offers a proven framework for improving--every day.',1),(167,'Things We Never Got Over',100,11,'things-we-never-got-over','Bearded, bad-boy barber Knox prefers to live his life the way he takes his coffee: Alone.',1),(168,'How To Be Your Own Therapist',100,15,'how-to-be-your-own-therapist','Modern life is a minefield for stress.',1),(169,'Love And Other Words',100,11,'love-and-other-words','The story of the heart can never be unwritten.',1),(170,'IKIGAI',100,14,'ikigai','The Japanese secret to a long and happy life.',1),(171,'Anthelios Sunscreen',30,25,'anthelios-sunscreen','50+ Fluide invisible',2),(172,'Purifying Foaming Gel',30,30,'foaming-gel','for oily sensitive skin',2),(173,'Miceller Water',30,40,'miceller-water','cleansing make-up remover ',2),(174,'Pigemntclar Eyes',30,60,'pigmentclar-eyes','Eye contour smoother',2),(175,'Ultra Miceller Water',30,45,'ultra-miceller-water','for reactie skin',2),(176,'Effaclar Salicylic Acid Serum',30,45,'salicylic-acid-serum','for acne treatment',2),(177,'Vitamin C serum',30,50,'vitamin-c-serum','Anti-wrinkle concentrate',2),(178,'Effaclar Serum',29,75,'effaclar-serum','anti age serum',2),(179,'Effaclar DUO',29,60,'effaclar-duo','Dual action acne treatment',2),(180,'Effaclar Mat',30,70,'effaclar-mat','Daily moistrurizer for oily skin',2),(181,'Cicaplast Serum',30,30,'cicaplast-serum','ultra hydrant',2),(182,'Toleriane Ultra',30,45,'toleriane-ultra','daily smoothing for sensitive skin',2),(183,'Stick',30,10,'stick','lip sunprotection 50+',2),(184,'ultra sun protection',30,25,'ultra-protection','50+ for sensitive skin',2),(185,'Anthelios Airlicium',30,50,'anthelios-airlicium','70+ sunprotection matte',2),(186,'Nutritic levres Lips',30,10,'nutritic-levres','lip balm for very dry lips',2),(187,'Cleansing Foaming Oil',30,45,'foaming-oil','Dry to extra Dry skin',2),(188,'Effaclar Gel',30,45,'effaclar-gel','face daily wash',2),(189,'Hyalu serum',30,50,'hyalu-serum','B5 serum for anti aging',2),(190,'Triple Moisturizer Cream',30,60,'triple-moist-cream','Daily moistrurizer for extra dry skin',2),(191,'Burgundy 2D Logo',30,15,'Burgundy-2D-Logo','Semi silk Turquoise',3),(192,'Burgundy Jade',30,15,'Burgundy-Jade','Semi silk Burgundy',3),(193,'Laptop Case',10,20,'Laptop-case','20cm * 25cm dimension',3),(194,'Make-up Organizer',30,5,'Make-up-organizer','15cm * 10cm dimension',3),(195,'Wallet',15,6,'wallet','7cm * 7cm dimension',3),(196,'ToteBag Flowers',20,10,'totebag-flower','20cm * 25cm dimension',3),(197,'Sunglasses',30,30,'sunglasses','Brown Shade',3),(198,'Backpack',5,20,'backpack','black color, 30cm * 30cm dimension',3),(199,'Metalic Gloves',8,5,'metalic-gloves','Rose Color',3),(200,'Wool Gloves',8,5,'wool-gloves','Beig color',3),(201,'Shaul',8,20,'shaul','45cm * 45cm dimension',3),(202,'Shoulder Bag',10,50,'shoulder-bag','brown Color',3),(203,'Cross Bag',10,50,'cross-bag','Black Color',3),(204,'Wool Hat',40,6,'wool-hat','beige color',3),(205,'Pink Shaul',8,23,'pink-shaul','50cm * 50cm dimension',3),(206,'Gray Shaul',10,23,'gray-shaul','23cm * 40cm dimension',3),(207,'Bucket Hat',15,6,'bucket-hat','beige color',3),(208,'Hand Bag',10,100,'hand-bag',' brown color',3),(209,'University Totebag',50,15,'uni-totebag','30cm * 30cm dimension',3),(210,'belt',30,4,'belt','chest: 30-60cm',3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-19  1:38:50
