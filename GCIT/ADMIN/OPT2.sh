# 2)	Add/Update/Delete Publisher

clear #clear screen

while true #loop if input is invalid
do
	# display options for user
	echo -e "\nSubmit the procedure you would like to perform:\n"
	echo -e "1) Add\n"
	echo -e "2) Update\n"
	echo -e "3) Delete\n"
	echo -e "4) Go back.\n"

	#read user input
	read -p ": " OP1

	case "$OP1" in
		1)
			./PUBADD.sh
			;;
		2)
			./PUBUPDATE.sh
			;;
		3)
			./PUBDELETE.sh
			;;
		4)
			./ADMIN1.sh
			;;
	esac
done
