#!/bin/bash

# Fetch Sources

cd /usr/local/src

git clone --depth 1 https://github.com/l-smash/l-smash
git clone http://git.videolan.org/git/x264.git
hg clone https://bitbucket.org/multicoreware/x265
git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx
git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git 
git clone http://git.opus-codec.org/opus.git
git clone --depth 1 https://github.com/mulx/aacgain.git

