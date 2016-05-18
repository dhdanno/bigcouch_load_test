#!/bin/bash
# Affect traffic to a single host. Delay and packet loss

IP=$1
DELAY=$2"ms"
VAR=$3"ms"
LOSS=$4


# Purge old policies
tc qdisc del dev eth0 root
# Add a filter chain
tc qdisc add dev eth0 root handle 1: prio
# Create a new chain for latency
tc qdisc add dev eth0 parent 1:1 handle 2: netem delay $DELAY
# Modify it adding loss and variable latency
tc qdisc change dev eth0 parent 1:1 handle 2: netem delay $DELAY $VAR loss $LOSS%
# Apply to a single host
tc filter add dev eth0 parent 1:0 protocol ip pref 55 handle ::55 u32 match ip dst $IP flowid 2:1
