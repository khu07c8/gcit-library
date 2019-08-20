DROP PROCEDURE IF EXISTS update_author;

-- -------------------------------------------------------------

-- update author procedure

-- -------------------------------------------------------------
delimiter $$
CREATE PROCEDURE  update_author(in oldId int, in newId int, in aName varchar(45), 
										out exitCode int, out mssg varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 1 INTO exitCode;
        SELECT 'SQLException encountered. Procedure cancelled.' INTO mssg;
	END;
    
    -- check that the author with authorId = oldId exists
    IF EXISTS (SELECT 1 FROM tbl_author WHERE authorId = oldId) THEN
		-- check if user entered a new name and update table if neccessary
		IF (aName <> 'n/a' AND aName <> 'N/A') THEN
			UPDATE tbl_author SET authorName = aName WHERE authorId = oldId;
		END IF;
		
        -- check if user entered a new id and update table if neccessary
		IF (newId <> 'n/a' AND newId <> 'N/A') THEN
			IF EXISTS (SELECT 1 FROM tbl_author WHERE authorId = newId) THEN -- checks if new Id exists in table
				UPDATE tbl_author SET authorId = newId WHERE authorId = oldId;
			ELSE
				ROLLBACK;
				SELECT 1 INTO exitCode;
				SELECT 'Author ID already exists in table.' INTO mssg;
			END IF;
		END IF;
		
		SELECT 0 INTO exitCode;
		SELECT 'Author updated successfully.' INTO mssg;
		
		COMMIT;
	ELSE
		SELECT 1 INTO exitCode;
		SELECT 'Author ID does not exist in table.' INTO mssg;
	END IF;
    
END $$
/*BY: Chris Cooper*/
DELIMITER ;