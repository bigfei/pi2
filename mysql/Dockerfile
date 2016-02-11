FROM resin/rpi-raspbian:jessie
MAINTAINER Felix Xu <xuchenfei@gmail.com> 
RUN groupadd -r mysql && useradd -r -g mysql mysql

# Enable Universe and Multiverse and install dependencies.

# Run build script
ADD script/build.sh /
RUN ["/bin/bash", "/build.sh"]

VOLUME /var/lib/mysql

COPY script/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
