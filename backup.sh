#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=1
destinationDirectory=2

# [TASK 2]
echo "The first argument is $targetDirectory"
# The first argument is 1
echo "The second argument is $destinationDirectory"
# The second argument is 2

# [TASK 3]
currentTS=`date +%s`
# echo $currentTS
# 1681840649
# current timestamp in seconds
# specifically seconds since 1970-01-01 00:00:00 UTC

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"
# backupFileName now would be
# echo $backupFileName
# backup-1681840649.tar.gz

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=`pwd`
# the absolute path of the current directory
# echo $origAbsPath
# /home/project

# [TASK 6]
cd $2 # <- first go to destination directory, then
destAbsPath=`pwd`
# the absolute path of the destination directory
# /home/theia

# [TASK 7]
cd $origAbsPath # <- first go to original directory, then
cd $1 # <- target directory

# [TASK 8]
yesterdayTS=$(($currentTS - 24 * 60 * 60))
# to find files updated within the past 24 hours

declare -a toBackup
# declare variable toBackup, an array

for file in $(ls) # [TASK 9] # loop all files and directories
do
  # [TASK 10] check if modified within last 24h
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    # [TASK 11] add to the toBackup array
    toBackup+=($file)
  fi
done

# [TASK 12] compress and archive the files
tar -czvf $backupFileName ${toBackup[@]}
# [TASK 13] #backupFileName in working dir, move 
mv $backupFileName $destAbsPath

# Congratulations! You completed the final project for this course!