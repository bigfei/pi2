FROM bigfei/alpine-arm:edge

ENV LISTEN_ADDR 0.0.0.0:5353
ENV RESOLVER_ADDR 208.67.220.220:443
ENV PROVIDER_NAME 2.dnscrypt-cert.opendns.com
ENV PROVIDER_KEY B735:1140:206F:225D:3E2B:D822:D7FD:691E:A1C3:3CC8:D666:8D0C:BE04:BFAB:CA43:FB79

RUN apk add dnscrypt-proxy curl minisign --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY ./entrypoint.sh /

EXPOSE 5353/tcp 5353/udp

ENTRYPOINT ["/entrypoint.sh"]
