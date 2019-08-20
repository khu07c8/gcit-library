DELIMITER $$
CREATE PROCEDURE delete_branch(in branch_id int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		select concat('Failed to delete the branch ', branch_id, '.') AS msg;
	END;

	delete from tbl_library_branch where branchId = branch_id;
    
    select concat('Successfully deleted branch ', branch_id, '!') AS msg;
END $$