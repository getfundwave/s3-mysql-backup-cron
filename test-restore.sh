export MYSQL_USERNAME=""
export MYSQL_PASSWORD=""
export SERVER="localhost"
export DB_NAME=""
export FILE_NAME="backup"
export FILE_PATH="/opt/backup/"
export BUCKET_NAME=""
VERSION="latest"
bash restore.sh $VERSION "--profile=<awsprofilename>"