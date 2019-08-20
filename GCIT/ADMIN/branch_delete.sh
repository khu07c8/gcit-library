#GET NAMES
IFS=$'\n' BRANCH_NAMES=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchName FROM tbl_library_branch;") )
#GET IDS
IFS=$'\n' BRANCH_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchId FROM tbl_library_branch;") )
clear #CLEAR SCREEN

echo "Which branch?"
LINE=1
    for BRANCH in "${BRANCH_NAMES[@]}"
        do

            echo "$LINE) $BRANCH"
            ((LINE++))
    done
echo "quit) Go Back"
read -p "Choose your branch or enter $LINE to go back.." CHOICE


if [ $CHOICE == $LINE ];
then
    cd ..
fi

IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL delete_branch(${BRANCH_IDS[((CHOICE-1))]});") )

echo $MSG
./ADMIN1.sh