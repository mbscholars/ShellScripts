#!/bin/sh

# CREATOR: SUNDAY MBA 
# PURPOSE: TO BE USED A CRON SCRIPT TO REGULARLY BACK UP A SELECTED DATABASE

mkdir -p backups #Create the backups folder if it does not exist
backupLocation="./backups"

time="$(date +'%d_%m_%Y_%H_%M_%S')"
backupFileName="database_backup_$time".sql #Name to store the database backUp
backupfileLocation="$backupLocation/$backupFileName"

operationLogs="$backupLocation/"db_backup_log_"$(date +'%Y_%m')".txt
echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S') ," >> "$operationLogs"

mysqldump --user=root --password= --default-character-set=utf8 print > "$backupfileLocation"

echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$operationLogs"
echo "file permission changed" >> "$operationLogs"
echo "Extract File"
echo "DB import starting"

mysql --user=root --password=  test  < $backupfileLocation
echo "DB import complete"
find "$backupLocation" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$operationLogs"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$operationLogs"
echo "*****************" >> "$operationLogs"
exit 0