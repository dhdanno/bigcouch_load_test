#!/bin/bash
# Go home BigCouch, You've had too much to drink

TYPE="REJECT"

## IMPORTANT ##
# You must run this first WITHOUT an argument first and then apply the argument
# otherwise rules get pushed out

# Enter the IP you want to allow access from/to
if [ -n "$1" ]; then
  echo "Access will be allowed from and to :$1";
  iptables -I INPUT 1 -s $1/32 -j ACCEPT
  iptables -I OUTPUT 1 -d $1/32 -j ACCEPT
  exit
fi


# This definately works, i've tested other localhost ports with telnet
iptables -I OUTPUT 1 -d 74.114.208.8/32 -j ACCEPT
iptables -I INPUT 1 -s 74.114.208.8/32 -j ACCEPT
iptables -I OUTPUT 2 -d 74.114.208.0/21 -j $TYPE
iptables -I INPUT 2 -s 74.114.208.0/21 -d 74.114.208.0/21 -j $TYPE

# tor1 servers
iptables -I OUTPUT 2 -d 104.193.16.172/32 -j $TYPE
iptables -I OUTPUT 2 -d 104.193.16.132/32 -j $TYPE
iptables -I INPUT 2 -s 104.193.16.172/32 -j $TYPE
iptables -I INPUT 2 -s 104.193.16.132/32 -j $TYPE



