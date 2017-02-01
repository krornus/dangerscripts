#!/bin/sh

if [ $# -ne 1 ]; then
    echo "usage: ./route.sh <domain>"
    exit 0
fi

ip=$(ping -n -q -c1 -W 1 $1 | head -n 1 | awk -F '[()]' '{print $2;}')

if [ -z $ip ]; then
    echo "No ip found for domain '$1'"
    exit 1
fi

echo "Adding '$ip' as route" 

sudo ip route add $ip dev ppp0

