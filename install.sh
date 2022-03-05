#!/bin/sh

# This is the Pool install script.
echo "JAMPS Ravencoin Pool install script."
echo "Please do NOT run as root, run as the pool user!"

echo "Installing... Please wait!"

sleep 5

rm -rf /usr/lib/node_modules
rm -rf node_modules
apt remove --purge -y nodejs node
rm /etc/apt/sources.list.d/*
apt update
apt upgrade -y
apt dist-upgrade -y
apt install -y apt-transport-https software-properties-common build-essential autoconf pkg-config make gcc g++ screen wget curl ntp fail2ban 

add-apt-repository -y ppa:chris-lea/redis-server
add-apt-repository -y ppa:bitcoin/bitcoin
add-apt-repository -y ppa:certbot/certbot

apt update
apt install -y libdb4.8-dev libdb4.8++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev redis-server
apt install -y git npm nodejs nginx python-certbot-nginx

systemctl enable fail2ban
systemctl start fail2ban
systemctl enable redis-server
systemctl start redis-server
systemctl enable ntp
systemctl start ntp

rm -rf ~/.nvm
rm -rf ~/.npm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc
chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 8.17.0
nvm use 8.17.0
npm update -g

npm install -g pm2@4.5.6
npm install -g npm@latest-6

npm install
npm update
npm audit fix
npm install sha3
npm install logger

echo "Installation completed!"

exit 0
