clear #CLEAR SCREEN

while true #LOOP IF INPUT IS INVALID
    do
    read -p "1) Find your branch
2) Quit to previous menu
" BRANCH
    
    case "$BRANCH" in
        1)
            ./LIB2.sh
            ;;
        2)
            cd ..
            ./MAIN.sh
            ;;
    esac
done