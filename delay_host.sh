#!/bin/bash
# Affect traffic to a single host. Delay and packet loss

IP1=$1
IP2=$2
DELAY=$3"ms"
VAR=$4"ms"
LOSS=$5

# Purge old policies
tc qdisc del dev eth0 root
# Add a filter chain
tc qdisc add dev eth0 root handle 1: prio
# Create a new chain for latency
tc qdisc add dev eth0 parent 1:3 handle 30: netem delay $DELAY $VAR loss $LOSS%

# Apply to a single host
tc filter add dev eth0 parent 1:0 protocol ip u32 match ip dst $IP1 flowid 1:3
tc filter add dev eth0 parent 1:0 protocol ip u32 match ip dst $IP2 flowid 1:3

