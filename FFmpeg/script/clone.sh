#!/bin/bash
#echo deb http://archive.ubuntu.com/ubuntu trusty universe multiverse >> /etc/apt/sources.list
apt-get update
apt-get dist-upgrade
apt-get -y install autoconf automake build-essential git mercurial cmake libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget yasm libasound2-dev libfreetype6-dev

cd /usr/local/src

git clone --depth 1 https://github.com/l-smash/l-smash
git clone https://github.com/mirror/x264.git
#git clone https://github.com/videolan/x265.git
git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx
git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git
git clone https://github.com/xiph/opus.git
git clone --depth 1 https://github.com/mulx/aacgain.git

