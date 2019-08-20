DELIMITER $$
CREATE PROCEDURE delete_author(in author_id int)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		select 'Failed to delete the author.' AS msg;
	END;

	start transaction;
	delete from tbl_book_authors where authorId = author_id;
	delete from tbl_author where authorId = author_id;
	commit;
    
    select 'Successfully deleted the author!' AS msg;

END $$
DELIMITER ;