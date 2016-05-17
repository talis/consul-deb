#!/bin/bash

set -e

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

if [ -z "$1" ]; then
    VERSION="0.6.4"
else
    VERSION=$1
fi

rm *.deb

wget -N "https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip"
unzip -o "consul_${VERSION}_linux_amd64.zip" -d usr/bin

fpm -s dir -t deb -n consul -v $VERSION usr/bin/consul
