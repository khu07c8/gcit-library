CREATE PROCEDURE `delete_publisher`(IN publisher_id INT)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to delete the publisher ', publisher_id, '.') message;
	END;

    START TRANSACTION;
    -- delete rows in relation tables whose foreign keys are with "restrict" first.
    DELETE FROM tbl_book_genres bg WHERE EXISTS (SELECT * FROM tbl_book b WHERE bg.bookId = b.bookId AND b.pubId = publisher_id);
	DELETE FROM tbl_book_authors ba WHERE EXISTS (SELECT * FROM tbl_book b WHERE ba.bookId = b.bookId AND b.pubId = publisher_id);
	DELETE FROM tbl_publisher WHERE publisherId = publisher_id;
	COMMIT;
    SELECT CONCAT('Succeed deleting the publisher ', publisher_id, '!') message;
END