#get the authors

IFS=$'\n' AUTHORNAME=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorName FROM tbl_author a;"))
IFS=$'\n' AUTHORID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorId FROM tbl_author a;"))

clear # clear the screen
LINE=1
for AUTHOR in "${AUTHORNAME[@]}"
do
	echo "$LINE) $AUTHOR"
	((LINE++))
done
echo "$LINE) Go Back"
read -p "Choose the author you want to delete or enter $LINE to go back...
" CHOICE

if [ $((CHOICE)) -gt $((LINE-1)) ]
then
	clear
	./OPT1.sh
else

	# update the author that was chosen in the last menu

	clear
	echo -e "You have chosen to delete the author with \nAuthor Id: ${AUTHORID[(($CHOICE-1))]}\nand\nAuthor Name: ${AUTHORNAME[(($CHOICE-1))]}\n"

	read -p "Do you wish to continue(y/n):
	" CONFIRM
	case $CONFIRM in
		[yY])
			IFS=$'\n' MSSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL delete_author(${AUTHORID[(($CHOICE-1))]});"))
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