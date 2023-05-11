#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# List of domain names to route through the VPN
domains=(${MY_VPN_DOMAINS})
total=${#domains[@]}

# Check if the current default route is through the non-VPN connection
current_default=$(ip route show | grep -m1 '^default' | awk '{print $5}')
if [ "$current_default" == "$MY_INET_IFACE" ]; then
    # Change the default route back to the VPN
    echo -e "${GREEN}Switching default route back to VPN...${NC}"
    sudo ip route del default dev $MY_INET_IFACE
    sudo ip route add default dev ppp0
fi

# remove any old rules for these domains
echo -e "${GREEN}Removing old rules...${NC}"
for domain in "${domains[@]}"; do
    for ip in $(ip route show | grep -oP '(\d{1,3}\.){3}\d{1,3}(?= dev ppp0)'); do
        sudo ip route del $ip dev ppp0
    done
done
echo -e "${GREEN}Done.${NC}"

# add a route to connect to VATS through the VPN
echo -e "${GREEN}Adding route for VATS...${NC}"
sudo ip route add "${VATS_DOMAIN}" dev ppp0 >/dev/null 2>&1
echo -e "${GREEN}Done.${NC}"

# resolve current IP addresses for these domains
echo -e "${GREEN}Adding new rules...${NC}"
for domain in "${domains[@]}"; do
    echo "Processing $domain ..."
    for ip in $(getent ahostsv4 $domain | awk '{ print $1 }' | sort -u); do
        sudo ip route add $ip dev ppp0 >/dev/null 2>&1
    done
done
echo -e "${GREEN}Done.${NC}"

# Change default route
echo -e "${GREEN}Switching default route to non-VPN connection...${NC}"
sudo ip route del default dev ppp0
sudo ip route add default via "${MY_GATEWAY}" dev "${MY_INET_IFACE}"
echo -e "${GREEN}Done.${NC}"
