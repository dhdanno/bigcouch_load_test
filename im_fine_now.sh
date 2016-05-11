#!/bin/bash
# Let me back in, please

# wipe firewall
service iptables restart

# reset packet loss simulation
tc qdisc del dev eth0 root
