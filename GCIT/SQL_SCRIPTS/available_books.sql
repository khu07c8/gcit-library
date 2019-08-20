CREATE DEFINER=`root`@`localhost` PROCEDURE `available_books`()
BEGIN
    SELECT concat(tbl_book.title, ' by ', tbl_author.authorName) 'book'
    FROM tbl_book
    JOIN tbl_book_authors ON tbl_book.bookId=tbl_book_authors.authorId
    JOIN tbl_author ON tbl_author.authorId=tbl_book_authors.authorId
    JOIN tbl_book_copies ON tbl_book_copies.bookId=tbl_book.bookId
    WHERE tbl_book_copies.noOfCopies > 0
    ORDER BY tbl_book.title;
END