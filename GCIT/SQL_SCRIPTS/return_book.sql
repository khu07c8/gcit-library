DROP PROCEDURE IF EXISTS return_book;

delimiter $$
-- ------------------------------------------------

-- return_book procedure

-- ------------------------------------------------

CREATE PROCEDURE return_book( in inBookId int, in inBranchId int, in inCardNo int, in inReturnDate datetime, 
								out penalty float, out exitCode int, out mssg varchar(50) )
BEGIN
	
	-- get when book was due
    declare pastDue int;
    declare firstOut datetime;
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
        
    -- determine if there is a book to return
    IF EXISTS (SELECT 1 FROM tbl_book_loans
		WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND returnedDate IS NULL)
        THEN
        
        -- select only one copy of the book to return if there are multiple
        SELECT dateOut INTO firstOut FROM tbl_book_loans
			WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND returnedDate IS NULL
            LIMIT 1;
	    
		-- Prevent updates from other users
		SELECT noOfCopies FROM tbl_book_copies 
			WHERE bookId = inBookId AND branchId = inBranchId
			FOR UPDATE;
		
        -- increment number of copies
        UPDATE tbl_book_copies SET noOfCopies = noOfCopies + 1 
			WHERE bookId = inBookId AND branchId = inBranchId;
			
		-- get number of days past due
		SELECT DATEDIFF(inReturnDate,(SELECT dueDate FROM tbl_book_loans
			WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo 
            AND dateOut = firstOut AND returnedDate IS NULL)) 
			INTO pastDue;
		
        -- set the return date
		UPDATE tbl_book_loans SET returnedDate = inReturnDate
			WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo 
            AND dateOut = firstOut AND returnedDate IS NULL;
		
        -- multiply penalty and return
		IF pastDue > 0 THEN
			SELECT pastDue*0.25 INTO penalty;
		ELSE
			SELECT 0 INTO penalty;
		END IF;
                
		IF exitCode <> 1 THEN
			SELECT 'Book returned successfully.' INTO mssg;
        END IF;
        
        COMMIT;	
        
	ELSE
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'You do not have this book checked out.' INTO mssg;
    END IF;
    
END $$

delimiter ;