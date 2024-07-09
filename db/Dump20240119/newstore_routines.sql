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

-- Dump completed on 2024-01-19  1:38:50
