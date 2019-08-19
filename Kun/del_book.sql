CREATE PROCEDURE `delete_book`(IN book_id INT)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to delete the book ', book_id, '.') message;
	END;

	START TRANSACTION;
	-- delete rows in relation tables whose foreign keys are with "restrict" first.
    DELETE FROM tbl_book_genres WHERE bookId = book_id;
	DELETE FROM tbl_book_authors WHERE bookId = book_id;
	DELETE FROM tbl_book WHERE bookId = book_id;
    SELECT CONCAT('Succeed deleting the book ', book_id, '!') message;
	COMMIT;
    
END