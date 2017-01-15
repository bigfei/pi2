FROM bigfei/alpine-arm:edge
MAINTAINER Felix Xu <xuchenfei@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV UNIFI_VERSION 5.3.11

RUN apk add curl openjdk8-jre --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    && apk add mongodb --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" /etc/timezone && apk del tzdata && rm -rf /var/cache/apk/*

# Forward apporpriate ports
EXPOSE 3478/udp 6789/tcp 8080/tcp 8443/tcp 8843/tcp 8880/tcp 10001/udp

# Set internal storage volume
VOLUME ["/usr/lib/unifi/data", "/usr/lib/unifi/logs"]

# Set working directory for program
WORKDIR /usr/lib/unifi

#ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
#CMD ["start"]
