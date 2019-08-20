IFS=$'\n' PUBLISHERS=( $(MYSQL -N -u root -ptcj45 library -e "SELECT * FROM tbl_publisher;") )
IFS=$'\n' PUBLISHERS_ID=( $(MYSQL -N -u root -ptcj45 library -e "SELECT tbl_publisher.publisherId FROM tbl_publisher;") )
clear

echo "Which publisher?"
LINE=1
    for PUB in "${PUBLISHERS[@]}"
        do
            echo "$LINE) $PUB"
            ((LINE++))
    done
echo "$LINE) Go Back"
read CHOICE


read -p "Enter new name or N/A" NAME
case $NAME in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac
read -p "Enter new address or N/A" ADDRESS
case $ADDRESS in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac
read -p "Enter new phone or N/A" PHONE
case $PHONE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL update_publisher(${PUBLISHERS_ID[((CHOICE-1))]}, '${PUBLISHERS_ID[((CHOICE-1))]}', '$NAME', '$ADDRESS', '$PHONE', @VAR, @VAR2);";) )

clear
echo $MSG
./ADMIN1.sh