#!/bin/bash
# Go home BigCouch, You've had too much to drink

#if [ -z "$2" ]; then
#  echo "Enter your IP and Gateway";
#  exit;
#fi

ME=$1

# This definately works, i've tested other localhost ports with telnet
iptables -I OUTPUT 1 -d 74.114.208.8/32 -j ACCEPT
iptables -I INPUT 1 -s 74.114.208.8/32 -j ACCEPT
iptables -I OUTPUT 2 -d 74.114.208.0/21 -j DROP
iptables -I INPUT 2 -s 74.114.208.0/21 -d 74.114.208.0/21 -j DROP
