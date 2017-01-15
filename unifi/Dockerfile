FROM bigfei/alpine-arm:edge

RUN apk add curl openjdk8-jre --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    && apk add mongodb --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*
