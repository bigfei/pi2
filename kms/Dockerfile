FROM bigfei/alpine-arm:edge
RUN apk add --no-cache --update tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*
COPY vlmcsdmulti-armv7el-uclibc-static /usr/local/bin/
CMD /usr/local/bin/vlmcsdmulti-armv7el-uclibc-static vlmcsd -L 0.0.0.0:1688 -e -v -D
EXPOSE 1688/tcp
