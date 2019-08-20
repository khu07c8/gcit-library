DELIMITER $$

CREATE  PROCEDURE edit_branch_address(IN branch_id int, IN new_address VARCHAR(75))
BEGIN
	UPDATE tbl_library_branch
	SET tbl_library_branch.branchAddress = new_address
	WHERE tbl_library_branch.branchId = branch_id;
END $$