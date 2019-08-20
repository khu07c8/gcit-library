IFS=$'\n' PUBLISHERS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_publisher;") )
IFS=$'\n' PUBLISHERS_ID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_publisher.publisherId FROM tbl_publisher;") )

echo "Which publisher or enter quit to go back?"
LINE=1
    for PUB in "${PUBLISHERS[@]}"
        do
            echo "$LINE) $PUB"
            ((LINE++))
    done
echo "$quit) Go Back"
read CHOICE
case $CHOICE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL delete_publisher(${PUBLISHERS_ID[((CHOICE-1))]});") )

clear
echo $MSG
./ADMIN1.sh