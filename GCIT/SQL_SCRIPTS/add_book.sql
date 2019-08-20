CREATE DEFINER=`root`@`localhost` PROCEDURE `add_book`(in bId INT, in bName varchar(45), in pId INT, in pName VARCHAR(45),
							in aName VARCHAR(45), in aId INT, in branchId INT, in copies INT,
							out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
    
    -- check that the book with bookId = oldId exists
    IF((SELECT COUNT(bookId)>0 FROM tbl_book WHERE bookId = bId) < 1 ) THEN
		-- check if user entered a new name and update table if neccessary
		IF (bName <> 'n/a' AND bName <> 'N/A' AND aName <> 'n/a' AND aName <> 'N/A'
        AND pName <> 'n/a' AND pName <> 'N/A') THEN
			INSERT INTO tbl_publisher(publisherId, publisherName) VALUES (pId, pName);
            IF NOT EXISTS (SELECT 1 FROM tbl_author WHERE authorId = aId) THEN
				INSERT INTO tbl_author VALUES (aId, aName);
            END IF;
            INSERT INTO tbl_book VALUES (bId, bName, pId);
			INSERT INTO tbl_book_authors VALUES(bId, aId);
			INSERT INTO tbl_book_copies VALUES(bId, branchId, copies);
            SELECT 'Book successfully added in the table' INTO mssg;  
		ELSE
			SELECT 'Publishher/Author already exists in the table' INTO mssg;    
			END IF;
	ELSE
		SELECT 'Book already exists in the table' INTO mssg; 
	END IF;
    
		COMMIT;
END