#!/bin/sh

# CREATOR: SUNDAY MBA 
# PURPOSE: TO BE USED A CRON SCRIPT TO REGULARLY BACK UP AN OLD DATABASE AND IMPORT CONTENTS INTO THE NEW

#DATABASE PARAMETERS
oldDB_database="laravel"
oldDB_user="root"
oldDB_password=""
newDB_database="test"
newDB_user="root"
newDB_password=""
db_host="localhost"
db_port="3306"


mkdir -p backups #Create the backups folder if it does not exist
backupLocation="./backups"

time="$(date +'%d_%m_%Y_%H_%M_%S')"
backupFileName="database_backup_$time".sql #Name to store the database backUp
backupfileLocation="$backupLocation/$backupFileName"

operationLogs="$backupLocation/"db_backup_log_"$(date +'%Y_%m')".txt
echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S') ," >> "$operationLogs"

mysqldump --user=$oldDB_user --password=$oldDB_password -h $db_host -P $db_port --default-character-set=utf8 $oldDB_database > "$backupfileLocation"

echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$operationLogs"
echo "file permission changed" >> "$operationLogs"
echo "DB import starting"

mysql --user=$newDB_user --password=$newDB_password -h $db_host -P $db_port $newDB_database  < $backupfileLocation
echo "DB import complete"
unlink $backupfileLocation 
echo "old files deleted" >> "$operationLogs"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$operationLogs"
echo "*****************" >> "$operationLogs"
exit 0