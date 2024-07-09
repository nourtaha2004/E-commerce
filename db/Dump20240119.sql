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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `total_price` bigint DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `cart_ibfk_2` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'books','img.png','CLothes'),(2,'skin-care',NULL,NULL),(3,'accessories','image.jpg','This is a new category');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `order_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `city` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `apartment` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  CONSTRAINT `fk_user_id_delv` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delivery_insert` AFTER INSERT ON `delivery` FOR EACH ROW BEGIN
    -- Set confirm_delivery to 1 for the corresponding user
    UPDATE user
    SET confirm_delivery = 1
    WHERE user_id = NEW.user_id; -- Replace 'user_id' with the actual foreign key column name
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `details_id` bigint NOT NULL AUTO_INCREMENT,
  `order_date` datetime DEFAULT NULL,
  `quantity` int NOT NULL,
  `product_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`details_id`),
  UNIQUE KEY `details_id_UNIQUE` (`details_id`),
  KEY `fk_order_id` (`order_id`),
  KEY `fk_product_id` (`product_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `total_price` double(8,2) NOT NULL,
  `fulfilled` int NOT NULL,
  `order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `user_order_foreign` (`user_id`),
  CONSTRAINT `user_order_foreign` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT,
  `card_number` varchar(16) NOT NULL,
  `cardholder_name` varchar(100) NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `user_id` bigint NOT NULL,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`payment_id`,`user_id`),
  UNIQUE KEY `payment_id_UNIQUE` (`payment_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_payment_insert` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
    -- Set confirm_payment to 1 for the corresponding user
    UPDATE user
    SET confirm_payment = 1
    WHERE user_id = NEW.user_id; -- Replace 'user_id' with the actual foreign key column name
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(10) NOT NULL,
  `confirm_pwd` varchar(100) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `confirm_delivery` int DEFAULT NULL,
  `confirm_payment` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Mans','mans@mans.io','pass123','admin','pass123','YourLastName','mans_username',0,0),(2,'Ali','ali@mans.io','pass123','customer','pass123','YourLastName','ali_username',NULL,NULL),(3,'Nour','nour@mans.io','pass123','customer','pass123','YourLastName','nour_username',0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  ` wishlist_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `product_slug` varchar(100) NOT NULL,
  PRIMARY KEY (` wishlist_id`),
  UNIQUE KEY ` wishlist_id_UNIQUE` (` wishlist_id`),
  KEY `fk_wishlist_product` (`product_slug`),
  KEY `fk_wishlist_customer` (`customer_id`),
  CONSTRAINT `fk_wishlist_customer` FOREIGN KEY (`customer_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_wishlist_product` FOREIGN KEY (`product_slug`) REFERENCES `product` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_wishlist` BEFORE INSERT ON `wishlist` FOR EACH ROW BEGIN
  DECLARE user_role VARCHAR(50);

  SELECT role INTO user_role
  FROM User
  WHERE user_id = NEW.customer_id;

  IF user_role <> 'customer' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid customer role for Wishlist entry';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'newstore'
--
/*!50003 DROP FUNCTION IF EXISTS `getTotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getTotal`(
    p_productID BIGINT,
    p_quantity INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE productPrice INT;

    -- Check if the product exists
    SELECT price INTO productPrice
    FROM product
    WHERE product_id = p_productID;

    -- If the product does not exist, return an error value
    IF productPrice IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product does not exist';
    END IF;

    -- Calculate and return the total price
    RETURN productPrice * p_quantity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCategory`(
    IN p_categoryNameParam VARCHAR(45),
    IN p_imageFileNameParam VARCHAR(255),
    IN p_descriptionParam TEXT
)
BEGIN
    DECLARE categoryExists INT;

    -- Check if the category already exists
    SELECT COUNT(*) INTO categoryExists
    FROM category
    WHERE category_name = p_categoryNameParam;

    -- If the category does not exist, insert it
    IF categoryExists = 0 THEN
        INSERT INTO category (category_name, image_file_name, description)
        VALUES (p_categoryNameParam, p_imageFileNameParam, p_descriptionParam);
    ELSE
        SELECT 'Category already exists' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduct`(
    IN p_productNameParam VARCHAR(100),
    IN p_quantityParam BIGINT,
    IN p_priceParam BIGINT,
    IN p_slugParam VARCHAR(100),
    IN p_descriptionParam VARCHAR(100),
    IN p_categoryIdParam BIGINT
)
BEGIN
    DECLARE productExists INT;

    -- Check if the product already exists
    SELECT COUNT(*) INTO productExists
    FROM product
    WHERE name = p_productNameParam AND category_id = p_categoryIdParam;

    -- If the product does not exist, insert it
    IF productExists = 0 THEN
        INSERT INTO product (name, quantity, price, slug, description, category_id)
        VALUES (p_productNameParam, p_quantityParam, p_priceParam, p_slugParam, p_descriptionParam, p_categoryIdParam);
    ELSE
        -- Return a message indicating that the product already exists
        SELECT 'Product already exists' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addToCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addToCart`(
    IN p_userID BIGINT,
    IN p_productID BIGINT,
    IN p_Quantity INT
)
BEGIN
    DECLARE itemExists INT;
    DECLARE errorMessage VARCHAR(255);

    -- Check if the item already exists in the cart
    SELECT COUNT(*) INTO itemExists
    FROM cart
    WHERE user_id = p_userID AND product_id = p_productID;

    -- If the item already exists, update the quantity
    IF itemExists > 0 THEN
        CALL editCart(p_userID, p_productID, p_Quantity);
    ELSE
        -- Add a new row to the cart
        INSERT INTO cart (user_id, product_id, quantity, total_price)
        VALUES (p_userID, p_productID, p_Quantity, getTotal(p_productID, p_Quantity));
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddToWishlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddToWishlist`(
    IN p_customer_id BIGINT,
    IN p_product_slug VARCHAR(100)
)
BEGIN
    DECLARE productExists INT;

    -- Check if the product exists
    SELECT COUNT(*) INTO productExists
    FROM product
    WHERE slug = p_product_slug;

    -- If the product exists, add it to the wishlist
    IF productExists > 0 THEN
        INSERT INTO wishlist (customer_id, product_slug) VALUES (p_customer_id, p_product_slug);
    ELSE
        -- Handle the case where the product does not exist
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Product does not exist';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrder`(
    IN user_id_param BIGINT,
    IN city_param varchar(100),IN street_param varchar(100),
    IN  phone_number_param varchar(20),
    IN apartment_param varchar(50),
    IN card_number_param VARCHAR(16),
    IN expiration_date_param DATE,
    IN cardholder_name_param VARCHAR(100),
    IN cvv_param VARCHAR(3)
)
BEGIN
    DECLARE order_id_param BIGINT;
    DECLARE total_order_price DOUBLE;
    DECLARE errorMessage VARCHAR(100);
      DECLARE finished INT DEFAULT 0;
      DECLARE existing_quantity INT;
    DECLARE product_id_param, quantity_param, total_price_param INT;
    DECLARE cart_cursor CURSOR FOR
        SELECT product_id, quantity, total_price
        FROM cart
        WHERE user_id = user_id_param;

    -- Declare handlers for exceptions
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
       start transaction;

    -- Create an order with a default total_price value
    INSERT INTO orders (user_id, total_price, fulfilled, order_date)
    VALUES (user_id_param, 0, 0, NOW());

    -- Get the ID of the inserted order
    SELECT LAST_INSERT_ID() INTO order_id_param;

  SET total_order_price = 0;
    -- Open the cursor
    OPEN cart_cursor;

    cart_loop: LOOP
        FETCH cart_cursor INTO product_id_param, quantity_param, total_price_param;

      IF finished = 1 THEN
        LEAVE cart_loop;
      END IF;
      
      -- Get the existing quantity for the specified product
    SELECT quantity INTO existing_quantity
    FROM product
    WHERE product_id = product_id_param;

        -- Calculate the new quantity
        SET existing_quantity = existing_quantity - quantity_param;
      
      -- Check if the specified quantity is valid
    IF quantity_param < existing_quantity THEN
    
        -- Update the total price of the order
        SET total_order_price = total_order_price + total_price_param;

        -- Add details to the order_details table
        INSERT INTO order_details ( order_date, quantity, product_id, order_id)
        VALUES ( NOW(), quantity_param, product_id_param, order_id_param);
        
         CALL deleteProductByQuantity(product_id_param , quantity_param );
         
         -- Commit the transaction
        COMMIT;
      ELSE
        -- Rollback and throw an error if quantity not available
     
    SET errorMessage = CONCAT('Insufficient quantity available for product in the cart.');
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
        ROLLBACK;
      END IF;
    END LOOP;
    

    -- Close the cursor
    CLOSE cart_cursor;

    -- Update the row in the orders table with the new total price
    UPDATE orders
    SET total_price = total_order_price
    WHERE order_id = order_id_param;

    -- Check payment details
    IF NOT EXISTS (SELECT 1 FROM payment WHERE user_id = user_id_param) THEN
        -- Insert payment details
        CALL insertPaymentDetails(user_id_param, card_number_param, expiration_date_param, cardholder_name_param, cvv_param);
    END IF;

    -- Check delivery details
    IF NOT EXISTS (SELECT 1 FROM delivery WHERE user_id = user_id_param) THEN
        -- Insert into the delivery table
        INSERT INTO delivery (order_id, city, street, phone_number, appartment,user_id)
         VALUES
        (order_id_param, city_param, street_param, phone_number_param, apartment_param,user_id_param);

    END IF;

CALL deleteCartDetailsByUserId(user_id_param);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCartDetailsByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCartDetailsByUserId`(
    IN user_id_param BIGINT
)
BEGIN
    DELETE FROM cart
    WHERE user_id = user_id_param ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCategoryById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategoryById`(
    IN p_categoryIdParam INT
)
BEGIN
    -- Delete the category by ID
    DELETE FROM category
    WHERE category_id = p_categoryIdParam;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteOrderById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrderById`(IN orderIdParam BIGINT)
BEGIN
    DECLARE rowsAffected INT;

    -- Attempt to delete the order
    DELETE FROM orders
    WHERE order_id = orderIdParam;

    -- Check the number of rows affected
    SELECT ROW_COUNT() INTO rowsAffected;

    -- If no rows are affected, raise an exception
    IF rowsAffected = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order not found';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProduct`(
    IN p_productSlug VARCHAR(100)
)
BEGIN
    DECLARE productExists INT;

    -- Check if the product exists
    SELECT COUNT(*) INTO productExists
    FROM product
    WHERE slug = p_productSlug;

    -- If the product exists, delete it
    IF productExists > 0 THEN
        DELETE FROM product WHERE slug = p_productSlug;
    ELSE
        -- Return a message indicating that the product does not exist
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Product does not exist';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteProductByQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProductByQuantity`(
    IN product_id_param INT,
    IN quantity_param INT
)
BEGIN
    DECLARE existing_quantity INT;

    -- Get the existing quantity for the specified product
    SELECT quantity INTO existing_quantity
    FROM product
    WHERE product_id = product_id_param;

        -- Calculate the new quantity
        SET existing_quantity = existing_quantity - quantity_param;

        -- Update the existing quantity in the product table
        UPDATE product
        SET quantity = existing_quantity
        WHERE product_id = product_id_param;

        -- If quantity becomes 0, call deleteProduct procedure
        IF existing_quantity = 0 THEN
            CALL DeleteProduct(product_id_param);
        END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeliveryInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeliveryInfo`(
    IN userID_param BIGINT,
    IN city_param VARCHAR(100),
    IN street_param VARCHAR(100),
    IN phoneNumber_param VARCHAR(20),
    IN apartment_param VARCHAR(50)
)
BEGIN
    DECLARE hasDelivery INT;

    -- Check if the user has a delivery record
    SELECT confirm_delivery INTO hasDelivery FROM user WHERE user_id = userID_param;

    IF hasDelivery > 0 THEN
        -- Update the existing delivery record
        UPDATE delivery
        SET
      city = city_param,
            street = street_param,
            phone_number = phoneNumber_param,
            apartment = apartment_param
        WHERE user_id = userID_param;
    ELSE
        -- Insert a new delivery record
        INSERT INTO delivery (user_id, city, street, phone_number, apartment)
        VALUES (userID_param,  city_param, street_param, phoneNumber_param, apartment_param);
    END IF;

    -- Return the delivery records for the user
    SELECT * FROM delivery WHERE user_id = userID_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editCart`(
    IN p_userID BIGINT,
    IN p_productID BIGINT,
    IN p_Quantity INT
)
BEGIN
    -- Update the quantity in the cart
    UPDATE cart
    SET quantity = p_Quantity, total_price = getTotal(p_productID, p_Quantity)
    WHERE user_id = p_userID AND product_id = p_productID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fulfillOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fulfillOrder`(IN orderId INT)
BEGIN
    DECLARE currentFulfilled INT;

    -- Get the current value of the fulfilled column for the specified order ID
    SELECT fulfilled INTO currentFulfilled
    FROM orders
    WHERE order_id = orderId;

    -- Check the current value and update accordingly
    IF currentFulfilled = 0 THEN
        -- If the order is not fulfilled, set it to fulfilled (1)
        UPDATE orders
        SET fulfilled = 1
        WHERE order_id = orderId;
    ELSE
        -- If the order is already fulfilled, raise an error or handle accordingly
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order is already fulfilled';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllOrders`()
BEGIN
    DECLARE orderCount INT;

    -- Get the count of orders
    SELECT COUNT(*) INTO orderCount FROM orders;

    -- If no orders exist, raise an exception
    IF orderCount = 0 THEN
        SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'No orders found';
    ELSE
        -- Retrieve all orders
        SELECT * FROM orders;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllProducts`(IN category_param VARCHAR(50))
BEGIN
    DECLARE productsExist INT;

    -- Check if there are any products
    SELECT COUNT(*) INTO productsExist
    FROM product;

    -- If there are products, retrieve all of them
    IF productsExist > 0 THEN
        SELECT p.name,p.quantity,p.price,p.slug,p.description,c.category_name 
		FROM product p , category c 
		WHERE p.category_id = c.category_id and c.category_name = category_param;
    ELSE
        -- Return a message indicating that there are no products
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'No products found';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCartByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCartByUserId`(
    IN p_userId BIGINT
)
BEGIN
    DECLARE userExists BIGINT;

    -- Check if the user exists
    SELECT COUNT(*) INTO userExists
    FROM user
    WHERE user_id = p_userId;

    -- If the user exists, retrieve cart details
    IF userExists > 0 THEN
        -- Retrieve cart details by user ID
        SELECT c.user_id,c.total_price,c.quantity,p.product_id,p.name,p.price,ca.category_name
		FROM cart c, product p, category ca
		WHERE c.product_id = p.product_id and ca.category_id = p.category_id;
    ELSE
        -- Return a message indicating that the user does not exist
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'User does not exist';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCategoryById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCategoryById`(
    IN p_categoryId INT
)
BEGIN
    DECLARE categoryExist INT;

    -- Check if the category exists
    SELECT COUNT(*) INTO categoryExist
    FROM category
    WHERE category_id = p_categoryId;

    -- If the category doesn't exist, raise an exception
    IF categoryExist = 0 THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Category does not exist';
    ELSE
        -- Retrieve category details by ID
        SELECT *
        FROM category
        WHERE category_id = p_categoryId;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductBySlug` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductBySlug`(
    IN p_productSlug VARCHAR(100)
)
BEGIN
    DECLARE productExists INT;

    -- Check if the product exists
    SELECT COUNT(*) INTO productExists
    FROM product
    WHERE slug = p_productSlug;

    -- If the product exists, retrieve its details
    IF productExists > 0 THEN
        SELECT *
        FROM product
        WHERE slug = p_productSlug;
    ELSE
        -- Return a message indicating that the product does not exist
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Product does not exist';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertDeliveryDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertDeliveryDetails`(IN user_id_param BIGINT, IN location_param VARCHAR(100))
BEGIN
    -- Insert into the delivery table
    INSERT INTO delivery (order_id, location)
    VALUES (user_id_param, location_param);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPaymentDetails`(IN user_id_param BIGINT, IN card_number_param VARCHAR(16), IN expiration_date_param DATE, IN cardholder_name_param VARCHAR(100), IN cvv_param VARCHAR(3))
BEGIN
    -- Insert into the payment table
    INSERT INTO payment (card_number, expiration_date, cardholder_name, cvv, user_id)
    VALUES (card_number_param, expiration_date_param, cardholder_name_param, cvv_param, user_id_param);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PaymentInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PaymentInfo`(
    IN userID_param BIGINT,
    IN cardNumber_param VARCHAR(16),
    IN expDate_param DATE,
    IN cardHolderName_param VARCHAR(100),
    IN cvv_param VARCHAR(3)
)
BEGIN
    DECLARE hasPayment INT;

    -- Check if the user has a payment record
    SELECT confirm_payment INTO hasPayment FROM user WHERE user_id = userID_param;

    IF hasPayment > 0 THEN
        -- Update the existing payment record
        UPDATE payment
        SET card_number = cardNumber_param,
            expiration_date = expDate_param,
            cardholder_name = cardHolderName_param,
            cvv = cvv_param
        WHERE user_id = userID_param;
    ELSE
        -- Insert a new payment record
        INSERT INTO payment (user_id, card_number, expiration_date, cardholder_name, cvv)
        VALUES (userID_param, cardNumber_param, expDate_param, cardHolderName_param, cvv_param);
    END IF;

    -- Return the payment records for the user
    SELECT * FROM payment WHERE user_id = userID_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_user`(
    IN u_fname VARCHAR(45), 
    IN u_lname VARCHAR(45), 
    IN u_username VARCHAR(45), 
    IN u_email VARCHAR(45), 
    IN u_pwd VARCHAR(100), 
    IN u_confirm_pwd VARCHAR(100), 
    IN u_role CHAR(10)
)
BEGIN
    DECLARE email_or_username_already_exist VARCHAR(64);

    -- Check if email or username already exists
    SELECT COALESCE(email, username) INTO email_or_username_already_exist
    FROM user 
    WHERE email = u_email OR username = u_username
    LIMIT 1;

    IF email_or_username_already_exist IS NOT NULL THEN
        SIGNAL SQLSTATE '45007' SET MESSAGE_TEXT = 'This email or username already exists';
    ELSE 
        -- Check if the password and confirm password match
        IF u_pwd <> u_confirm_pwd THEN
            SIGNAL SQLSTATE '45008' SET MESSAGE_TEXT = 'Password and Confirm Password do not match';
        ELSE
            -- Insert into user table if all checks pass
            INSERT INTO user(first_name, last_name, username, email, password, confirm_pwd, role)
            VALUES (u_fname, u_lname, u_username, u_email, u_pwd, u_confirm_pwd, u_role);
        END IF;
    END IF;
    SELECT NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_login`(
    IN u_identifier VARCHAR(45),
    IN u_pwd VARCHAR(100)
)
BEGIN
    DECLARE user_exists INT;
    DECLARE check_pwd_un INT;

    -- Check if the user (email or username) exists
    SELECT COUNT(*) INTO user_exists
    FROM user
    WHERE email = u_identifier OR username = u_identifier;

    IF user_exists = 0 THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Email or username does not exist';
    ELSE
        -- Check if the password is correct
        SELECT COUNT(*) INTO check_pwd_un
        FROM user
        WHERE (email = u_identifier OR username = u_identifier) AND password = u_pwd;

        IF check_pwd_un = 0 THEN
            SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'Incorrect password';
        ELSE
            -- Return the user row
            SELECT *
            FROM user
            WHERE (email = u_identifier OR username = u_identifier);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-19  1:38:59
