#!/bin/bash

for CERTS_CONF in /etc/kubernetes/*.conf; do
cat $CERTS_CONF |yq --raw-output '.clusters[].cluster[]' |grep -v https |base64 -d > "$CERTS_CONF-d"
printf '%s: %s\n' \
"$(date --date="$(openssl x509 -enddate -noout -in "$CERTS_CONF-d"|cut -d= -f 2)" --iso-8601)" \
"$CERTS_CONF"
rm -f "$CERTS_CONF-d"
done > /tmp/k8s-certs-verified.out

for CERTS_CRT in /etc/kubernetes/pki/*.crt; do
printf '%s: %s\n' \
"$(date --date="$(openssl x509 -enddate -noout -in "$CERTS_CRT"|cut -d= -f 2)" --iso-8601)" \
"$CERTS_CRT"
done >> /tmp/k8s-certs-verified.out

for CERTS_CRT in /etc/kubernetes/pki/etcd/*.crt; do
printf '%s: %s\n' \
"$(date --date="$(openssl x509 -enddate -noout -in "$CERTS_CRT"|cut -d= -f 2)" --iso-8601)" \
"$CERTS_CRT"
done >> /tmp/k8s-certs-verified.out

cat /tmp/k8s-certs-verified.out |sort
