#! /bin/bash

# read a file given as an input where each line in the file contains a utility. Print the version of the utility,
# if it is installed, else print the statement 'The utility <name> is not installed

if [ -z $1 ]
then
	echo Please provide the utility
	exit 1
else
	check_utility=$(dpkg -l | grep $1 )
	if [ $(dpkg -l | grep $1 | wc -l) -gt 0 ]
	then
		echo "The utility "$1" is installed."
	else
		echo "The utilty "$1" is not installed."
	fi
fi
exit 0
