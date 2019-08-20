read -p "Enter branch name: " NAME
case $NAME in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter branch address (ex. 21 Sir Drive, Wesly, California 76590): " ADDRESS
case $ADDRESS in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac

read -p "Enter unique id" ID
case $ID in
	[qQ][uU][iI][tT])
		./ADMIN1.sh;;
esac



IFS=$'\n' MSG=( $(MYSQL -N -u root -ptcj45 library -e "CALL add_branch($ID,'$NAME', '$ADDRESS', @var); SELECT @var;") )

clear
echo $MSG
./ADMIN1.sh