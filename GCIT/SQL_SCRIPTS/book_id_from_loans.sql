DELIMITER $$
CREATE PROCEDURE books_from_loans(IN card_num INT)
BEGIN
	SELECT tbl_book_loans.bookId
    FROM tbl_book_loans
    JOIN tbl_book ON tbl_book.bookId=tbl_book_loans.bookId
    WHERE tbl_book_loans.cardNo=card_num
    ORDER BY tbl_book.title;

END $$
DELIMITER ;