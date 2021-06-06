#! /bin/bash

#to print difference in days between two dates given as inputs
#input date format mm/dd/yy
DATE1=$1
DATE2=$2
if [ -z $1 ] || [ -z $2 ]
then
	echo "Please provide two dates in the format mm/dd/yy"
	exit 1
else
	DATEINSEC1=$(date +%s -d $DATE1)
#	echo $DATEINSEC1
	DATEINSEC2=$(date +%s -d $DATE2)
#	echo $DATEINSEC2
	if [ $DATEINSEC1 -gt $DATEINSEC2 ]
	then
		difference=$((DATEINSEC1-DATEINSEC2))
		let sec_in_day=24\*60\*60
		diff_in_dates=$((difference/sec_in_day))
		echo "Difference in dates is "$diff_in_dates" days"
	else
		difference=$((DATEINSEC2-DATEINSEC1))
                let sec_in_day=24\*60\*60
                diff_in_dates=$((difference/sec_in_day))
                echo "Difference in dates is "$diff_in_dates" days"
	fi
fi
exit 0

