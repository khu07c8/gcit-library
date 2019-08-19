CREATE PROCEDURE `add_copies`(IN increment INT, IN branch_id INT, IN book_id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to add ', increment, ' copies to the book ', book_id, ' in the branch ', branch_id, '.') message;
	END;
    
    START TRANSACTION;
    UPDATE tbl_book_copies 
	SET noOfCopies = noOfCopies + increment 
	WHERE bookId = book_id AND branchId = branch_id;
	SELECT CONCAT('Succeed adding ', increment, ' copies to the book ', book_id, ' in the branch ', branch_id, '!') message;
	COMMIT;
END