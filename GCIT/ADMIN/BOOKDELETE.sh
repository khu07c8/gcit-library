#get the books

IFS=$'\n' BOOKNAME=( $(MYSQL -N -u root -ptcj45 library -e "SELECT b.title FROM tbl_book b;"))
IFS=$'\n' BOOKID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT b.bookId FROM tbl_book b;"))

clear # clear the screen
LINE=1
for BOOK in "${BOOKNAME[@]}"
do
	echo "$LINE) $BOOK"
	((LINE++))
done
echo "$LINE) Go Back"
read -p "Choose the book you want to delete or enter $LINE to go back...
" CHOICE

if [ $((CHOICE)) -gt $((LINE-1)) ]
then
	clear
	./OPT1.sh
else

	# delete the book that was chosen in the last menu

	clear
	echo -e "You have chosen to delete the book with \nBook Id: ${BOOKID[(($CHOICE-1))]}\nand\nBook Title: ${BOOKNAME[(($CHOICE-1))]}\n"

	read -p "Do you wish to continue(y/n):
	" CONFIRM
	case $CONFIRM in
		[yY])
			IFS=$'\n' MSSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL delete_book(${BOOKID[(($CHOICE-1))]});"))
			echo -e "$MSSG\n"
			read -p "Press enter to go back: " QUIT
			./OPT1.sh;;
		[nN])
			echo -e "Operation cancelled.\n"
			read -p "Press enter to go back: " QUIT
			./OPT1.sh
	esac
fi

./ADMIN1.sh