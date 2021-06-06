#! /bin/bash
#to print dates from today till end of the month

TODAY=$(date +%m/01/%y)

LAST_DAY=$(date -d "$TODAY + 1 month -1 day" +%d)
#echo $LAST_DAY
let diff=($LAST_DAY - $(date +%d))
#echo $diff
for (( i=0;i<=diff;i++ ))
do
	date -d "+$i day"
done
exit 0
