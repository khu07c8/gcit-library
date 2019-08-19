CREATE PROCEDURE `show_books`(IN branch_id INT, IN all_books BOOL)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Fail to find books.';
	END;

	START TRANSACTION;
	IF all_books = 1 THEN 
		SELECT b.title 
		FROM tbl_book b 
		WHERE EXISTS (
			SELECT * 
			FROM tbl_book_copies c 
			WHERE c.branchId = branch_id AND b.bookId = c.bookId
		);
		SELECT 'Succeed finding all books!';
	ELSE 
		SELECT b.title 
		FROM tbl_book b 
		WHERE EXISTS (
			SELECT * 
			FROM tbl_book_copies c 
			WHERE c.branchId = branch_id AND c.noOfCopies > 0 AND b.bookId = c.bookId
		);
        SELECT 'Succeed finding all available books!';
	END IF;
	COMMIT;
END