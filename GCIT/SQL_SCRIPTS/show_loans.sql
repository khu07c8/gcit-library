DELIMITER $$
CREATE PROCEDURE show_loans(IN card_num INT)
BEGIN
	SELECT concat(tbl_book.title, ' is due ', tbl_book_loans.dueDate)
    FROM tbl_book_loans
    JOIN tbl_book ON tbl_book.bookId=tbl_book_loans.bookId
    WHERE tbl_book_loans.cardNo=card_num
    ORDER BY tbl_book.title DESC;
END $$
DELIMITER ;