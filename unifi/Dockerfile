FROM resin/rpi-raspbian:latest
MAINTAINER Felix Xu <xuchenfei@gmail.com>

ENV JAVA_INSTALLER_VERSION 8u111+8u111arm-1~webupd8~0
ENV UNIFI_VERSION 5.3.11-ac65a94337

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" \
    > /etc/apt/sources.list.d/20ubiquiti.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    > /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get install -y --no-install-recommends wget \
    oracle-java8-installer=${JAVA_INSTALLER_VERSION} \
    oracle-java8-set-default && \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget https://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb && \
    dpkg --install unifi_sysvinit_all.deb ; \
    apt-get install -f && \
    apt-get -y autoremove wget && \
    apt-get -q clean && \
    rm -rf /tmp/build /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /tmp/* /var/tmp/*

RUN ln -s /var/lib/unifi /usr/lib/unifi/data
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp 10001/udp

# Set internal storage volume
VOLUME ["/usr/lib/unifi/data", "/usr/lib/unifi/logs"]

# Set working directory for program
WORKDIR /usr/lib/unifi

#ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
#CMD ["start"]
