#!/bin/bash

resize () {
	for i in *; do
		if [[ $(file --mime-type $i) =~ image ]]; then
			if [[ !($i =~ ^Dream_*) ]]; then
				convert -resize 1300 $i $i
			fi
		fi
	done
}

encrypt () {
	for i in *; do
		if [[ $(file --mime-type $i) =~ image ]]; then
			if [[ ! ($i =~ ^Dream_*) ]]; then
				convert -encipher $password_file $i Dream_${i%%.*}.png
				rm $i
			fi
		else
			continue
		fi
	done
}

decrypt () {
	for i in *; do
		if [[ $(file --mime-type $i) =~ image ]]; then
			if [[ $i =~ ^Dream_* ]]; then
				j=${i##Dream_}
				j=${j%%.*}.jpg
				convert -decipher $password_file $i $j 
				rm $i
			fi
		else
			continue
		fi
	done
}

clear
printf """
\033[1;31mPaprika Initializing...\033[0m

This script will encipher or decipher all the pictures in your current director-
y, using a 'pass-file' that you provide.

"""

printf "Your current working directory is: \033[1;41m$(pwd)\033[0m\n"
echo "Before continuing, please ensure that this is the desired working directory."

printf "(\033[2;41mC\033[0montinue/\033[2;41mQ\033[0muit) > "
read
[[ !(${REPLY,,} =~ [qc]) ]] && echo -e "Invalid Input. Exiting." && exit
[[ ${REPLY,,} == q ]] && exit

printf "\nContinuing...\n"
read -p "Please enter the name of the 'pass-file': " password_file
while true; do
	printf "Please select the mode. (\033[2;41mEncipher\033[0m/\033[2;41mDecipher\033[0m) > "
	read mode
	case ${mode,,} in
		encipher|e) printf "If your photos are of large size, it might be a good idea to resize them.\n"
					printf "Would you like to resize them? (\033[2;41mY\033[0m/\033[2;41mN\033[0m) > "
					read
					[[ ${REPLY,,} == y ]] && resize
					encrypt
					break
					;;
		decipher|d) decrypt
					break
					;;
		quit|q)		exit
					;;
		*)			clear
					continue
					;;
	esac
done
