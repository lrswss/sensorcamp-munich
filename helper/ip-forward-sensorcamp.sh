#!/bin/sh
# To enable network access from the 'sensorcamp-munich' containers
# activate ip forwarding and masquerading for the corresponding
# bridge interface
# 121119wss

# need to be root
if [ `whoami` != "root" ]; then
	echo "ERROR: this script needs to be run as 'root' (iptables, sysctl)."
	exit 1
fi

# get id of docker bridge interface
BID=`docker network ls | grep bridge | grep sensorcamp-munich | awk '{ print $1 }'`

if [ -n "$BID" ]; then 
	# identify corresponding IPv4 subnet 
	NET=`ifconfig br-$BID | grep 'inet ' | awk '{ print $2 }' | sed -e 's/\.1$/.0/'`

	echo "Activate IPv4 forwarding..."
	sysctl -w net.ipv4.ip_forward=1 >/dev/null

	echo "Setup masquerading for $NET/16..."
	iptables -t nat -A POSTROUTING -s $NET/16 -j MASQUERADE

	exit 0
else
	echo "ERROR: couldn't find a bridge interface for the 'sensorcamp-munich' docker stack. Is it running?"
	exit 1
fi
