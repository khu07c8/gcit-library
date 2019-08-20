#!/bin/bash
#$1 is the branch id
#$2 is the branch name


#Option 1 should update library_branch table for the branch he had
#picked before. This should be like:

clear
echo -e "You have chosen to update the Branch with \nBranch Id: $1\nand\nBranch Name: $2\nEnter ‘quit’ at any prompt to cancel operation."

read -p "
Please enter new branch name or enter N/A for no change:
" NAME_CHANGE
case $NAME_CHANGE in
[qQ][uU][iI][tT])
./LIB1.sh;;
esac

read -p "Please enter new branch address or enter N/A for no change:
" ADDRESS_CHANGE
case $ADDRESS_CHANGE in
[qQ][uU][iI][tT])
./LIB1.sh;;
esac


#Then update the values for this branch and say successfully updated. #Then go back to menu LIB3, to start over again.
NEW_NAME=$NAME_CHANGE
NEW_ADDRESS=$ADDRESS_CHANGE
case NAME_CHANGE in
    [nN]/[aA])
        NEW_NAME="N/A"
        ;;
esac
case ADDRESS_CHANGE in
    [nN]/[aA])
        NEW_ADDRESS="N/A"
        ;;
esac


IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.edit_branch($1, '$NEW_NAME', '$NEW_ADDRESS');") )


cd ..
clear

echo -e "$QUERY\n"