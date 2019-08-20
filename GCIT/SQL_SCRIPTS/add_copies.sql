DELIMITER $$

CREATE PROCEDURE add_copies(in increment int, in branch_id int, in book_id int, out msg varchar(100))
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
		set msg = concat('Failed to add', ifnull(concat(' ', increment), ''), ' copies to the book', ifnull(concat(' ', book_id), ''), ' in the branch', ifnull(concat(' ', branch_id), ''), '.');
	end;
    
    update tbl_book_copies 
	set noOfCopies = noOfCopies + increment 
	where bookId = book_id and branchId = branch_id;
	set msg = concat('Successfully added ', increment, ' copies to the book ', book_id, ' in the branch ', branch_id, '!');
END$$
/*BY: KUN HU*/
DELIMITER ;