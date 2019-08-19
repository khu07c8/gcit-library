CREATE PROCEDURE `delete_author`(IN author_id INT)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Fail to delete the author.' message;
	END;

	START TRANSACTION;
	DELETE FROM tbl_book_authors WHERE authorId = author_id;
	DELETE FROM tbl_author WHERE authorId = author_id;
    SELECT 'Succeed deleting the author!' message;
	COMMIT;
    
END