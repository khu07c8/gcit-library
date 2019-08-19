CREATE PROCEDURE `borrow_book`(IN book_id INT, IN branch_id INT, IN card_no INT)
BEGIN

	DECLARE affected_rows INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Fail to process your borrowing.' message;
	END;

	START TRANSACTION;
	UPDATE tbl_book_copies SET noOfCopies = noOfCopies - 1 WHERE noOfCopies > 0 AND bookId = book_id AND branchId = branch_id;
	SELECT ROW_COUNT() INTO affected_rows;
    IF affected_rows > 0 THEN 
        INSERT INTO tbl_book_loans VALUES (book_id, branch_id, card_no, UTC_TIMESTAMP(), date_add(UTC_TIMESTAMP(), INTERVAL 1 WEEK));
		SELECT CONCAT('Succeed borrowing the book ', book_id, ' in the branch ', branch_id, '!') message;
	ELSE 
		SELECT CONCAT('No available book ', book_id, ' in the branch ', branch_id, '.') message;
	END IF;
	COMMIT;

END