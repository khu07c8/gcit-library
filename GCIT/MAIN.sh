read -p "Welcome to the GCIT Library Manage System. Which category of a user are you?
1) Librarian
2) Administrator
3) Borrower
" USER_TYPE

case "$USER_TYPE" in
    [1])
        cd LIBRARIAN
        ./LIB1.sh
        ;;
    [2])
        cd ADMIN
        ./ADMIN1.sh
        ;;
    [3])
        #validate user's card here
        read -p "Enter library card number. " USER_ID
        IFS=$'\n' RESULTS=$(MYSQL -N -u root -ptcj45 library -e "CALL validate_user($USER_ID);")

        echo $RESULTS
        #if card is validated continue with borrowers interface
        if [ $RESULTS == 'PROCEED' ];
        then
            cd BORROWER
            ./BORR1.sh $USER_ID
        else
            clear
            echo $RESULTS
            ./MAIN.sh
        fi
        ;;
    *)
        clear
        echo "Not a valid entry.."
        ./MAIN.sh
        ;;
esac