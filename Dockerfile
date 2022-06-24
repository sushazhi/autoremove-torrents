FROM python:3.10.5-alpine

ENV TZ Asia/Shanghai

WORKDIR /app

RUN set -ex \
        #&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories \
        && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
        && apk update \
        && apk add --no-cache \
        pip
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple        
 && pip install autoremove-torrents

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

CD config.yml

ENV OPTS '-c /app/config.yml'
ENV CRON '*/15 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]
