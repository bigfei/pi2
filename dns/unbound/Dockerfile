FROM bigfei/alpine-arm:edge

RUN apk add --no-cache --update unbound curl tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*

RUN mkdir -p /var/cache/unbound && chown unbound:unbound /var/cache/unbound /var/log
COPY conf/* /etc/unbound/

COPY scripts/update_list.sh /etc/periodic/daily/
RUN chmod +x /etc/periodic/daily/update_list.sh

COPY scripts/entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/entrypoint.sh"]

