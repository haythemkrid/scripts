#!/bin/bash

# Vérification des privilèges root
if [ "$EUID" -ne 0 ]; then 
  echo "Veuillez lancer ce script en tant que root (sudo ./config.sh)"
  exit
fi

# 1. On force l'IP à 127.0.0.1 pour éviter les problèmes de Firewall VPS
# Cela garantit que le Core 5G reste stable en interne.
IP_ADDR="127.0.0.1"
echo "Configuration forcée sur l'interface locale : $IP_ADDR"

# Variables PLMN et TAC
MCC="001"
MNC="01"
TAC="1"

echo "Mise à jour des fichiers Open5GS avec PLMN $MCC/$MNC..."

# --- NRF Config ---
sed -i "/mcc:/c\        mcc: $MCC" /etc/open5gs/nrf.yaml
sed -i "/mnc:/c\        mnc: $MNC" /etc/open5gs/nrf.yaml

# --- AMF Config ---
# Mise à jour de l'adresse NGAP (Bind)
sed -i "/ngap:/,/address:/ s/address: .*/address: $IP_ADDR/" /etc/open5gs/amf.yaml
# Mise à jour PLMN et TAC
sed -i "/guami:/,/mcc:/ s/mcc: .*/mcc: $MCC/" /etc/open5gs/amf.yaml
sed -i "/guami:/,/mnc:/ s/mnc: .*/mnc: $MNC/" /etc/open5gs/amf.yaml
sed -i "/tai:/,/mcc:/ s/mcc: .*/mcc: $MCC/" /etc/open5gs/amf.yaml
sed -i "/tai:/,/mnc:/ s/mnc: .*/mnc: $MNC/" /etc/open5gs/amf.yaml
sed -i "/tai:/,/tac:/ s/tac: .*/tac: $TAC/" /etc/open5gs/amf.yaml
sed -i "/plmn_support:/,/mcc:/ s/mcc: .*/mcc: $MCC/" /etc/open5gs/amf.yaml
sed -i "/plmn_support:/,/mnc:/ s/mnc: .*/mnc: $MNC/" /etc/open5gs/amf.yaml

# --- UPF Config ---
# Mise à jour de l'adresse GTP-U
sed -i "/gtpu:/,/address:/ s/address: .*/address: $IP_ADDR/" /etc/open5gs/upf.yaml

# --- FIX WEBUI (Le point critique) ---
# On identifie le dossier de travail du WebUI
WEBUI_DIR="/usr/lib/node_modules/open5gs"
if [ -d "$WEBUI_DIR" ]; then
    echo "Correction du binding IPv4 pour le WebUI..."
    sed -i "s/localhost/0.0.0.0/g" "$WEBUI_DIR/server/index.js"
    
    # Création/Mise à jour du fichier de config YAML du WebUI
    cat <<EOF > /etc/open5gs/webui.yaml
db_uri: mongodb://localhost/open5gs
webui:
    hostname: 0.0.0.0
    port: 9999
EOF
fi

# --- Nettoyage des Logs ---
for file in /etc/open5gs/*.yaml; do
    if ! grep -q "timestamp: false" "$file"; then
        sed -i "1i logger:\n  default:\n    timestamp: false" "$file"
    fi
done

echo "Redémarrage des services Open5GS..."
systemctl restart open5gs-nrfd open5gs-amfd open5gs-upfd open5gs-webui

echo "-------------------------------------------------------"
echo "Configuration terminée !"
echo "Services Core 5G : 127.0.0.1"
echo "WebUI accessible via tunnel SSH sur le port 9999"
echo "-------------------------------------------------------"
