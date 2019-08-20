DELIMITER $$
CREATE PROCEDURE delete_book(in book_id int)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		select concat('Failed to delete book ', book_id, '.') AS msg;
	END;

	start transaction;
    delete from tbl_book_genres where bookId = book_id;
	delete from tbl_book_authors where bookId = book_id;
	delete from tbl_book where bookId = book_id;
	commit;
    
    select concat('Successfully deleted book ', book_id, '!') AS msg;

END $$
DELIMITER ;