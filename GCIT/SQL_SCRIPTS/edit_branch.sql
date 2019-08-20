DELIMITER $$
CREATE PROCEDURE edit_branch(IN branch_id int,IN new_name VARCHAR(100),IN new_address VARCHAR(100))
BEGIN
	/*Store params as variables*/
	SET @i_d := branch_id;
    SET @n_name := new_name;
    SET @n_address := new_address;

	/*Change branch's name if necessary*/
	IF @n_name != 'N/A'
    THEN
	CALL library.edit_branch_name(@i_d,@n_name);
    END IF;
    /*Change branch's address if necessary*/
    IF @n_address != 'N/A'
	THEN
    CALL library.edit_branch_address(@i_d,@n_address);
    END IF;
END $$