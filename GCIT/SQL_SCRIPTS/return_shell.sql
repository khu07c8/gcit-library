DELIMITER $$
CREATE PROCEDURE return_shell(IN book_id INT, IN branch_id INT, IN card_num INT)
BEGIN

	SET @penalty := 0.0;
    SET @exit_code := 0;
    SET @msg := '';
    
    
    
	CALL return_book(book_id, branch_id, card_num, CURDATE(), @penalty, @exit_code, @msg);
    IF @exit_code = 1 THEN
		SELECT @msg AS msg;
	ELSEIF @penalty > 0.0 THEN
		SELECT concat('Unfortunately, you owe ', @penalty, ' for this late return..') AS msg;
	ELSE
        SELECT 'Thank you.. Let\'s do this again sometime.';
	END IF;
    
END $$
DELIMITER ;