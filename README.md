# EXPORT AND IMPORT DB TO ANOTHER DB

This program enables you to export a specified database and import it into another existing database. 
STEPS:
  - edit the database information to suit your use case
  - The backup_with_compression enables gzip compression while exporting the database

## HOW IT WORKS
- Specify the old and new database information

```sh
oldDB_database="laravel"
oldDB_user="root"
oldDB_password=""
newDB_database="test"
newDB_user="root"
newDB_password=""
db_host="localhost"
db_port="3306"

```
- The script exports the old database and imports into the new
- After which deletes the files but reserves the logs
- To prevent deletion, comment the unlink command