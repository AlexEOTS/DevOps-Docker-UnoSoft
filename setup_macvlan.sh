#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

# Create macvlan interface to establish connection with container host
ip link add macvlan0 link enp0s3 type macvlan mode bridge
ip addr add 192.168.1.199/32 dev macvlan0
ip link set macvlan0 up
ip route add 192.168.1.200/30 dev macvlan0
ip link set enp0s3 promisc on

cp "${SCRIPT_DIR}/setup_macvlan.service" /etc/systemd/system/setup_macvlan.service

systemctl daemon-reload

systemctl enable setup_macvlan.service