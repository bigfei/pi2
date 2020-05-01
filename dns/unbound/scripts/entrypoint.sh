#!/bin/sh

#Delete old root-anchors files
rm -f /var/cache/unbound/root-anchors.txt
echo "Updating root-anchors..."
unbound-anchor -a /var/cache/unbound/root-anchors.txt
chown unbound:unbound /var/cache/unbound/root*

sed -i "s/192\\.168\\.88\\.254/$DNS1/; s/119\\.29\\.29\\.29/$DNS2/" /etc/periodic/daily/update_list

/etc/periodic/daily/update_list

reserved=12582912
availableMemory=$((1024 * $( (fgrep MemAvailable /proc/meminfo || fgrep MemTotal /proc/meminfo) | sed 's/[^0-9]//g' ) ))
if [ $availableMemory -le $(($reserved * 2)) ]; then
    echo "Not enough memory" >&2
    exit 1
fi
availableMemory=$(($availableMemory - $reserved))
msg_cache_size=$(($availableMemory / 3))
rr_cache_size=$(($availableMemory / 3))
nproc=$(getconf _NPROCESSORS_ONLN)
if [ $nproc -gt 1 ]; then
    threads=$(($nproc - 1))
else
    threads=1
fi

threads=1 #it seems cannot support multiple threads

FORWARD_ADDR=${1:-$FORWARD_ADDR}
FORWARD_PORT=${2:-$FORWARD_PORT}
echo "Env FORWARD_ADDR as ${FORWARD_ADDR} and FORWARD_PORT as ${FORWARD_PORT}"
FORWARD_ADDR=`nslookup $FORWARD_ADDR 2>&1 |  awk  'NR==4 { print $3 } '`
echo "Setting FORWARD_ADDR as ${FORWARD_ADDR} and FORWARD_PORT as ${FORWARD_PORT}"
BIND=`nslookup $BIND 2>&1 |  awk  'NR==4 { print $3 } '`
echo "Setting BIND as ${BIND}"

sed \
    -e "s/@MSG_CACHE_SIZE@/${msg_cache_size}/" \
    -e "s/@RR_CACHE_SIZE@/${rr_cache_size}/" \
    -e "s/@THREADS@/${threads}/" \
    -e "s/%BIND%/${BIND}/" \
    -e "s/%FORWARD_ADDR%/${FORWARD_ADDR}/" \
    -e "s/%FORWARD_PORT%/${FORWARD_PORT}/" \
    > /etc/unbound/unbound.conf < /etc/unbound/unbound.conf.example

#Run unbound
echo "Starting unbound"
crond -l 2
exec unbound -d
