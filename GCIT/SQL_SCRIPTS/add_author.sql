DROP PROCEDURE IF EXISTS add_author;
DROP PROCEDURE IF EXISTS add_publisher;

-- -------------------------------------------------------------

-- add author procedure

-- -------------------------------------------------------------
delimiter $$
CREATE PROCEDURE  add_author(in aId INT, in aName varchar(45), out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
    
    -- check that the book with bookId = oldId exists
    IF((SELECT COUNT(authorId)>0 FROM tbl_author WHERE authorId = aId) < 1 ) THEN
		INSERT INTO tbl_author VALUES (aId, aName);
		SELECT 'Author successfully added in the table' INTO mssg;  
	ELSE
		SELECT 'Author already exists in the table' INTO mssg;    
	END IF;

	COMMIT;
END $$


-- -------------------------------------------------------------

-- add publisher procedure

-- -------------------------------------------------------------
CREATE PROCEDURE  add_publisher(in pId INT, in pName varchar(45), in pAddress varchar(45), in pPhone varchar(45),
								out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
    
    -- check that the book with bookId = oldId exists
    IF((SELECT COUNT(publisherId)>0 FROM tbl_publisher WHERE publisherId = pId) < 1 ) THEN
		INSERT INTO tbl_publisher (publisherId,publisherName) VALUES (pId, pName);

        IF (pAddress <> 'n/a' AND pAddress <> 'N/A') THEN
			UPDATE tbl_publisher SET publisherAddress = pAddress WHERE publisherId = pId;
		END IF;
        IF (pPhone <> 'n/a' AND pPhone <> 'N/A') THEN
			UPDATE tbl_publisher SET publisherPhone = pPhone WHERE publisherId = pId;
		END IF;
        
		SELECT 'Publisher successfully added in the table' INTO mssg;

	ELSE
		SELECT 'Publisher already exists in the table' INTO mssg;    
	END IF;

	COMMIT;
END $$
DELIMITER ;