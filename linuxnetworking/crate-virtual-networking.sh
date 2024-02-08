#!/bin/bash

## Show root namepace network configuration
echo "Showing root namesapce network configuration..."

echo "# Network devices"
ip link list

echo -e "\n# Route table"
ip route list

echo -e "\n# iptables rules"
iptables --list-rules


# create custome firewall chain

iptables --new-chain MY_CUSTOM_CHAIN

echo "Creating first container netns0..."
ip netns add netns0
ip netns list

echo "Checking network configuration in netns0 container ..."
nsenter --net=/run/netns/netns0 bash -c "ip addr;ip link"

# Connecting containers to host using virtual Ethernet devices (veth)
echo "Creating virutal interface veth0@ceth0..."
ip link add veth0 type veth peer name ceth0
ip link list

echo "Attache ceth0 to container netns0..."
ip link set ceth0 netns netns0

ip link list

echo "Enabling veth0 link..."
ip link set veth0 up

echo "Configuring ip address to veth0: 172.18.0.11/16 ..."
ip addr add 172.18.0.11/16 dev veth0

echo "Enabling ceth0 link..."
nsenter --net=/run/netns/netns0 bash -c "ip link set ceth0 up"
echo "Configuring ip address to ceth0: 172.18.0.10/16 ..."
nsenter --net=/run/netns/netns0 bash -c "ip addr add 172.18.0.10/16 dev ceth0"

echo "checking connection from ceth0:172.18.0.10 to veth0:172.18.0.11.."
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 172.18.0.11"
echo "checking connection from veth0:172.18.0.11 to ceth0:172.18.0.10.."
ping -c 2 172.18.0.10

echo "Check if outside network is reachable 8.8.8.8 ...."
nsenter --net=/run/netns/netns0 bash -c "ping -c 4 8.8.8.8"


echo "Checking current root namespace routing table..."
ip route list

# Creating the second container repeating the same steps
echo "#############"
echo "Creating second container netns1 adding veth1:172.18.0.21 ceth1:172.18.0.20 ..."
ip netns add netns1

ip link add veth1 type veth peer name ceth1
ip link set veth1 up
ip addr add 172.18.0.21/16 dev veth1

ip link set ceth1 netns netns1

echo "Configuring ceth1:172.18.0.20 ip address..."
nsenter --net=/run/netns/netns1 bash -c "ip link set ceth1 up;ip addr add 172.18.0.20/16 dev ceth1"
echo "Check connectivity to veth1:172.18.0.21 ..."
nsenter --net=/run/netns/netns1 bash -c "ping -c 2 172.18.0.21"

echo "Checking namespace netns1 route table...."
nsenter --net=/run/netns/netns1 bash -c "ip route list"

echo "Checking connectivity between netns0 and netns1"
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 172.18.0.20"

echo "Checking root namespace route table..."
ip route list

#ip route delete 172.18.0.0/16 dev veth0 proto kernel scope link src 172.18.0.11

# Interconnecting containers using a virtual network switch (bridge)

echo "###############"
echo "Creating a bridge br0..."
ip link add br0 type bridge
ip link set br0 up

echo "Connecting veth1, and veth0 to bridge br0.."
ip link set veth0 master br0
ip link set veth1 master br0

echo "It's time to check the connectivity again!"
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 172.18.0.20"
echo "Second container to the first:"

nsenter --net=/run/netns/netns1 bash -c "ping -c 2 172.18.0.10"
echo "echo checking neighbour.."
nsenter --net=/run/netns/netns0 ip neigh
nsenter --net=/run/netns/netns1 ip neigh

## Reaching out to the outside world (IP routing and masquerading)

echo "Checking connection to host ip from netns0..."
nsenter --net=/run/netns/netns0 "ping -c 2 10.128.0.2"

echo "Checking connection to host ip from netns1..."
nsenter --net=/run/netns/netns1 "ping -c 2 10.128.0.2"

echo "Checking route table: netns0..."
nsenter --net=/run/netns/netns0 ip route list

echo "Checking route table: netns1..."
nsenter --net=/run/netns/netns1 ip route list

# To establish the connectivity between the root and container namespaces, we need to assign the IP address to the bridge network interface:
echo "Configuring ip address to br0.."
ip addr add 172.18.0.1/16 dev br0

echo "Checking ip route list of root namespace..."
ip route list

echo "Root namespace to the first container:"
ping -c 2 172.18.0.10
echo "Root namespace to the second container:"
ping -c 2 172.18.0.20

nsenter --net=/run/netns/netns0 bash -c "ip route add default via 172.18.0.1"
nsenter --net=/run/netns/netns1 bash -c "ip route add default via 172.18.0.1"


echo "Confirming the containers-to-host connectivity"
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 172.16.0.2"

echo 1 > /proc/sys/net/ipv4/ip_forward

echo "Checking internet reachability...."
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 8.8.8.8"

echo "Enabling NAT..."
iptables -t nat -A POSTROUTING -s 172.18.0.0/16 ! -o br0 -j MASQUERADE

echo "Checking internet connectivity...."
nsenter --net=/run/netns/netns0 bash -c "ping -c 2 8.8.8.8"












