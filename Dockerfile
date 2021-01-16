FROM alpine:latest
LABEL maintainer="mohit@getfundwave.com"

RUN apk update && apk add --no-cache python3 py3-pip && pip3 install --upgrade pip && pip3 install awscli && apk add mysql-client && apk add bash && apk add openssl && apk add coreutils && mkdir -p /opt/backup
ARG HOUR_OF_DAY
#ENV CRON_HOUR=${HOUR_OF_DAY:-23}

WORKDIR /opt/backup
COPY crontab.txt crontab.txt
COPY mysql-backup.sh mysql-backup.sh
COPY backup.sh backup.sh
COPY clean.sh clean.sh
COPY entry.sh entry.sh
COPY script.sh script.sh
RUN chmod 750 mysql-backup.sh backup.sh clean.sh script.sh entry.sh
RUN if [[ -n "$HOUR_OF_DAY" ]] ; then echo $HOUR_OF_DAY && sed -i "s/23/$HOUR_OF_DAY/g" crontab.txt && cat crontab.txt ; else echo "Defaulting to cron hour 23" ; fi
RUN /usr/bin/crontab crontab.txt

CMD ["/opt/backup/entry.sh"]
