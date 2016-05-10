#!/bin/bash
# Go home BigCouch, You've had too much to drink

if [ -z "$1" ]; then
  echo "Enter your IP";
  exit;
fi

ME=$1
# allow me to talk
iptables -I INPUT 1 -s $ME/32 -d 0.0.0.0/0 -j ACCEPT
# we trust the locals
iptables -I INPUT 2 -s 127.0.0.1/0 -d 127.0.0.1/0 -j ACCEPT
# drop everyone else (cause they aren't your friends)
iptables -I INPUT 3 -s 0.0.0.0/0 -d 0.0.0.0/0 -j DROP
