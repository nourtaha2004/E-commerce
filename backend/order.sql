DELIMITER //

CREATE PROCEDURE createOrder (IN p_userID BIGINT)
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
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = CONCAT('Insufficient quantity available for book ', bookTitle, ' in the cart.');
        ROLLBACK;
      END IF;
    END LOOP cart_loop;

    CLOSE cur;
    -- Update total price in orders table after the loop completes
    UPDATE orders SET total_price = priceSum WHERE order_id = orderID;
  END IF;
END//

DELIMITER ;
