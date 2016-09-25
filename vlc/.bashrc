# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
alias nvlc="nohup /usr/bin/cvlc v4l2:///dev/video0:chroma=h264:width=1920:height=1080 :input-slave=\"alsa://hw:1,0\" --sout '#duplicate{dst=\"transcode{acodec=a52,ab=32}:standard{access=http,mux=ts,dst=:8090}\", dst=\"transcode{acodec=a52,channels=1,ab=32}:standard{access=http,mux=asf,dst=:8091}\", select=\"novideo\",dst=\"standard{access=http,mux=ts,dst=:8092,name=stream,mime=video/ts}\", select=\"noaudio\"' &"

alias rvlc="nohup /usr/bin/cvlc v4l2:///dev/video0:chroma=h264:width=1920:height=1080 :input-slave=\"alsa://hw:1,0\" --sout '#duplicate{dst=\"transcode{acodec=a52,ab=32}:rtp{sdp=rtsp://:8554/live}\", dst=\"transcode{acodec=a52,channels=1,ab=32}:rtp{sdp=rtsp://:8554/live_audio}\", select=\"novideo\",dst=\"rtp{sdp=rtsp://:8554/live_video}\", select=\"noaudio\"' &"
