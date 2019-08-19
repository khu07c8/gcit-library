CREATE PROCEDURE `delete_borrower`(IN card_no INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to delete the borrower with card ', card_no, '.') message;
	END;

	START TRANSACTION;
	DELETE FROM tbl_borrower WHERE cardNo = card_no;
    SELECT CONCAT('Succeed deleting the borrower with card ', card_no, '!') message;
    COMMIT;
END