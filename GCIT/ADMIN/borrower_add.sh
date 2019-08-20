echo -e "Enter 'quit' at any time to cancel\n"

read -p "Enter Name" NAME
case $NAME in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter Address (ex. 40 Robert Street, Franklin, OK 49876)" ADDRESS
case $ADDRESS in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter 10-digit phone number (5555551010)" PHONE
case $PHONE in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter unique pin" PIN
case $PIN in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac



IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL add_borrower($PIN, '$NAME', '$ADDRESS', '$PHONE', @var); SELECT @var;") )

./ADMIN1.sh