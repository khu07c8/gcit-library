DELIMITER $$
CREATE PROCEDURE replace_copies(in copy_num int, in branch_id int, in book_id int)
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
		select @error := concat('Failed to update book ', book_id, ' in branch ', branch_id) AS msg;
	end;
    
    update tbl_book_copies 
	set noOfCopies = copy_num 
	where bookId = book_id and branchId = branch_id;
	select @msg := concat('Updated ', book_id, ' to ', copy_num, ' in branch ', branch_id, '!') AS msg;
    
END $$