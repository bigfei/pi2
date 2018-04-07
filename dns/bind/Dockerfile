FROM bigfei/alpine-arm:edge

RUN apk add --no-cache --update bind curl tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*

COPY conf/ /etc/bind/

VOLUME /etc/bind

EXPOSE 53/udp 53/tcp 953/tcp

CMD ["/usr/sbin/named", "-f", "-g"]
