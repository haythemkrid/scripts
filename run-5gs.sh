#!/bin/bash

# Chemins des fichiers
UERANSIM_DIR="/root/UERANSIM"
GNB_CONFIG="$UERANSIM_DIR/config/open5gs-gnb.yaml"
UE_CONFIG="$UERANSIM_DIR/config/open5gs-ue.yaml"

echo "--- Préparation de la simulation UERANSIM ---"

# 1. Configuration du gnb
cat <<EOF > /root/UERANSIM/config/open5gs-gnb.yaml
mcc: '001'
mnc: '01'
nci: '0x00000001'
idLength: 32
tac: 1
linkIp: 127.0.0.1
ngapIp: 127.0.0.1
gtpIp: 127.0.0.10
amfConfigs:
  - address: 127.0.0.1
    port: 38412
ignoreStreamIds: true
slices:
  - sst: 1
EOF

# 2. Configuration de l'UE - Ajout de TOUTES les Access Classes
cat <<EOF > $UE_CONFIG
supi: 'imsi-001010000000001'
mcc: '001'
mnc: '01'
key: '465B5CE8B199B49FAA5F0A2EE238A6BC'
op: 'E8ED289DEBA952E4283B54E88E6183CA'
opType: 'OP'
amf: '8000'
imei: '354495320353015'
imeisv: '4370816125816151'

# UAC (Unified Access Control) complet
uacAic:
  mps: false
  mcs: false
uacAcc:
  normalClass: 0
  class11: false
  class12: false
  class13: false
  class14: false
  class15: false
  emergency: false
  mps: false
  mcs: false

# Sécurité et Débit
integrity:
  IA1: true
  IA2: true
  IA3: true
ciphering:
  EA1: true
  EA2: true
  EA3: true
integrityMaxRate:
  uplink: 'full'
  downlink: 'full'
cipheringMaxRate:
  uplink: 'full'
  downlink: 'full'

gnbSearchList:
  - 127.0.0.1

sessions:
  - type: 'IPv4'
    apn: 'internet'
    slice:
      sst: 1

configured-nssai:
  - sst: 1

default-nssai:
  - sst: 1
EOF

echo "--- Nettoyage des processus ---"
sudo pkill nr-ue 2>/dev/null
sudo pkill nr-gnb 2>/dev/null
sleep 1

echo "--- Lancement du gNodeB ---"
sudo $UERANSIM_DIR/build/nr-gnb -c $GNB_CONFIG > gnb.log 2>&1 &

sleep 2

echo "--- Lancement de l'UE ---"
sudo $UERANSIM_DIR/build/nr-ue -c $UE_CONFIG
