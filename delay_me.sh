#!/bin/bash

DELAY="200ms"
VAR="100ms"

tc qdisc add dev eth0 root netem delay $DELAY
tc qdisc change dev eth0 root netem delay $DELAY $VAR loss 25%

#tc qdisc change dev eth0 root netem loss 25%
