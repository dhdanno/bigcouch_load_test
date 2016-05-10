#!/bin/bash
# You've had too much to drink

if [ -z "$1" ]; then
  echo "Enter your IP";
  exit;
fi

ME=$1
# allow me to talk
iptables -I INPUT 1 -s $ME/32 -d 0.0.0.0/0 -j ACCEPT
# drop everyone else
iptables -I INPUT 2 -s 0.0.0.0/0 -d 0.0.0.0/0 -j DROP
