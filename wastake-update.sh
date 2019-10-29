#!/bin/bash

RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

wastake-cli stop
echo -e "${GREEN} Stopping WaStake wallet   ${NC}"
sleep 10
rm -rf /usr/local/bin/wastake*
rm -rf WaStake-ubuntu16.04-daemon.zip
rm -rf .wastake-core/mncache.dat .wastake-core/mnpayments.dat .wastake-core/peers.dat .wastake-core/blocks .wastake-core/chainstate .wastake-core/database

wget -N https://github.com/wastake-core/wastake/releases/download/v1.4.0.0/WaStake-ubuntu16.04-daemon.zip
unzip WaStake-ubuntu16.04-daemon.zip
sudo chmod -R 755 wastake-cli
sudo chmod -R 755 wastaked
sudo cp -p -r wastaked /usr/local/bin
sudo cp -p -r wastake-cli /usr/local/bin
echo -e "${GREEN} I will start downloading the blockchain files in 5 seconds... ${NC}"
sleep 5s
wget https://github.com/wastake-core/bootstrap/raw/master/bootstrap.zip
sleep 2s
sudo apt-get install unzip
unzip -u bootstrap.zip -d .wastake-core
echo -e "${GREEN} Files succesfully installed! ${NC}"
sleep 1s
echo -e "${GREEN} Removing .zip file from your directory ${NC}"
rm -rf bootstrap.zip 
echo -e "${GREEN} Starting the Server... ${NC}"
wastaked -daemon
sleep 10
wastake-cli getinfo
