read -p "Enter publisher's name: " NAME
case $NAME in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter publisher's address: " ADDRESS
case $ADDRESS in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter publisher's phone number: " PHONE
case $PHONE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac


IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL add_publisher('$NAME', '$ADDRESS', '$PHONE');") )

clear
echo $MSG
./ADMIN1.sh