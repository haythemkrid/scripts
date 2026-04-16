# scripts
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/init.sh
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/config.sh
wget https://raw.githubusercontent.com/haythemkrid/scripts/refs/heads/main/run-5gs.sh

chmod +x init.sh config.sh run-5gs.sh

./init.sh
./config.sh
cd UERANISM && mv ../run-5gs.sh ./
./run-5gs.sh
