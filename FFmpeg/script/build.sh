#!/bin/bash
#set -e
#echo deb http://archive.ubuntu.com/ubuntu trusty universe multiverse >> /etc/apt/sources.list
apt-get update
apt-get dist-upgrade
apt-get -y install autoconf automake build-essential git cmake libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget yasm libasound2-dev libfreetype6-dev

cd /usr/local/src

git clone --depth 1 https://github.com/l-smash/l-smash
git clone https://github.com/mirror/x264.git 
#git clone https://github.com/videolan/x265.git
git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx
git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git
git clone https://github.com/xiph/opus.git 
git clone --depth 1 https://github.com/mulx/aacgain.git


# Build L-SMASH

cd /usr/local/src/l-smash
./configure
make -j 8
make install

# Build libx264

cd /usr/local/src/x264
./configure --enable-static
make -j 8
make install


# Build libfdk-aac

cd /usr/local/src/fdk-aac
autoreconf -fiv
./configure --disable-shared
make -j 8
make install

# Build libvpx

cd /usr/local/src/libvpx
./configure --disable-examples
make -j 8
make install

# Build libopus

cd /usr/local/src/opus
./autogen.sh
./configure --disable-shared
make -j 8
make install

# Build libx265
#export CXXFLAGS="$CXXFLAGS -fPIC"
#cd /usr/local/src/x265/build/linux
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_REQUIRED_FLAGS:STRING="-fPIC" ../../source
#make -j 8
#make install

# Build aacgain

cd /usr/local/src/aacgain/mp4v2
./configure && make -k -j 8 # some commands fail but build succeeds
cd /usr/local/src/aacgain/faad2
./configure && make -k -j 8 # some commands fail but build succeeds
cd /usr/local/src/aacgain
./configure && make -j 8 && make install

# Build ffmpeg.

cd /usr/local/src/FFmpeg
./configure --extra-libs="-ldl" --enable-libfreetype --enable-gpl --enable-libass --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-nonfree
make -j 8
make install


# Remove all tmpfile 

rm -rf /usr/local/src
apt-get clean 
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
