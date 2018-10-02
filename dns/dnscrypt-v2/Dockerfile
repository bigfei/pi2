FROM bigfei/alpine-arm:edge

RUN apk add dnscrypt-proxy ca-certificates --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
COPY ./dnscrypt-proxy.toml /
EXPOSE 5353/tcp 5353/udp

CMD ["dnscrypt-proxy", "-config", "/dnscrypt-proxy.toml"]
