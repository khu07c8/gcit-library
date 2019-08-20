# add new book

clear
echo -e "You have chosen to add a new book.\nEnter 'quit' at any prompt to cancel operation."

read -p "Please enter new book title:
" TITLE
case $TITLE in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new book ID:
" BID
case $BID in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new publisher name:
" PNAME
case $PNAME in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new publisher ID:
" PID
case $PID in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new author name:
" ANAME
case $ANAME in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter new author ID:
" AID
case $AID in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter branch ID to add copies to:
" BrID
case $BrID in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

read -p "Please enter number of copies to add to branch:
" COPIES
case $COPIES in
	[qQ][uU][iI][tT])
		./OPT1.sh;;
esac

#then add the values for this book and say successfully added

NEW_TITLE=$TITLE
NEW_PNAME=$PNAME
NEW_ANAME=$ANAME

case TITLE in
	[nN]/[aA])
		NEW_TITLE="N/A"
		;;
esac

case PNAME in
	[nN]/[aA])
		NEW_PNAME="N/A"
		;;
esac

case ANAME in
	[nN]/[aA])
		NEW_ANAME="N/A"
		;;
esac

IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.add_book($BID,'$NEW_TITLE',$PID,'$NEW_PNAME','$NEW_ANAME',$AID,$BrID,$COPIES,@mssg); SELECT @mssg;

echo $QUERY
read -p "Press enter to exit: "
