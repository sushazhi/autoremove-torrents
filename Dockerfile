FROM python:3.10.6-alpine

ENV TZ Asia/Shanghai

WORKDIR /app

RUN apk update
RUN apk add --no-cache py3-pip
        
RUN pip install autoremove-torrents

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

COPY config.example.yml config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/15 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
