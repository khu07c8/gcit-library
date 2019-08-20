DELIMITER $$
CREATE PROCEDURE at_branch(IN branch_id INT(11))
BEGIN
    SELECT concat(tbl_book.title, ' by ', tbl_author.authorName) 'book'
    FROM tbl_book
    JOIN tbl_book_authors ON tbl_book.bookId=tbl_book_authors.authorId
    JOIN tbl_author ON tbl_author.authorId=tbl_book_authors.authorId
    JOIN tbl_book_copies ON tbl_book_copies.bookId=tbl_book.bookId
    WHERE tbl_book_copies.noOfCopies > 0 AND tbl_book_copies.branchId=branch_id
    ORDER BY tbl_book.title;
END $$
DELIMITER ;