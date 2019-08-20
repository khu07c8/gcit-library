BRANCH_ID=$1 #branchID


#GET book id
IFS=$'\n' BOOKS=( $(MYSQL -N -u root -ptcj45 library -e "CALL books_at_branch($1);") )
IFS=$'\n' BOOK_IDS=( $(MYSQL -N -u root -ptcj45 library -e "CALL ids_at_branch($1);") )


#Option 2 should give further options like this:
# Pick the Book you want to add copies of, to your branch:
# 1)	Lost Tribe by Sidney Sheldon
# 2)	The Haunting by Stepehen King
# 3)	Microtrends by Mark Penn
# 4)	Quit to cancel operation

clear
echo Pick the Book you want to add copies of, to your branch:
LINE=1
    for BOOK in "${BOOKS[@]}"
        do
            echo "$LINE) $BOOK"
            ((LINE++))
    done
    echo "$LINE) To Cancel"

#<take input>
read CHOICE

#Existing number of copies: N (if none show zero)
IFS=$'\n' CURRENT_COPIES=$(MYSQL -N -u root -ptcj45 library -e "SELECT number_available(${BOOK_IDS[((CHOICE-1))]},$1);")

clear
echo -e "${BOOKS[((CHOICE-1))]}\n"
echo -e "Existing number of copies:\n$CURRENT_COPIES"


#Enter new number of copies:
echo "Enter new number of copies: "
read NEW_TOTAL



#Then you should update the book_copies table with the new values.
IFS=$'\n' RESULTS=$(MYSQL -N -u root -ptcj45 library -e "CALL update_copies($NEW_TOTAL,$BRANCH_ID,${BOOK_IDS[((CHOICE-1))]});")

clear
echo -e "$RESULTS\n"

#Then take the user back to LIB3.
