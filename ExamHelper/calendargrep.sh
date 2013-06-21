#!/bin/bash
 
# Author: Sergios Stamatis
# Company: ITEna Solutions
# Creation Date: 06 March 2012
 
# iOS Calendar Viewer
# This script copies the Calendar sqlite database file from
# the iOS simulator to the Desktop and presents the events
# in a human readable form. Useful when debugging an iOS
# application that uses the EventKit and don't have an
# iOS device handy.
 
# Usage instructions:
# Execute 
# chmod u+x CalendarViewer.bash
# to make the script executable
# ./CalendarViewer.bash
# to run the script
 
# Where to grab Calendar.sqlitedb
CALENDAR_DB_SOURCE=~/Library/Application\ Support/iPhone\ Simulator/5.1/Library/Calendar/Calendar.sqlitedb
# Where to put Calendar.sqlitedb
CALENDAR_DB_DESTINATION=~/Desktop
CALENDAR_DB_DESTINATION_FILE=~/Desktop/Calendar.sqlitedb
 
truncateFloat () {
# Return the decimal part of the string
  FLOAT=$1
  echo ${FLOAT%.*}
}
 
extractField () {
# Return database field. Fields are seperated with '|'
  FIELD=$1
  POSITION=$2
  echo ${FIELD} | cut -d '|' -f $POSITION
}
 
convertMacAbsoluteTime () {
# Convert from Mac Absolute Time to Unix epoch time
# Mac Absolute Time is the number of seconds from 01/01/2001 00:00:00
# sqlite3 requires a database file to be specified to executed queries
  UNIX_TO_MAC_SECONDS=`sqlite3 "${CALENDAR_DB_DESTINATION_FILE}" "select strftime('%s', '2001-01-01 00:00:00');"`
  MAC=$1
  MAC_ROUND=`truncateFloat ${MAC}`
  RESULT=`echo "${MAC_ROUND} + ${UNIX_TO_MAC_SECONDS}" | bc`
  echo `date -r ${RESULT}`
}
 
cp "${CALENDAR_DB_SOURCE}" "${CALENDAR_DB_DESTINATION}"
CALENDAR_ITEMS=`sqlite3 "${CALENDAR_DB_DESTINATION_FILE}" "select summary,start_date,end_date,last_modified from CalendarItem;"`
 
# To split string on new line character and correctly iterate
# CALENDAR_ITEMS at the for loop
oldIFS=$IFS
IFS='
'
 
printf "%20s %30s %30s %30s\n" "Summary" "Start Date" "End Date" "Last Modified"
printf "%20s %30s %30s %30s\n" "-------" "----------" "--------" "-------------"
 
for calendarItem in ${CALENDAR_ITEMS[@]}
do
  #echo "${calendarItem}"
  SUMMARY=`extractField ${calendarItem} 1`
  START_DATE_RAW=`extractField ${calendarItem} 2`
  END_DATE_RAW=`extractField ${calendarItem} 3`
  LAST_MODIFIED_RAW=`extractField ${calendarItem} 4`
  

  START_DATE=`convertMacAbsoluteTime $START_DATE_RAW`
  END_DATE=`convertMacAbsoluteTime $END_DATE_RAW`
  LAST_MODIFIED=`convertMacAbsoluteTime $LAST_MODIFIED_RAW`
  printf "%20s %30s %30s %30s\n" "${SUMMARY}" "${START_DATE}" "${END_DATE}" "${LAST_MODIFIED}" 
done
 
# Restore the Input File Separator
IFS=$oldIFS
