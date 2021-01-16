How to run:
==========

1. Build the image

docker build -t backups .

2. Run the image

docker run -idt backups --env MYSQL_USERNAME=<> --env MYSQL_PASSWORD=<> --env SERVER=<> --env DB_NAME=<> --env BUCKET=<abc.bucket.com> --env AWS_ACCESS_KEY_ID=<> --env AWS_SECRET_ACCESS_KEY=<> --env HOUR_OF_DAY=23

3. Connect to the network of your DB container (Only when DB is in another container)

docker network connect <network_name> <backup_container>

4. Verify backups manually

docker exec -it <backup_container> bash

Inside the container: sh script.sh



How to run (docker-compose):
==========================

Add this to your docker compose:

  backups:
    build:
      context: ./backups
      args:
        HOUR_OF_DAY: 23
    depends_on:
      - <"db">
    networks:
      - <db>
    environment:
      - BUCKET_NAME=<abc.bucket.com>
      - MYSQL_USERNAME=
      - MYSQL_PASSWORD=
      - SERVER=
      - DB_NAME=
      # Specify AWS credentials or skip if using AWS IAM roles 
      - AWS_ACCESS_KEY_ID=
      - AWS_SECRET_ACCESS_KEY=
      # The path of the DB dump in the container, not the host machine
      - FILE_PATH=/opt/backup/     
    restart: always

Replace build: with image: if using dockerhub instead of local folder
