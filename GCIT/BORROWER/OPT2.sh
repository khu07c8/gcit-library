# $1 is card holders id num

# Pick the Branch you want to check out from:
# 1)	University Library, Boston 
# 2)	State Library, New York
# 3)	Federal Library, Washington DC
# 4)	County Library, McLean VA 
# 5)	Quit to previous (should take you menu BORR1)

IFS=$'\n' BRANCH_NAMES=( $(MYSQL -N -u root -ptcj45 library -e "SELECT branchName FROM tbl_library_branch ORDER BY tbl_library_branch.branchName ASC;") )

IFS=$'\n' BRANCH_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT branchId FROM tbl_library_branch ORDER BY tbl_library_branch.branchName ASC;") )

clear #CLEAR SCREEN
echo -e "Pick your branch:\n"
LINE=1
    for BRANCH in "${BRANCH_NAMES[@]}"
        do
            echo "$LINE) $BRANCH"
            ((LINE++))
    done
echo -e "$LINE) Go Back\n"
read BRANCH_CHOICE
echo ${BRANCH_IDS[((BRANCH_CHOICE - 1))]}

# Pick the Book you want to check out (make sure you only show books that have atleast one copy in BOOK_COPIES in the branch picked)

# 1)	Lost Tribe by Sidney Sheldon
# 2)	The Haunting by Stepehen King
# 3)	Microtrends by Mark Penn
# 4)	Quit to cancel operation (should take you menu BORR1)


IFS=$'\n' LOANS=( $(MYSQL -N -u root -ptcj45 library -e "CALL show_loans(${BRANCH_IDS[((BRANCH_CHOICE-1))]}, $1 );") )
IFS=$'\n' BOOK_IDS=( $(MYSQL -N -u root -ptcj45 library -e "CALL books_from_loans(${BRANCH_IDS[((BRANCH_CHOICE-1))]}, $1);") )
clear

if [ -z "$LOANS" ]
then
    echo 'No loans at that branch'
else
        LINE=1
            for BOOK in "${LOANS[@]}"
                do
                    echo "$LINE) $BOOK"
                    ((LINE++))
            done
        echo "$LINE) To Cancel"
        read BOOK_CHOICE

        echo ${BOOK_IDS[((BRANCH_CHOICE - 1))]}



    IFS=$'\n' RESULTS=( $(MYSQL -N -u root -ptcj45 library -e "CALL return_shell(${BOOK_IDS[((BOOK_CHOICE-1))]},${BRANCH_IDS[((BRANCH_CHOICE-1))]}, $1);") )



    clear
    echo -e "$RESULTS\n"
fi

../MAIN.sh
