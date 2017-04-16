#!/bin/bash

resize () {
	for i in *; do
		if [[ ( -f $i ) && $(file --brief --mime-type $i) =~ image ]]; then
			if [[ !($i =~ ^DCmini_*) ]]; then
				convert -resize 1300 $i $i
			fi
		fi
	done
}

encrypt () {
	for i in *; do
		if [[ ( -f $i ) && $(file --brief --mime-type $i) =~ image ]]; then
			if [[ ! ($i =~ ^DCmini_*) ]]; then
				convert -encipher $password_file $i DCmini_${i%%.*}.png
				rm $i
			fi
		else
			continue
		fi
	done
}

decrypt () {
	for i in *; do
		if [[ (-f $i ) && $(file --brief --mime-type $i) =~ image ]]; then
			if [[ $i =~ ^DCmini_* ]]; then
				j=${i##DCmini_}
				j=${j%%.*}.jpg
			#	mkdir paprika_decrypted_images before calling this function
				convert -decipher $password_file $i paprika_decrypted_images/$j
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
y, using a 'pass-file' that you provide. The original files will then be deleted
- you'll be left only with either deciphered or enciphered images.

"""

printf "Your current working directory is: \033[1;41m$(pwd)\033[0m\n"
echo "Before continuing, please ensure that this is the desired working directory."

printf "(\033[2;41mC\033[0montinue/\033[2;41mQ\033[0muit) > "
read
[[ !(${REPLY,,} =~ [qc]) ]] && echo -e "Invalid Input. Exiting." && exit
[[ ${REPLY,,} == q ]] && exit

printf "\nContinuing...\n\n"
read -p "Please enter the name of the 'pass-file': " password_file
ls $password_file &> /dev/null
[[ $? != 0 ]] && echo "The pass-file you entered does not exist. Exiting." && exit

while true; do
	printf "Please select the mode. (\033[2;41mE\033[0mncipher/\033[2;41mD\033[0mecipher) > "
	read mode
	case ${mode,,} in
		encipher|e) 		printf "\nIf your photos are of large size, it might be a good idea to resize them.\n"
					printf "Would you like to resize them? (\033[2;41mY\033[0m/\033[2;41mN\033[0m) > "
					read
					[[ ${REPLY,,} == q ]] && exit
					[[ ${REPLY,,} == y ]] && resize
					encrypt
					break
					;;
		decipher|d) 		ls paprika_decrypted_images &> /dev/null
					[[ $? != 0 ]] && mkdir paprika_decrypted_images
					decrypt
					break
					;;
		quit|q)			exit
					;;
		*)			clear
					continue
					;;
	esac
done

printf """
Done!
Please keep the pass-file safe.
"""
