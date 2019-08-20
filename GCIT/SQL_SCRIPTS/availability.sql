DELIMITER $$
CREATE FUNCTION number_available(book_id INT, branch_id INT) RETURNS INT(11) 
    DETERMINISTIC
BEGIN

	-- Availability will return a byte(tinyint) with the number of books available
	SET @available := (
    	-- Find number of copies based on book's ID
		SELECT noOfCopies 'Available'
		FROM tbl_book_copies
		WHERE tbl_book_copies.bookId=book_id
        AND
        tbl_book_copies.branchId=branch_id
	);
    RETURN @available;
END $$
DELIMITER ;