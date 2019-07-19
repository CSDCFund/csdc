#!/bin/bash

case "$1" in
start)
    echo 1|  tee /proc/sys/net/ipv4/ip_forward
    iptables-restore < /etc/iptables.rules
    ;;
stop|restart|reload|force-reload)
    ;;
esac

exit 0
