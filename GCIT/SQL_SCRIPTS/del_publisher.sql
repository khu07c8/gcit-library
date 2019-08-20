CREATE DEFINER=`khu021a`@`%` PROCEDURE `delete_publisher`(in publisher_id int)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		select concat('Fail to delete the publisher ', publisher_id, '.');
	END;

    start transaction;
    delete from tbl_book_genres bg where exists (select b.bookId bookId from tbl_book b where bg.bookId = b.bookId and b.pubId = publisher_id);
	delete from tbl_book_authors ba where exists (select b.bookId bookId from tbl_book b where ba.bookId = b.bookId and b.pubId = publisher_id);
	delete from tbl_publisher where publisherId = publisher_id;
	commit;
    select concat('Succeed deleting the publisher ', publisher_id, '!');
END