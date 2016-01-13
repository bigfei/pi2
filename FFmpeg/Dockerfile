FROM resin/raspberrypi2-buildpack-deps:jessie-scm
MAINTAINER Felix Xu <xuchenfei@gmail.com> 

# Enable Universe and Multiverse and install dependencies.
RUN echo deb http://archive.ubuntu.com/ubuntu trusty universe multiverse >> /etc/apt/sources.list; apt-get update; apt-get -y install autoconf automake build-essential git mercurial cmake libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget yasm; apt-get clean

#ADD script/clone.sh /usr/local/src
#RUN ["/bin/bash", "/usr/local/src/clone.sh"]

# Run build script
ADD script/build.sh /usr/local/src
RUN ["/bin/bash", "/usr/local/src/build.sh"]

