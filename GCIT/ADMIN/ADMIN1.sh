# Also implement the following ADMINISTRATOR functions:
clear
echo "Enter 'quit' | 'QUIT' at any menu to cancel"
echo -e "1)	Add/Update/Delete Book and Author
2)	Add/Update/Delete Publishers
3)	Add/Update/Delete Library Branches
4)	Add/Update/Delete Borrowers
5)	Over-ride Due Date for a Book Loan"

read CHOICE

# 1)	Add/Update/Delete Book and Author
case $CHOICE in
    1)
        ./OPT1.sh
    ;;
    2)
        echo -e "Edit Publishers\n\n1) Add Publisher\n2) Update Publisher\n3) Delete Publisher"  
        read ADMIN_FUNC

        case $ADMIN_FUNC in
            1)
            ./pub_add.sh
            ;;
            2)
            ./pub_update.sh
            ;;
            3)
            ./pub_delete.sh
            ;;
        esac

    ;;
    3)
        echo -e "Edit Branches\n1) Add Branch\n2) Update Branch\n3) Delete Branch"
        read ADMIN_FUNC

        case $ADMIN_FUNC in
            1)./branch_add.sh
            ;;
            2)./branch_update.sh
            ;;
            3)./branch_delete.sh            
            ;;
        esac

    ;;
    4)
        echo -e "Edit Borrowers\n1) Add Borrowers\n2) Update Borrower\n3) Delete Borrower"
        read ADMIN_FUNC

        case $ADMIN_FUNC in
            1)
            ./borrower_add.sh
            ;;
            2)
            ./borrower_update.sh
            ;;
            3)
            ./borrower_delete.sh
            ;;
        esac

    ;;
    5)	
        ./override_due.sh
    ;;
    [qQ][uU][iI][tT])
        cd ../
        ./MAIN.sh
    ;;
esac