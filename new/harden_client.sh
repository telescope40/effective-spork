ipset create TRUSTED hash:ip
ipset add TRUSTED 131.226.32.118
ipset add TRUSTED 52.19.38.67

iptables -A INPUT -p tcp --dport 22 -m set --match-set TRUSTED src -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP


iptables -A INPUT -p tcp -m multiport --dports 3000,9090,9579,443,80,8080,5201,9201  -m set --match-set TRUSTED src -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 3000,9090,9579,443,80,8080,5201,9201  -m set --match-set MONITORS  src -j ACCEPT

iptables-save > /etc/iptables.rules

ipset save > /etc/ipset.conf
