#!/bin/bash

IP=$1
DELAY=$2"ms"
VAR=$3"ms"
LOSS=$4

tc qdisc add dev eth0 root netem delay $DELAY
tc qdisc change dev eth0 root netem delay $DELAY $VAR loss $LOSS%

#tc qdisc change dev eth0 root netem loss 25%

