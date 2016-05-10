#!/bin/bash
# Let me back in, please

# Do this in reverse order or die.
iptables -D INPUT 2
iptables -D INPUT 1
