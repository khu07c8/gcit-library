#GET NAMES
IFS=$'\n' BRANCH_NAMES=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchName FROM tbl_library_branch;") )
#GET IDS
IFS=$'\n' BRANCH_IDS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_library_branch.branchId FROM tbl_library_branch;") )


clear #CLEAR SCREEN
LINE=1
    for BRANCH in "${BRANCH_NAMES[@]}"
        do
            # IFS=$'\n' read -r brName <<< "$BRANCH"
            echo "$LINE) $BRANCH"
            ((LINE++))
    done
echo "$LINE) Go Back"
read -p "Choose your branch or enter $LINE to go back..
" CHOICE

if [ $((CHOICE)) -gt $((LINE)) ]
then
    clear
else
    #IFS=$'\t' read -r brName brID <<< "${BRANCHES[((CHOICE-1))]}" 
    ./LIB3.sh  ${BRANCH_IDS[((CHOICE-1))]} "${BRANCH_NAMES[((CHOICE-1))]}"
fi
