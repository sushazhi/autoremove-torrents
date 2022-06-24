FROM python:3.10.5-alpine

ENV TZ Asia/Shanghai

WORKDIR /app

RUN apk update
RUN apk add --no-cache py3-pip
        
RUN pip install autoremove-torrents

RUN touch /usr/bin/cron.sh

RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

RUN touch config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/15 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
