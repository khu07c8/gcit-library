DELIMITER $$
CREATE PROCEDURE delete_borrower(in card_no int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		select concat('Failed to delete the borrower with card no. ', card_no, '.') AS msg;
	END;

	delete from tbl_borrower where cardNo = card_no;
    
    select concat('Successfully deleted the borrower with card no. ', card_no, '!') AS msg;
END $$
DELIMITER ;