DELIMITER $$
CREATE PROCEDURE edit_branch_name(IN branch_id int, IN new_name VARCHAR(75))
BEGIN
	UPDATE tbl_library_branch
	SET tbl_library_branch.branchName = new_name
	WHERE tbl_library_branch.branchId = branch_id;
END$$
DELIMITER $$