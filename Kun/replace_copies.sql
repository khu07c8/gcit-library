CREATE PROCEDURE `replace_copies`(IN copy_num INT, IN branch_id INT, IN book_id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to add ', increment, ' copies to the book ', book_id, ' in the branch ', branch_id, '.') message;
	END;
    
    START TRANSACTION;
    UPDATE tbl_book_copies 
	SET noOfCopies = copy_num 
	WHERE bookId = book_id AND branchId = branch_id;
	SELECT CONCAT('Succeed adding ', increment, ' copies to the book ', book_id, ' in the branch ', branch_id, '!') message;
	COMMIT;
END