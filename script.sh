#!/bin/bash

SERVER=${SERVER:-"db"}
FILE_NAME=${FILE_NAME:-"backup"}
CURRENT_DIR=$(dirname $0)

echo "Step 1. Mysqldump"
$CURRENT_DIR/mysql-backup.sh $MYSQL_USERNAME $MYSQL_PASSWORD $SERVER $DB_NAME $FILE_NAME $FILE_PATH
echo "Step 2. Saving to S3"
$CURRENT_DIR/backup.sh $FILE_NAME $BUCKET_NAME
echo "Step 3. Cleaning it up"
$CURRENT_DIR/clean.sh $FILE_NAME
echo "Done"
