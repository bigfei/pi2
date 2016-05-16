#!/bin/sh

unboundpid="/var/run/unbound/unbound.pid"
adfile="/var/cache/unbound/adfile.list"
malwarefile="/var/cache/unbound/malwarefile.list"
chinalist="/var/cache/unbound/forward-zone.China.conf"
hostsfile="/var/cache/unbound/hosts.China.list"

NS1="192.168.88.254"
NS2="119.29.29.29"

adurl="http://pgl.yoyo.org/adservers/serverlist.php?hostformat=unbound&showintro=0&mimetype=plaintext"
malwareurl="http://mirror2.malwaredomains.com/files/BOOT"
chinaurl="https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"
hostsurl="https://raw.githubusercontent.com/racaljk/hosts/master/hosts"

#Ads
if [ -e $adfile ]; then rm $adfile; fi
echo "Updating $adfile"
curl -fsSL -o $adfile $adurl

#Malwares
if [ -e $malwarefile ]; then rm $malwarefile; fi
echo "Updating $malwarefile"
curl -fsSL -o $malwarefile.tmp $malwareurl
cat $malwarefile.tmp | grep "^PRIMARY" | cut -d " " -f2 > $malwarefile.tmp2
while read i; do
  echo "local-data:\"$i A 127.0.0.1\"" >> $malwarefile
done < $malwarefile.tmp2
rm $malwarefile.tmp*

#ChinaDNS
echo "Updating $chinalist"
curl -fsSL $chinaurl | grep -v '^#server' | sed 's/server=\//forward-zone:\n\tname: "/g' \
| sed "s/\/114.114.114.114/\"\n\tforward-addr: ${NS1}\n\tforward-addr: ${NS2}\n\tforward-first: yes/g" > $chinalist

#hosts
echo "Updating $hostsfile"
curl -fsSL $hostsurl | grep -v "^#" | grep . | awk '{print "local-data: \"" $2," A " $1 "\""}' > $hostsfile

#Reload
if [ -e $unboundpid ]; then kill -HUP `cat $unboundpid`; fi
