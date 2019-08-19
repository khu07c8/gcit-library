DROP PROCEDURE IF EXISTS update_author;
DROP PROCEDURE IF EXISTS update_publisher;
DROP PROCEDURE IF EXISTS update_borrower;
DROP PROCEDURE IF EXISTS update_genre;
DROP PROCEDURE IF EXISTS update_book;
DROP PROCEDURE IF EXISTS return_book;
DROP PROCEDURE IF EXISTS override_return_date;
DROP PROCEDURE IF EXISTS override_due_date;
DROP PROCEDURE IF EXISTS override_out_date;


-- -------------------------------------------------------------

-- update author procedure

-- -------------------------------------------------------------
delimiter $$
CREATE PROCEDURE  update_author(in oldId int, in newId varchar(11), in aName varchar(45), 
										out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
	
    SELECT * FROM tbl_author WHERE authorId = oldId FOR UPDATE;
	
    SELECT 0 INTO exitCode;
    
    -- check that the author with authorId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_author WHERE authorId = oldId) THEN
		-- check if user entered a new name and update table if neccessary
		IF (aName <> 'n/a' AND aName <> 'N/A') THEN
			UPDATE tbl_author SET authorName = aName WHERE authorId = oldId;
		END IF;
		
        -- check if user entered a new id and update table if neccessary
		IF (newId <> 'n/a' AND newId <> 'N/A') THEN
			IF NOT EXISTS (SELECT 1 FROM tbl_author WHERE authorId = newId) THEN -- checks if new Id exists in table
				UPDATE tbl_author SET authorId = newId WHERE authorId = oldId;
			ELSE
				ROLLBACK;
				SELECT 1 INTO exitCode;
				SELECT 'Author ID already exists in table.' INTO mssg;
			END IF;
		END IF;
		
        IF exitCode <> 1 THEN
			SELECT 'Author updated successfully.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Author ID does not exist in table.' INTO mssg;
	END IF;
    
END $$

-- -------------------------------------------------------------

-- update publisher procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  update_publisher(in oldId int, in newId varchar(11), 
									in newName varchar(45), in newAddr varchar(45), in newPhone varchar(45),
									out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
    
	SELECT * FROM tbl_publisher WHERE publisherId = oldId FOR UPDATE;
        
    -- check that the publisher with publisherId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_publisher WHERE publisherId = oldId) THEN
		-- check if user entered a new name and update table if neccessary
		IF (newName <> 'n/a' AND newName <> 'N/A') THEN
			UPDATE tbl_publisher SET publisherName = newName WHERE publisherId = oldId;
		END IF;
        
        -- check if user entered a new address and update table if neccessary
		IF (newAddr <> 'n/a' AND newAddr <> 'N/A') THEN
			UPDATE tbl_publisher SET publisherAddress = newAddr WHERE publisherId = oldId;
		END IF;
        
        -- check if user entered a new phone number and update table if neccessary
		IF (newPhone <> 'n/a' AND newPhone <> 'N/A') THEN
			UPDATE tbl_publisher SET publisherPhone = newPhone WHERE publisherId = oldId;
		END IF;
		
        -- check if user entered a new id and update table if neccessary
		IF (newId <> 'n/a' AND newId <> 'N/A') THEN
			IF NOT EXISTS (SELECT 1 FROM tbl_publisher WHERE publisherId = newId) THEN -- checks if new Id exists in table
				UPDATE tbl_publisher SET publisherId = newId WHERE publisherId = oldId;
			ELSE
				ROLLBACK;
				SELECT 1 INTO exitCode;
				SELECT 'Publisher ID already exists in table.' INTO mssg;
			END IF;
		END IF;
		
        IF exitCode <> 1 THEN
			SELECT 'Publisher updated successfully.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Publisher ID does not exist in table.' INTO mssg;
	END IF;
    
END $$

-- -------------------------------------------------------------

-- update borrower procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  update_borrower(in oldCardNo int, in newCardNo varchar(11), in newName varchar(45), 
									in newAddr varchar(45), in newPhone varchar(45), 
										out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
	
    SELECT * FROM tbl_borrower WHERE cardNo = oldCardNo FOR UPDATE;

    -- check that the borrower cardNo = oldCardNo exists
    IF EXISTS (SELECT 1 FROM tbl_borrower WHERE cardNo = oldCardNo) THEN
		-- check if user entered a new name and update table if neccessary
		IF (newName <> 'n/a' AND newName <> 'N/A') THEN
			UPDATE tbl_borrower SET name = newName WHERE cardNo = oldCardNo;
		END IF;
		
        -- check if user entered a new address and update table if neccessary
		IF (newAddr <> 'n/a' AND newAddr <> 'N/A') THEN
			UPDATE tbl_borrower SET address = newAddr WHERE cardNo = oldCardNo;
		END IF;
        
        -- check if user entered a new phone number and update table if neccessary
		IF (newPhone <> 'n/a' AND newPhone <> 'N/A') THEN
			UPDATE tbl_borrower SET phone = newPhone WHERE cardNo = oldCardNo;
		END IF;
        
        -- check if user entered a new card number and update table if neccessary
		IF (newCardNo <> 'n/a' AND newCardNo <> 'N/A') THEN
			IF NOT EXISTS (SELECT 1 FROM tbl_borrower WHERE cardNo = newCardNo) THEN -- checks if new Id exists in table
				UPDATE tbl_borrower SET cardNo = newCardNo WHERE cardNo = oldCardNo;
			ELSE
				ROLLBACK;
				SELECT 1 INTO exitCode;
				SELECT 'Card Number already exists in table.' INTO mssg;
			END IF;
		END IF;
		
        IF exitCode <> 1 THEN
			SELECT 'Borrower updated successfully.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Card No does not exist in table.' INTO mssg;
	END IF;
    
END $$

-- -------------------------------------------------------------

-- update genre procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  update_genre(in oldId int, in newName varchar(45), 
										out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
	
	SELECT * FROM tbl_genre WHERE genre_id = oldId FOR UPDATE;
        
	-- check that the genre with genre_id = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_genre WHERE genre_id = oldId) THEN
		-- check if user entered a new name and update table if neccessary
		IF (newName <> 'n/a' AND newName <> 'N/A') THEN
			UPDATE tbl_genre SET genre_name = newName WHERE genre_id = oldId;
		END IF;
		
        IF exitCode <> 1 THEN
			SELECT 'Genre updated successfully.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Genre ID does not exist in table.' INTO mssg;
	END IF;
    
END $$

-- ------------------------------------------------------------------------

-- Update Book Procedure

-- ------------------------------------------------------------------------
CREATE PROCEDURE  update_book(in oldId int, in bTitle varchar(45), in bPubId varchar(11), 
						in newGenre varchar(11), in oldGenre varchar(11), in remG int,
                        in newAuth varchar(11), in oldAuth varchar(11), in remA int,
						out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
    
    SELECT * FROM tbl_book WHERE bookId = oldId FOR UPDATE;
    SELECT * FROM tbl_book_genres WHERE bookId = oldId FOR UPDATE;
    SELECT * FROM tbl_book_authors WHERE bookId = oldId FOR UPDATE;
    
    -- check that the book with bookId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_book WHERE bookId = oldId) THEN
		-- check if user entered a new title and update table if neccessary
		IF (bTitle <> 'n/a' AND bTitle <> 'N/A') THEN
			UPDATE tbl_book SET title = bTitle WHERE bookId = oldId;
		END IF;
		
        -- check if user added a new publisher id and update table if neccessary
		IF (bPubId <> 'n/a' AND bPubId <> 'N/A') THEN
			-- if publisher exists, update the book table, else send error and rollback
			IF EXISTS (SELECT 1 FROM tbl_publisher WHERE publisherId = bPubId) THEN
				UPDATE tbl_book SET pubId = bPubId WHERE bookId = oldId;
			ELSE
				ROLLBACK;
				SELECT 1 INTO exitCode;
				SELECT 'Selected publisher ID does not exist in table. Please add new publisher.' INTO mssg;
			END IF;
		END IF;
        
        -- check if user intended to remove genre
        IF (remG = 0) THEN
			 -- check if user entered a new genre and update book_genres table if neccessary
			IF (newGenre <> 'n/a' AND newGenre <> 'N/A') THEN
				-- check if user wanted to add new author to book
				-- IF (newGFunc = 1) THEN
					-- IF EXISTS (SELECT 1 FROM tbl_genre WHERE genre_id = newGenre) THEN	-- check that genre exists
						-- INSERT INTO tbl_book_genres (genre_id,bookId) VALUES (newGenre,oldId);
					-- ELSE
						-- ROLLBACK;
						-- SELECT 1 INTO exitCode;
						-- SELECT 'Selected genre ID does not exist in table. Please add new genre.' INTO mssg;
					-- END IF;
				-- END IF;
				IF EXISTS (SELECT 1 FROM tbl_genre WHERE genre_id = newGenre) THEN	-- check that genre exists
					-- check that book has entry in tbl_book_genres
					-- if it does update that entry
					-- else insert
					IF EXISTS (SELECT 1 FROM tbl_book_genres WHERE bookId = oldId AND genre_id = oldGenre) THEN
						UPDATE tbl_book_genres SET genre_id = newGenre WHERE bookId = oldId AND genre_id = oldGenre;
					ELSE
						INSERT INTO tbl_book_genres (genre_id,bookId) VALUES (newGenre,oldId);
					END IF;
				ELSE
					ROLLBACK;
					SELECT 1 INTO exitCode;
					SELECT 'Selected genre ID does not exist in table. Please add new genre.' INTO mssg;
				END IF;
			END IF;
        ELSE
			DELETE FROM tbl_book_genres WHERE bookId = oldId AND genre_id = oldGenre;
        END IF;
  
		-- check if user intended to remove author
        IF (remA = 0) THEN
			-- check if user entered a new author and update book_authors table if neccessary
			IF (newAuth <> 'n/a' AND newAuth <> 'N/A') THEN
				IF EXISTS (SELECT 1 FROM tbl_author WHERE authorId = newAuth) THEN	-- check that author exists
					-- check that book has entry in tbl_book_authors
					-- if it does update that entry
					-- else insert
					IF EXISTS (SELECT 1 FROM tbl_book_authors WHERE bookId = oldId AND authorId = oldAuth) THEN
						UPDATE tbl_book_authors SET authorId = newAuth WHERE bookId = oldId AND authorId = oldAuth;
					ELSE
						INSERT INTO tbl_book_authors (bookId,authorId) VALUES (oldId,newAuth);
					END IF;
				ELSE
					ROLLBACK;
					SELECT 1 INTO exitCode;
					SELECT 'Selected author ID does not exist in table. Please add new author.' INTO mssg;
				END IF;
			END IF;
        ELSE
			DELETE FROM tbl_book_authors WHERE bookId = oldId AND authorId = oldAuth;
        END IF;
        
        IF exitCode <> 1 THEN
			SELECT 'Book updated successfully.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Book ID does not exist in table.' INTO mssg;
	END IF;
    
END $$

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
		WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND returnDate IS NULL)
        THEN
        
        -- select only one copy of the book to return if there are multiple
        SELECT dateOut INTO firstOut FROM tbl_book_loans
			WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND returnDate IS NULL
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
            AND dateOut = firstOut AND returnDate IS NULL)) 
			INTO pastDue;
		
        -- set the return date
		UPDATE tbl_book_loans SET returnDate = inReturnDate, returned = 1
			WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo 
            AND dateOut = firstOut AND returnDate IS NULL;
		
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

-- -------------------------------------------------------------

-- override return date procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  override_return_date(in inBookId int, in inBranchId int, in inCardNo int, in inDateOut datetime,
									in newReturnDate datetime, out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
        
    -- check that the author with authorId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_book_loans 
	WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut) THEN
		-- update table with new due date
		UPDATE tbl_book_loans SET returnDate = newReturnDate
		WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut;
		
        IF exitCode <> 1 THEN
			SELECT 'Return date over-ride successful.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Book loan not found in table.' INTO mssg;
	END IF;
    
END $$

-- -------------------------------------------------------------

-- override due date procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  override_due_date(in inBookId int, in inBranchId int, in inCardNo int, in inDateOut datetime,
									in newDueDate datetime, out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
        
    -- check that the author with authorId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_book_loans 
	WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut) THEN
		-- update table with new due date
		UPDATE tbl_book_loans SET dueDate = newDueDate
		WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut;
		
        IF exitCode <> 1 THEN
			SELECT 'Due date over-ride successful.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Book loan not found in table.' INTO mssg;
	END IF;
    
END $$

-- -------------------------------------------------------------

-- override out date procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  override_out_date(in inBookId int, in inBranchId int, in inCardNo int, in inDateOut datetime,
									in newOutDate datetime, out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
        
	SELECT 0 INTO exitCode;
        
    -- check that the author with authorId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_book_loans 
	WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut) THEN
		-- update table with new due date
		UPDATE tbl_book_loans SET dateOut = newOutDate
		WHERE bookId = inBookId AND branchId = inBranchId AND cardNo = inCardNo AND dateOut = inDateOut;
		
        IF exitCode <> 1 THEN
			SELECT 'Out date over-ride successful.' INTO mssg;
        END IF;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Book loan not found in table.' INTO mssg;
	END IF;
    
END $$

delimiter ;