IFS=$'\n' BORROWERS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_borrower;") )
IFS=$'\n' BORROWERS_ID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_borrower.cardNo FROM tbl_borrower;") )

clear
echo "Which card holder?"
LINE=1
    for PERSON in "${BORROWERS[@]}"
        do
            # IFS=$'\n' read -r brName <<< "$BRANCH"
            echo "$LINE) $PERSON"
            ((LINE++))
    done
echo "quit) Go Back"
read CHOICE
case $CHOICE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac


IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e " CALL delete_borrower(${BORROWERS_ID[((CHOICE-1))]});") )

echo $MSG

./ADMIN1.SH