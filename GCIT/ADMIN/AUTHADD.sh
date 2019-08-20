#add an author

clear
echo -e "You have chosen to add an author.\nEnter 'quit' at any prompt to cancel operation."

read -p "Please enter new author name:
" NAME_CHANGE
case $NAME_CHANGE in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new author ID:
" ID_CHANGE
case $ID_CHANGE in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

#then add the values for this author and say successfully added

IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.add_author('$ID_CHANGE','$NAME_CHANGE',@mssg); SELECT @mssg;"))

	echo $QUERY
	read -p "Press enter to exit: "

./ADMIN1.sh