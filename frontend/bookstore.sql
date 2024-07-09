DELIMITER //
CREATE PROCEDURE addToCart (IN userID BIGINT, IN bookID BIGINT, IN bookQty INT)
BEGIN
    DECLARE countRecords INT;
    DECLARE oldQuantity INT;

    SELECT COUNT(*) INTO countRecords FROM cart WHERE user_id = userID AND book_id = bookID;
    SELECT quantity INTO oldQuantity FROM cart WHERE user_id = userID AND book_id = bookID;

    IF countRecords > 0 THEN
        UPDATE cart SET quantity = bookQty + oldQuantity WHERE user_id = userID AND book_id = bookID;
    ELSE
        INSERT INTO cart (user_id, book_id, quantity) VALUES (userID, bookID, bookQty);
    END IF;
END //
DELIMITER ;

CREATE FUNCTION getTotalPrice (@bookID BIGINT, @qty INT)
RETURNS INT
AS
BEGIN
    DECLARE @bookPrice INT;

    SELECT price INTO @bookPrice
    FROM book
    WHERE book_id = bookID

    RETURN price * @qty
END


CREATE TRIGGER UpdateSlugBook
ON book
AFTER INSERT
AS
BEGIN
    DECLARE bookID BIGINT;
    DECLARE bookTitle VARCHAR(100);
    DECLARE bookSlug VARCHAR(120);

    SELECT title INTO bookTitle FROM inserted;
    SELECT book_id INTO bookID FROM inserted;

    SET bookSlug = slugify(bookTitle);

    UPDATE book
    SET slug = bookSlug
    WHERE book_id = bookID;
END