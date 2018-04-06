FROM bigfei/alpine-arm:edge

RUN apk add --no-cache --update dhcp curl tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*

COPY conf/* /etc/dhcp/

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME /var/lib/dhcp

EXPOSE 67/udp

ENTRYPOINT ["/entrypoint.sh"]
