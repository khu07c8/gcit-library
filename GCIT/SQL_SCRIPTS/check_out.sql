DELIMITER $$
CREATE PROCEDURE check_out(IN book_id INT(11), IN branch_id INT(11), IN card_id INT(11)) 
BEGIN

	/*Handle any exceptions*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Error Occured. Procedure canceled..' AS 'Error';
	END;

	START TRANSACTION;
	-- Check book's availability
	IF number_available(book_id, branch_id) > 0 THEN
	
		-- Retrieve chosen book
		UPDATE tbl_book_copies
		SET tbl_book_copies.noOfCopies = number_available(book_id, branch_id) - 1
		WHERE tbl_book_copies.bookId=book_id
		AND 
		tbl_book_copies.branchId=branch_id;

		-- Then add entry into book_loans, date out should be today’s date, due date should be one week from today’s date.
		INSERT INTO tbl_book_loans(bookId, branchId, cardNo, dateOut, dueDate)
		VALUES(book_id, branch_id, card_id, DATE(CURDATE()), ADDDATE(DATE(CURDATE()), INTERVAL 7 DAY));
        
	COMMIT;
	ELSE
			SELECT 'NOT AVAILABLE' AS msg;
	END IF;
    
END $$
DELIMITER ;

-- Confirm