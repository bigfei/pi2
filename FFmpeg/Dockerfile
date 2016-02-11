FROM resin/raspberrypi2-buildpack-deps:jessie-scm
MAINTAINER Felix Xu <xuchenfei@gmail.com> 

#ADD script/clone.sh /usr/local/src
#RUN ["/bin/bash", "/usr/local/src/clone.sh"]

# Run build script
ADD script/build.sh /usr/local/src
RUN ["/bin/bash", "/usr/local/src/build.sh"]

