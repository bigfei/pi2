# ZoneMinder

FROM bigfei/rpi-ffmpeg:latest 
MAINTAINER Felix Xu <xuchenfei@gmail.com> 
EXPOSE 80

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Adding the build script
ADD build.sh /
RUN ["/bin/bash", "/build.sh"]

# Configure the script
ADD configure.sh /
RUN ["/bin/bash", "/configure.sh"]
