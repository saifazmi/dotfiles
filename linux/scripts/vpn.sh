#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "Usage: vpn [country_code] [server_number]"
    exit
fi

COUNTRY=$1
SERVER=$2

sudo openvpn \
    --config /etc/openvpn/ovpn_tcp/"$COUNTRY""$SERVER".nordvpn.com.tcp.ovpn \
    --script-security 2 \
    --setenv PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
    --up /etc/openvpn/scripts/update-systemd-resolved \
    --down /etc/openvpn/scripts/update-systemd-resolved \
    --down-pre
