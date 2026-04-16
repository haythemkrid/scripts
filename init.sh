#!/bin/bash

# Stop the script immediately if any command fails
set -e

echo "==================================================="
echo "  Starting Open5GS & Dependencies Installation"
echo "==================================================="

echo -e "\n---> 1. Updating system and installing prerequisites..."
sudo apt update
sudo apt install -y gnupg curl net-tools ca-certificates apt-transport-https software-properties-common

echo -e "\n---> 2. Installing MongoDB 8.0..."
# Import MongoDB GPG key securely
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg --yes -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
# Add MongoDB repository (Assuming Ubuntu 22.04 Jammy based on your link)
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
# Install and start MongoDB
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

echo -e "\n---> 3. Installing Open5GS Core..."
sudo add-apt-repository -y ppa:open5gs/latest
sudo apt update
sudo apt install -y open5gs

echo -e "\n---> 4. Installing Node.js 20 (Required for WebUI)..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs

echo -e "\n---> 5. Installing Open5GS WebUI..."
# The official installation script for the WebUI
curl -fsSL https://open5gs.org/open5gs/assets/webui/install | sudo -E bash -

echo "==================================================="
echo "  Installation Complete! Checking Services..."
echo "==================================================="

echo -n "MongoDB Status: "
systemctl is-active mongod

echo -n "Node.js Version: "
node -v

echo -e "\nYou can now access the Open5GS WebUI at http://localhost:9999 (or http://<your-vm-ip>:9999)"
echo "Default login -> Username: admin | Password: 1423"


# Allow the WebUI (TCP)
sudo ufw allow 9999/tcp

# Allow SCTP for NGAP (AMF <-> gNB communication)
sudo ufw allow 38412/sctp

# Allow UDP for GTP-U (UPF <-> gNB data traffic)
sudo ufw allow 2152/udp

# Allow SSH (Crucial: don't lock yourself out!)
sudo ufw allow 22/tcp

# Enable the firewall
sudo ufw enable

sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1

# IPv4 NAT
sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE

# IPv6 NAT (Optional, but good practice)
sudo ip6tables -t nat -A POSTROUTING -s 2001:db8:cafe::/48 ! -o ogstun -j MASQUERADE

sudo ufw default allow FORWARD

# 1. Installer les outils de build
sudo apt update && sudo apt install -y git build-essential cmake libsctp-dev

# 2. Télécharger le simulateur
cd /root
git clone https://github.com/aligungr/UERANSIM

# 3. Compiler (c'est ici que ta SIM virtuelle est créée)
cd UERANSIM
make -j$(nproc)
