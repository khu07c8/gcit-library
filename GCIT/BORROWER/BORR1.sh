#$1 is card holders id number
clear
echo -e "1) Check out a book\n2) Return a Book\n3) Quit to Previous"

read ANSWER

case $ANSWER in 
    1)
        ./OPT1.sh $1
        ;;
    2)
        ./OPT2.sh $1
        ;;
    3)
        cd ..
        ./MAIN.sh
        ;;
    *)
        ;;
esac

