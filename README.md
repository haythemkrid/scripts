# 🚀 5G SA Automation Suite (UERANSIM + Open5GS)

[![INSAT](https://img.shields.io/badge/University-INSAT-red.svg)](https://www.insat.rnu.tn/)
[![5G](https://img.shields.io/badge/Network-5G%20SA-blue.svg)](#)
[![UERANSIM](https://img.shields.io/badge/Tool-UERANSIM%20v3.2.8-orange.svg)](https://github.com/aligungr/UERANSIM)

Ce dépôt fournit une pipeline d'automatisation complète pour déployer un environnement de test **5G Standalone**. Idéal pour les travaux pratiques (TP) et la recherche sur les réseaux coeurs et d'accès.

---

## 🛠️ Guide d'Installation Rapide

Copiez et collez ces instructions dans votre terminal pour initialiser la simulation.

### 1️⃣ Acquisition des ressources
On récupère les scripts nécessaires depuis le dépôt principal :

```bash
# Téléchargement des scripts d'automatisation
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/init.sh
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/config.sh
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/run-5gs.sh

# Attribution des droits d'exécution
chmod +x init.sh config.sh run-5gs.sh

# Étape A : Installation des dépendances et compilation d'UERANSIM
./init.sh

# Étape B : Génération automatique des fichiers YAML (gNB & UE)
./config.sh

# Étape C : Lancement de la simulation
cd UERANSIM && mv ../run-5gs.sh ./
./run-5gs.sh
