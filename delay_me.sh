#!/bin/bash

IP=$1
DELAY="100ms"
VAR="50ms"

tc qdisc add dev eth0 root netem delay $DELAY
tc qdisc change dev eth0 root netem delay $DELAY $VAR loss 10%

#tc qdisc change dev eth0 root netem loss 25%

