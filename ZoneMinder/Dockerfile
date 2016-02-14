# ZoneMinder

FROM bigfei/rpi-ffmpeg:latest 
MAINTAINER Felix Xu <xuchenfei@gmail.com> 

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Adding the build script

ADD build.sh /
RUN ["/bin/bash", "/build.sh"]

ADD zoneminder.conf /etc/apache2/conf-available/zoneminder.conf
ADD zm.sh /

EXPOSE 80

CMD ["/zm.sh"]
