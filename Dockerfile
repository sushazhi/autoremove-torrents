FROM python:3.10.5-alpine

ENV TZ Asia/Shanghai

WORKDIR /app

RUN apk update
RUN apk add --no-cache py3-pip
        
RUN pip install autoremove-torrents

RUN touch /usr/bin/cron.sh

RUN chmod +x /usr/bin/cron.sh

RUN touch /app/autoremove-torrents.logs

RUN touch config.yml

ENV OPTS '/usr/bin/autoremove-torrents --conf=/app/config.yml --log=/app/autoremove-torrents.logs'
ENV CRON '*/15 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
