#!/bin/bash
#This Scipt set ups the iperf servers to run iperf as a service , create iptables rules to permit selective access

set -e

# Install iperf3 and ipset if not already installed
apt update
apt install -y iperf3 ipset iptables

# Create systemd service for iperf3
cat <<EOF > /etc/systemd/system/iperf3.service
[Unit]
Description=iperf3 server
After=network.target

[Service]
ExecStart=/usr/bin/iperf3 -s
Restart=on-failure
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable iperf3
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable --now iperf3

# Set up ipset for allowed monitor IPs
ipset create MONITORS hash:ip || true

# Insert iptables rules
iptables -I INPUT -m set --match-set MONITORS src -p tcp --dport 5201 -j ACCEPT
iptables -I INPUT -m set --match-set MONITORS src -p udp --dport 5201 -j ACCEPT

# Optionally drop non-monitored traffic (uncomment to enforce)
iptables -A INPUT -p tcp --dport 5201 -j DROP
iptables -A INPUT -p udp --dport 5201 -j DROP

echo "Setup complete. Add IPs to MONITORS set using:"
ipset add MONITORS 45.63.5.21
ipset add MONITORS  95.179.176.52
ipset add MONITORS  155.138.160.21
ipset add MONITORS  149.28.95.66
ipset add MONITORS  216.238.71.196
ipset add MONITORS  104.207.146.55
ipset add MONITORS  45.63.5.21
ipset add MONITORS  64.176.12.93
ipset add MONITORS  64.176.168.105
