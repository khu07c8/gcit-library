#get the authors

IFS=$'\n' AUTHORNAME=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorName FROM tbl_author a ORDER BY a.authorId;"))
IFS=$'\n' AUTHORID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT a.authorId FROM tbl_author a ORDER BY a.authorId;"))

clear # clear the screen
LINE=1
for AUTHOR in "${AUTHORNAME[@]}"
do
	echo "$LINE) $AUTHOR"
	((LINE++))
done
echo "$LINE) Go Back"
read -p "Choose the author you want to update or enter $LINE to go back...
" CHOICE

if [ $((CHOICE)) -gt $((LINE-1)) ]
then
	clear
	./OPT1.sh
else

	# update the author that was chosen in the last menu

	clear
	echo -e "You have chosen to update the author with \nAuthor Id: ${AUTHORID[(($CHOICE-1))]}\nand\nAuthor Name: ${AUTHORNAME[(($CHOICE-1))]}\nEnter 'quit' at any prompt to cancel operation."

	read -p "Please enter new author name or enter N/A for no change:
	" NAME_CHANGE
	case $NAME_CHANGE in
		[qQ][uU][iI][tT])
			./OPT1.sh;;
	esac
	
	read -p "Please enter new author ID or enter N/A for no change:
	" ID_CHANGE
	case $ID_CHANGE in
		[qQ][uU][iI][tT])
			./OPT1.sh;;
	esac

	#then update the values for this author and say successfully updated
	NEW_NAME=$NAME_CHANGE
	NEW_ID=$ID_CHANGE
	case $NAME_CHANGE in
		[nN]/[aA])
			NEW_NAME="N/A"
			;;
	esac
	case $ID_CHANGE in
		[nN]/[aA])
			NEW_ID="N/A"
			;;
	esac

	IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.update_author(${AUTHORID[(($CHOICE-1))]},'$NEW_ID','$NEW_NAME',@exitCode,@mssg); SELECT @exitCode,@mssg;"))

	IFS=$'\t' read -r CODE MSSG <<< "${QUERY[-1]}"

	echo $MSSG
	case $CODE in
	 	0)
	 		if [ $NEW_ID == "N/A" ]
	 		then
	 			IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_author WHERE authorId = ${AUTHORID[(($CHOICE-1))]};"))
	 		else
	 			IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_author WHERE authorId = $NEW_ID;"))
	 		fi
	 		echo "${QUERY[0]}"
	 		read -p "Press enter to go back: " QUIT
	 		./OPT1.sh
	 		;;
	 	1)
	 		read -p "Press enter to go back: " QUIT
	 		./UPDATEAUTH.sh
	 		;;
	 esac
fi
read RE
./ADMIN1.sh