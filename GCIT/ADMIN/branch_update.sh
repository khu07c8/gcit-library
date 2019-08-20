#GET NAMES
IFS=$'\n' BRANCH_NAMES=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchName FROM tbl_library_branch;") )
#GET IDS
IFS=$'\n' BRANCH_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchId FROM tbl_library_branch;") )
clear #CLEAR SCREEN

LINE=1
    for BRANCH in "${BRANCH_NAMES[@]}"
        do

            echo "$LINE) $BRANCH"
            ((LINE++))
    done
echo "quit) Go Back"
read -p "Choose your branch or enter $LINE to go back.." CHOICE


if [ $CHOICE == quit ];
then
    cd ./ADMIN1.sh
fi
#Option 1 should update library_branch table for the branch he had
#picked before. This should be like:

clear
echo -e "You have chosen to update the Branch with \nBranch Id: ${BRANCH_IDS[((CHOICE-1))]}\nand\nBranch Name: "${BRANCH_NAMES[((CHOICE-1))]}"\nEnter ‘quit’ at any prompt to cancel operation.\n"

read -p "Please enter new branch name or enter N/A for no change:" NAME_CHANGE
case $NAME_CHANGE in
[qQ][uU][iI][tT])
./ADMIN1.sh;;
esac

read -p "Please enter new branch address or enter N/A for no change:
" ADDRESS_CHANGE
case $ADDRESS_CHANGE in
[qQ][uU][iI][tT])
./ADMIN1.sh;;
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


IFS=$'\n' QUERY=( $(MYSQL -N -u root -ptcj45 library -e "CALL library.edit_branch(${BRANCH_IDS[((CHOICE-1))]}, '$NEW_NAME', '$NEW_ADDRESS');") )


cd ..
clear

echo -e "$QUERY\n"
./ADMIN1.sh