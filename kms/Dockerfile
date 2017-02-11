FROM bigfei/alpine-arm:edge
COPY vlmcsdmulti-armv7el-uclibc-static /usr/local/bin/
CMD /usr/local/bin/vlmcsdmulti-armv7el-uclibc-static vlmcsd -L 0.0.0.0:1688 -e -D
EXPOSE 1688/tcp
