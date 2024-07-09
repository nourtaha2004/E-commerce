CREATE DEFINER=`root`@`localhost` PROCEDURE `addToCart`(IN userID BIGINT, IN bookID BIGINT, IN bookQty INT)
BEGIN
    DECLARE countRecords INT;
    DECLARE oldQuantity INT;
    DECLARE newQuantity INT;
    DECLARE totalPrice INT;

    SELECT COUNT(*) INTO countRecords FROM cart WHERE user_id = userID AND book_id = bookID;
    SELECT quantity INTO oldQuantity FROM cart WHERE user_id = userID AND book_id = bookID;

    IF countRecords > 0 THEN
		SET newQuantity = bookQty + oldQuantity;
        UPDATE cart SET quantity = newQuantity WHERE user_id = userID AND book_id = bookID;
        SELECT getTotalPrice(bookID, newQuantity) INTO totalPrice; -- Store result in totalPrice
        UPDATE cart SET total_price = totalPrice WHERE user_id = userID AND book_id = bookID;
    ELSE
		SELECT getTotalPrice(bookID, bookQty) INTO totalPrice; -- Store result in totalPrice
        INSERT INTO cart (user_id, book_id, total_price, quantity) VALUES (userID, bookID, totalPrice, bookQty);
    END IF;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `createOrder`(IN p_userID BIGINT)
BEGIN
  DECLARE userIdCart BIGINT;
  DECLARE bookIdCart BIGINT;
  DECLARE totalPriceCart INT;
  DECLARE quantityCart INT;
  DECLARE orderID INT;
  DECLARE priceSum INT;
  DECLARE checkBookQuantity INT;
  DECLARE newQuantity INT;
  DECLARE finished INT DEFAULT 0;
  DECLARE bookTitle VARCHAR(255); -- assuming book title is stored in a field in the book table
  DECLARE errorMessage VARCHAR(255);
  -- Declare a cursor to fetch cart data for the user
  DECLARE cur CURSOR FOR
    SELECT user_id, book_id, total_price, quantity FROM cart WHERE user_id = p_userID;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

  SET priceSum = 0;

  -- Check if there are items in the cart for the user
  SELECT COUNT(*) INTO @cartItemCount FROM cart WHERE user_id = p_userID;

  IF @cartItemCount > 0 THEN
    INSERT INTO orders (user_id, total_price, fulfilled, order_date) VALUES (p_userID, 0, 0, NOW());
    SET orderID = LAST_INSERT_ID();

    OPEN cur;

    cart_loop: LOOP
      FETCH cur INTO userIdCart, bookIdCart, totalPriceCart, quantityCart;

      IF finished = 1 THEN
        LEAVE cart_loop;
      END IF;

      -- Start transaction
      START TRANSACTION;

      -- Check if the quantity available for the book
      SELECT quantity, title INTO checkBookQuantity, bookTitle FROM book WHERE book_id = bookIdCart;

      IF checkBookQuantity >= quantityCart THEN
        -- Sum up total price
        SET priceSum = priceSum + totalPriceCart;

        -- Add order details to order_details table
        INSERT INTO order_details (order_id, book_id, quantity, order_date, fulfilled)
        VALUES (orderID, bookIdCart, quantityCart, NOW(), 0);
        
        -- Update the book quantity in books
        SET newQuantity = checkBookQuantity - quantityCart;
        UPDATE book SET quantity = newQuantity WHERE book_id = bookIdCart;
        
        -- Delete cart item
        DELETE FROM cart WHERE user_id = p_userID and book_id = bookIdCart;

        -- Commit the transaction
        COMMIT;
      ELSE
        -- Rollback and throw an error if quantity not available
     
		SET errorMessage = CONCAT('Insufficient quantity available for book ', bookTitle, ' in the cart.');
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
        ROLLBACK;
      END IF;
    END LOOP cart_loop;

    CLOSE cur;
    -- Update total price in orders table after the loop completes
    UPDATE orders SET total_price = priceSum WHERE order_id = orderID;
  END IF;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `editCart`(IN userID BIGINT, IN bookID BIGINT, IN newQty INT)
BEGIN
    DECLARE oldQuantity INT;
    DECLARE totalPrice INT;

    SELECT quantity INTO oldQuantity FROM cart WHERE user_id = userID AND book_id = bookID;
    
        UPDATE cart SET quantity = newQty WHERE user_id = userID AND book_id = bookID;
        SELECT getTotalPrice(bookID, newQty) INTO totalPrice; -- Store result in totalPrice
        UPDATE cart SET total_price = totalPrice WHERE user_id = userID AND book_id = bookID;
END

CREATE DEFINER=`root`@`localhost` FUNCTION `getTotalPrice`(bookID BIGINT, qty INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE bookPrice INT;

    SELECT price INTO bookPrice
    FROM book
    WHERE book_id = bookID;

    RETURN bookPrice * qty;
END


CREATE DEFINER=`root`@`localhost` FUNCTION `slugify`(title VARCHAR(100)) RETURNS varchar(120) CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
BEGIN
    DECLARE chars_to_replace VARCHAR(50);
    DECLARE replacement_char CHAR(1);
    DECLARE slug VARCHAR(120);

    SET chars_to_replace = ' /:@&()';
    SET replacement_char = '-';
    
    -- Replace chars_to_replace with replacement_char
    SET slug = LOWER(title);
    SET slug = REPLACE(slug, ' ', replacement_char);
    SET slug = REPLACE(slug, '/', replacement_char);
    SET slug = REPLACE(slug, ':', replacement_char);
    SET slug = REPLACE(slug, '@', replacement_char);
    SET slug = REPLACE(slug, '&', replacement_char);
    SET slug = REPLACE(slug, '(', replacement_char);
    SET slug = REPLACE(slug, ')', replacement_char);

    RETURN slug;
END