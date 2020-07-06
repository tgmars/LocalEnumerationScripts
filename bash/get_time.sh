#!/bin/bash -e
# 
# Get the date in RFC-3339 format and output to text file. This output includes the timezone of the local system ()
# To extend this, cat /etc/timezone to get a textual representation of the timezone.

dateVar=$(date --rfc-3339='seconds') 
textTZ=$(cat /etc/timezone)
printf "datetime,texttimezone\n%s,%s\n" "$dateVar" "$textTZ" > ./output/datetimezone.txt

