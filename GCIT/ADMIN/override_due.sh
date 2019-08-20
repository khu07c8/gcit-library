#GET NAMES
IFS=$'\n' ALL_LOANS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_book_loans JOIN tbl_book ON tbl_book.bookId=tbl_book_loans.bookId;") )
#GET IDS
IFS=$'\n' BOOK_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_book_loans.bookId FROM tbl_book_loans;") )
IFS=$'\n' USER_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_book_loans.cardNo FROM tbl_book_loans;;") )
IFS=$'\n' BRANCH_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_book_loans.branchId FROM tbl_book_loans;;") )
IFS=$'\n' DATE_OUT=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_book_loans.dateOut FROM tbl_book_loans;;") )



clear #CLEAR SCREEN
echo -e "Choose your branch or enter 'QUIT' to go back.."
LINE=1
    for LOAN in "${ALL_LOANS[@]}"
        do
            echo "$LINE) $LOAN"
            ((LINE++))
    done
echo "quit) Go Back"
read CHOICE
case $CHOICE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac


read -p "Set new due date (YYYYMMDD)" NEW_DATE

IFS=$'\n' BOOK_LOAN_IDS=( $(MYSQL -N -u root -ptcj45 library -e "CALL override_due_date(${BOOK_IDS[((CHOICE-1))]}, ${BRANCH_IDS[((CHOICE-1))]}, ${USER_IDS[((CHOICE-1))]}, DATE('${DATE_OUT[((CHOICE-1))]}'), DATE($NEW_DATE), @VAR, @VAR2);") )


clear
./ADMIN1.sh