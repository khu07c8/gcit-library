CREATE PROCEDURE `delete_branch`(IN branch_id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fail to delete the branch ', branch_id, '.') message;
	END;

	START TRANSACTION;
	DELETE FROM tbl_library_branch WHERE branchId = branch_id;
    SELECT CONCAT('Succeed deleting the branch ', branch_id, '!') message;
    COMMIT;
END