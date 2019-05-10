#!/usr/bin/env bash

source $(dirname $0)/common.sh

set -x

rm $(brew --prefix)/etc/dnsmasq.conf
sudo rm -rf /etc/resolver/${MINIKUBE_INGRESS_DNS_DOMAIN}
sudo rmdir /etc/resolver
