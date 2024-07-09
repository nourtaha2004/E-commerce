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