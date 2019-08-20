# 1)	Add/Update/Delete Book and Author

clear #clear screen

# while true #loop if input is invalid
# do
	# display options for user
	echo -e "First, submit the procedure you would like to perform:\n"
	echo -e "1) Add\n"
	echo -e "2) Update\n"
	echo -e "3) Delete\n"
	echo -e "4) Go back.\n"
	echo -e "Then submit if you would like "
	echo -e "to modify authors or books:\n"
	echo -e "1) Author\n"
	echo -e "2) Book\n"

	#read user input
	read -p ": " OP1
	read -p ": " OP2

	case "$OP2" in
		1)
			case "$OP1" in
				1)
					./AUTHADD.sh
					;;
				2)
					./AUTHUPDATE.sh
					;;
				3)
					./AUTHDELETE.sh
					;;
				4)
					./ADMIN1.sh
					;;
			esac
			;;
		2)
			case "$OP1" in
				1)
					./BOOKADD.sh
					;;
				2)
					./BOOKUPDATE.sh
					;;
				3)
					./BOOKDELETE.sh
					;;
				4)
					./ADMIN1.sh
					;;
			esac
			;;
	esac
# done
