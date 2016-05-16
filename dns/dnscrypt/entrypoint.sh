#!/bin/sh
RESOLVERS_UPDATES_BASE_URL=https://download.dnscrypt.org/dnscrypt-proxy
RESOLVERS_LIST_BASE_DIR=/usr/share/dnscrypt-proxy
RESOLVERS_LIST_PUBLIC_KEY="RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"

curl -L --max-redirs 5 -4 -m 30 --connect-timeout 30 -s "${RESOLVERS_UPDATES_BASE_URL}/dnscrypt-resolvers.csv" >  "${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv.tmp"  && 
curl -L --max-redirs 5 -4 -m 30 --connect-timeout 30 -s  "${RESOLVERS_UPDATES_BASE_URL}/dnscrypt-resolvers.csv.minisig" > "${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv.minisig" && 
#minisign -Vm ${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv.tmp -x "${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv.minisig" -P "$RESOLVERS_LIST_PUBLIC_KEY" -q && 
mv -f ${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv.tmp ${RESOLVERS_LIST_BASE_DIR}/dnscrypt-resolvers.csv

exec dnscrypt-proxy --local-address=$LISTEN_ADDR \
                    --provider-name=$PROVIDER_NAME \
                    --provider-key=$PROVIDER_KEY \
                    --resolver-address=$RESOLVER_ADDR \
                    --user=dnscrypt
