#!/bin/bash

IP=$1
DELAY="200ms"
VAR="10ms"

tc qdisc add dev eth0 root netem delay $DELAY
tc qdisc change dev eth0 root netem delay $DELAY $VAR loss 30%

#tc qdisc change dev eth0 root netem loss 25%

