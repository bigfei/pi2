FROM debian:stretch-slim as tini
ENV TINI_VERSION v0.18.0
ENV TINI_ARCH -armhf

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      gnupg \
      dirmngr \
      apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/build && \
	cd /tmp/build && \
	wget -O tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static${TINI_ARCH} && \
	cp tini /sbin/ && \
	chmod +x /sbin/tini && \
	cd /tmp && \
	rm -rf /tmp/build

FROM multiarch/qemu-user-static:arm as qemu

FROM arm32v7/openjdk:8-slim-stretch
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
COPY --from=tini /sbin/tini /sbin/tini

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      gnupg \
      dirmngr \
    && rm -rf /var/lib/apt/lists/* && \
    wget https://archive.raspbian.org/raspbian.public.key -O - | apt-key add - && \
    echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free' >> /etc/apt/sources.list

# Install any version from deb download
# Use dpkg to mark the package for install (expect it to fail to complete the installation)
# Use apt-get install -f to complete the installation with dependencies
ENV UNIFI_VERSION 5.12.72
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
      mkdir -p /tmp/build && \
      cd /tmp/build && \
      wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg && \
      wget https://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb && \
      apt-get update && apt-get install -y --no-install-recommends \
        ./unifi_sysvinit_all.deb \
        procps && \
      rm -rf /var/lib/apt/lists/* && \
      rm -rf /tmp/build

RUN ln -s /var/lib/unifi /usr/lib/unifi/data
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp 10001/udp
VOLUME ["/usr/lib/unifi/data", "/usr/lib/unifi/logs", "/etc/ssl/certs"]

COPY unifi_ssl_import.sh /
WORKDIR /var/lib/unifi
ENV JAVA_OPTS -Xmx512M

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
CMD ["start"]
