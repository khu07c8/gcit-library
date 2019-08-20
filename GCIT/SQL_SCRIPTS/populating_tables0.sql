-- Populate tbl_library_branch
INSERT INTO 
tbl_library_branch(branchId,branchName,branchAddress)
VALUES
(1,'Fort Washington Library','6533 Allen Rd, Mount Hood Parkdale, Oregon(OR), 97041'),
(2,'Epiphany Library','Granite Cove Rd, Kingsland, Texas(TX), 78639'),
(3,'Donnell Library Center','214 1st St SE, South Prairie, Washington(WA), 98385'),
(4,'George Bruce Library','291 Panorama Pt, Blue Eye, Missouri(MO), 65611'),
(5,'Grand Central Library','19559 Watts Rd, Morris, Oklahoma(OK), 74445'),
(6,'Hamilton Grange Library','7337 Toxaway Dr NW, Knoxville, Tennessee(TN), 37909'),
(7,'Harlem Library','8526 SE 79th Pl, Mercer Island, Washington(WA), 98040'),
(8,'Hudson Park Library','1710 Meharry Blvd, Nashville, Tennessee(TN), 37208'),
(9,'Jefferson Market Library','8110 Catherine Ave #30, Stanton, California(CA), 90680'),
(10,'Mid-Manhattan Library','65 Lebanon St, Hanover, New Hampshire(NH), 03755'),
(11,'Muhlenberg Library','424 Tompkins Rd, Moultrie, Georgia(GA), 31768'),
(12,'Mulberry Street Library','233 Duane St, Malone, New York(NY), 12953'),
(13,'New Amsterdam Library','3040 Linden St NW, Uniontown, Ohio(OH), 44685'),
(14,'Seward Park Library','60 Spring Valley Ln, Rocky Gap, Virginia(VA), 24366');

-- Populate tbl_borrower 
INSERT INTO 
tbl_borrower(cardNo,name,address,phone)
VALUES
(4716,'Cristin','626 Bayport Lane, Middleburg, FL 32068',3033693770),
(4485,'Yelena','69 Pacific Drive, Marshfield, WI 54449',5673056836),
(5244,'Hortencia','9711 Cemetery Avenue, New Philadelphia, OH 44663',5408171032),
(4929,'Krystyna',"81 Cambridge Avenue, Jonesborough, TN 37659",7742849554),
(4539,'Cathey','9619 Applegate Lane, Sykesville, MD 21784',2012692223),
(4532,'Marissa','9319 Myrtle St., Everett, MA 02149',7168847043),
(4021,'Chelsey','473 Oak Valley Dr., Fuquay Varina, NC 27526',6417736914),
(4024,'Isis','580 Manor Ave., Williamsburg, VA 23185',2406199295),
(4954,'Melda','685 Schoolhouse Road, Coram, NY 11727',3235585431),
(4022,'Emilia','7438 S. Gainsway Dr., Dearborn Heights, MI 48127',5157249258),
(4079,'Jarrod','729 Grandrose Street, San Pablo, CA 94806',2766381357),
(4511,'Vinita','8042 Jefferson Drive, Anderson, SC 29621',3853296398),
(5206,'Wallace','309 Central Avenue, Grandville, MI 49418',8012984337),
(4521, 'John', '699 South Tanglewood, Muncie, IN 47302', 8325087738);

-- Populate tbl_publisher
INSERT INTO
tbl_publisher(publisherId,publisherName,publisherAddress,publisherPhone)
VALUES
(1,'Gwen Potter','6533 Allen Rd, Mount Hood Parkdale, Oregon(OR), 97041',6602352019),
(2,'Sophie Hampton','Granite Cove Rd, Kingsland, Texas(TX), 78639',5183212972),
(3,'Brandy Mcguire','214 1st St SE, South Prairie, Washington(WA), 98385',6233744757),
(4,'Rick Cox','291 Panorama Pt, Blue Eye, Missouri(MO), 65611',3146863332),
(5,'Joel Bryan','19559 Watts Rd, Morris, Oklahoma(OK), 74445',2898185065),
(6,'Saul Weber','7337 Toxaway Dr NW, Knoxville, Tennessee(TN), 37909',4084562650),
(7,'Oscar Sanders','8526 SE 79th Pl, Mercer Island, Washington(WA), 98040',6142323153),
(8,'Jenna Cannon','1710 Meharry Blvd, Nashville, Tennessee(TN), 37208',3147095034),
(9,'Penny Mcdaniel','8110 Catherine Ave #30, Stanton, California(CA), 90680',6514832328),
(10,'David Mckinney','65 Lebanon St, Hanover, New Hampshire(NH), 03755',3305691679),
(11,'Melvin Leonard','424 Tompkins Rd, Moultrie, Georgia(GA), 31768',8145877655),
(12,'Jessie Newton','233 Duane St, Malone, New York(NY), 12953',4062928460),
(13,'Dixie Steele','3040 Linden St NW, Uniontown, Ohio(OH), 44685',7042857969),
(14,'Marlene Gilbert','60 Spring Valley Ln, Rocky Gap, Virginia(VA), 24366',8453228078);

-- Populate tbl_book
INSERT INTO 
tbl_book(bookId,title,pubId)
VALUES
(1,'Gone with the Wind',14),
(2,'Pride and Prejudice',13),
(3,'The Hobbit or There and Back Again',12),
(4,'Wuthering Heights',11),
(5,'Little Women',10),
(6,'A Tale of Two Cities',9),
(7,'Emma',8),
(8,'The Raven',7),
(9,'Doctor Zhivago',6),
(10,'Great Expectations',5),
(11,'Treasure Island',4),
(12,'A Little Princess',3),
(13,'The Neverending Story',2),
(14,'Sense and Sensibility',1);

-- Populate tbl_genre
INSERT INTO 
tbl_genre(genre_id,genre_name)
VALUES
(1,'Romance'),
(2,'Horror'),
(3,'Fantasy'),
(4,'Historical'),
(5,'Science'),
(6,'Mystery'),
(7,'Fiction'),
(8,'Humour'),
(9,'Poetry'),
(10,'Fairy Tale'),
(11,'Drama'),
(12,'Thriller'),
(13,'Biography'),
(14,'Classic');

-- Populate tbl_book_genres
INSERT INTO 
tbl_book_genres(genre_id,bookId)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14);

-- Populate tbl_author
INSERT INTO
tbl_author(authorId,authorName)
VALUES
(1,'Bok Elliott'),
(2,'Darin Kilbane'),
(3,'Gus Laubach'),
(4,'Brittani Crabtree'),
(5,'Consuela Barrett'),
(6,'Elane Trostle'),
(7,'Phung Pickert'),
(8,'Alleen Falconer'),
(9,'Jann Walls'),
(10,'Kevin Sturgill'),
(11,'Clarissa Schmuck'),
(12,'Vesta Lamontagne'),
(13,'Euna Conkling'),
(14,'Colin Sandford');

-- Populate tbl_book_authors
INSERT INTO
tbl_book_authors(bookId,authorId)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14);

-- Populate tbl_book_copies
INSERT INTO
tbl_book_copies(bookId,branchId,noOfCopies)
VALUES
(1,1,12),
(2,2,40),
(3,3,24),
(4,4,76),
(5,5,23),
(6,6,12),
(7,7,67),
(8,8,24),
(9,9,21),
(10,10,13),
(11,11,34),
(12,12,42),
(13,13,37),
(14,14,50);


-- Populate tbl_book_loans
INSERT INTO
tbl_book_loans(bookId,branchId,cardNo,dateOut,dueDate,returnedDate)
VALUES
(1,1,4716,7/19/2019,7/26/2019,7/24/2019),
(2,2,4485,8/1/2019,8/8/2019,8/7/2019),
(3,3,5244,8/3/2019,8/10/2019,8/5/2019),
(4,4,4929,8/8/2019,8/15/2019,null),
(5,5,4539,8/13/2019,8/20/2019,null),
(6,6,4532,6/1/2019,6/8/2019,null),
(7,7,4024,5/1/2019,5/8/2019,null),
(8,8,4021,8/15/2019,8/22/2019,8/21/2019),
(9,9,4954,8/12/2019,8/19/2019,null),
(10,10,4022,8/6/2019,8/13/2019,null),
(11,11,4079,7/10/2019,7/17/2019,8/1/2019),
(12,12,4539,7/24/2019,7/31/2019,null),
(13,13,5206,7/30/2019,8/6/2019,null),
(14,14,4521,7/29/2019,8/5/2019,null);