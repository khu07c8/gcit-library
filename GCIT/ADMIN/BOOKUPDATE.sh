#update a book
IFS=$'\n' BOOKS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT b.bookId,b.title FROM tbl_book b ORDER BY b.title;"))

IFS=$'\n' ALL_BOOKS=( $(MYSQL -N -u root -ptcj45 library -e "CALL admin_show_all();"))

#clear #clear the screen

LINE=1
for BOOK in "${ALL_BOOKS[@]}"
do
	
	echo "$LINE) $BOOK"
	((LINE++))
done
echo "$LINE) Go Back"
read -p "Choose the book you want to update or enter $LINE to go back...
" CHOICE

if [ $((CHOICE)) -gt $((LINE-1)) ]
then
	clear
	./OPT1.sh
else
	#update book
	IFS=$'\t' read -r bId title <<< "${BOOKS[(($CHOICE-1))]}"
clear
	IFS=$'\n' AUTH=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorName FROM tbl_author a JOIN tbl_book_authors ba ON ba.authorId = a.authorId JOIN tbl_book b ON ba.bookId = b.bookId WHERE b.bookId = $bId;") )
echo -e "You have chosen to update the book with \nBook Id: $bId\nand\nBook Title: $title\nAuthors: "
for author in "${AUTH[@]}"
do
	echo -e "$author, "
done
echo -e "\nEnter 'quit' at any prompt to cancel operation."

read -p "Please enter new book title or enter N/A for no change:
" TITLE_CHANGE
case $TITLE_CHANGE in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new publisher ID or enter N/A for no input: " PUBID_CHANGE
case $PUBID_CHANGE in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Would you like to remove a genre? (y/n) " CHOICE
case $CHOICE in
	[yY])
		REMG=1
		NEWGENRE="N/A"
		read -p "Enter the ID of the genre you would like to remove: " OLDGENRE
		;;
	[nN])	
		REMG=0
		
		read -p "Would you like to replace a genre? (y/n) " CHOICE2
		case $CHOICE2 in
			[yY])
				read -p "Enter the ID of the genre you would like replaced: " OLDGENRE
				read -p "Enter the ID of the genre you would like to take this place: " NEWGENRE
				;;
			[nN])
				OLDGENRE="N/A"
				read -p "Enter the ID of the genre you would like to add or enter N/A: " NEWGENRE
				;;
		esac
		;;
esac

read -p "Would you like to remove an author? (y/n) " CHOICE
case $CHOICE in
	[yY])
		REMA=1
		OLDAUTH="N/A"
		read -p "Enter the ID of the author you would like to remove: " OLDAUTH
		;;
	[nN])	
		REMA=0

		read -p "Would you like to replace an author? (y/n) " CHOICE2
		case $CHOICE2 in
			[yY])
				read -p "Enter the ID of the author you would like replaced: " OLDAUTH
				read -p "Enter the ID of the author you would like to take this place: " NEWAUTH
				;;
			[nN])
				OLDAUTH="N/A"
				read -p "Enter the ID of the author you would like to add or enter N/A: " NEWAUTH
				;;
		esac
		;;
esac


#then add the values for this book and say successfully added

NEW_TITLE=$TITLE_CHANGE
NEW_PID=$PUBID_CHANGE
NEW_GENRE=$NEWGENRE
NEW_AUTH=$NEWAUTH
case $TITLE_CHANGE in
	[nN]/[aA])
		NEW_TITLE="N/A"
		;;
esac
case $PUBID_CHANGE in
	[nN]/[aA])
		NEW_PID="N/A"
		;;
esac
case $NEWGENRE in
	[nN]/[aA])
		NEW_GENRE="N/A"
		;;
esac
case $NEWAUTH in
	[nN]/[aA])
		NEW_AUTH="N/A"
		;;
esac

IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.update_book($bId,'$NEW_TITLE','$NEW_PID','$NEW_GENRE','$OLDGENRE',$REMG,'$NEW_AUTH','$OLDAUTH',$REMA,@exitCode,@mssg); SELECT @exitCode, @mssg;"))

IFS=$'\t' read -r CODE MSSG <<< "${QUERY[-1]}"

echo $MSSG
case $CODE in
	0)
			IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_book WHERE bookId = $bId;"))
			IFS=$'\n' AUTH=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorName FROM tbl_author a JOIN tbl_book_authors ba ON ba.authorId = a.authorId JOIN tbl_book b ON ba.bookId = b.bookId WHERE b.bookId = $bId;") )
			IFS=$'\n' GENRE=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.genre_name FROM tbl_genre a JOIN tbl_book_genres ba ON ba.genre_id = a.genre_id JOIN tbl_book b ON ba.bookId = b.bookId WHERE b.bookId = $bId;") )

		echo -e "$QUERY\n"
		for author in $AUTH
		do
			echo -e "$author\n"
		done
		for genre in $GENRE
		do
			echo -e "$genre\n"
		done
		read -p "Press enter to exit: "
		;;
	1)
		read -p "Press enter to go back: " QUIT
		./OPT1.sh
		;;
esac
fi

./ADMIN1.sh