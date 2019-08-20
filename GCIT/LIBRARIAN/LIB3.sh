#param1 is the branch id
#param2 is the branch name
clear

OPTION=0
while [ $OPTION==0 ]
    do
    read -p "1)	Update the details of the Library 
2)	Add copies of Book to the Branch
3)	Quit to previous menu
" OPTION

    case "$OPTION" in
        1)
            ./OPT1.sh $1 "$2"
            ;;
        2)
            ./OPT2.sh $1
            ;;
        3)
            ./LIB1.sh
            ;;
    esac
done