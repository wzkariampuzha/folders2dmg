# Improve this with this: https://daniel-ellis.medium.com/shell-script-submitting-a-password-after-a-prompt-690bcf144c0e
## https://bash.cyberciti.biz/guide/$1
## https://stackoverflow.com/questions/15133474/how-to-use-expect-inside-a-bash-script


#!/bin/bash
HEAD_DIR=$1
PASSWORD=$2
echo "This script will encrypt and compress all subdirectories of " $HEAD_DIR " and create a disk image for each subdirectory."

echo $0
#This reads in the terminal "find" script output (which is string) as an array named SUBDIR_ARR
read -a SUBDIR_ARR <<< $(find $HEAD_DIR -maxdepth 1 -type d)
#Remove the first element, which just returns the head directory
unset SUBDIR_ARR[0]
echo "\nNumber of disk images to be created: ${#SUBDIR_ARR[@]}"
echo "\nCreating a disk image for these subdirectories:"
for DIRECTORY in ${SUBDIR_ARR[@]}
do
	echo "$DIRECTORY"
done
echo "\n"
for DIRECTORY in ${SUBDIR_ARR[@]}
do
	echo "***** Starting disk image creation of " $DIRECTORY " *****"
	#" $( dirname -- "$0") " is the name of the directory where the bash and expect scripts are located
	#Must send to expect script because bash cannot work with command line programs where user input is required
	expect $( dirname -- "$0")/encrypt_folder2dmg.exp $DIRECTORY $PASSWORD
	echo "***** Disk image creation of " $DIRECTORY "is DONE *****"
done

