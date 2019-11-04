#!/bin/bash
ipset destroy chnroute
ipset -N chnroute hash:net maxelem 65536

CNIPS=`curl -fsSL https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/china.txt`
for ip in $CNIPS; do
  ipset add chnroute $ip
done

echo "ipset done"

iptables -t mangle -N fwmark
echo "new fwmark"

iptables -t mangle -C OUTPUT -j fwmark || iptables -t mangle -A OUTPUT -j fwmark
echo "output done"

iptables -t mangle -C PREROUTING -j fwmark || iptables -t mangle -A PREROUTING -j fwmark
echo "prerouting done"

iptables -t mangle -A fwmark -d moon.bigfei.me -j RETURN
echo "return done"

iptables -t mangle -A fwmark -m set ! --match-set chnroute dst -j MARK --set-mark 0xffff
echo "mark 0xffff done"

wg-quick up wg0

