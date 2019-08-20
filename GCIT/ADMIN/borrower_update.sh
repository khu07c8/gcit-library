#GET NAMES
IFS=$'\n' BORROWERS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_borrower.name FROM tbl_borrower ORDER BY tbl_borrower.name;") )
#GET IDS
IFS=$'\n' BORROWER_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_borrower.cardNo FROM tbl_borrower ORDER BY tbl_borrower.name;") )
clear #CLEAR SCREEN

echo -e "Who are you?\n"
LINE=1
    for PERSON in "${BORROWERS[@]}"
        do
            # IFS=$'\n' read -r brName <<< "$BRANCH"
            echo "$LINE) $PERSON"
            ((LINE++))
    done
echo "$quit) To Cancel"
read CHOICE
case $CHOICE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac


read -p "Enter new name  or enter n/a" NAME
case $NAME in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter new address or enter n/a" ADDRESS
case $ADDRESS in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter phone number or enter n/a" PHONE
case $PHONE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac




IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL update_borrower(${BORROWER_IDS[((CHOICE-1))]},'${BORROWER_IDS[((CHOICE-1))]}','$NAME', '$ADDRESS', '$PHONE', @VAR, @VAR2);") )


./ADMIN1.sh