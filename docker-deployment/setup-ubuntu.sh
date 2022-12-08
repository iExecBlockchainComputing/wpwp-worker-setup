#!/bin/bash

sudo apt-get update -y &&
sudo apt-get -y install git-all &&

# Install docker
sudo apt-get -y install docker.io &&
sudo service docker start &&
# Allow running docker without sudo 
# Reboot instance or logout and login again
sudo usermod -a -G docker $USER &&

# Instal docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&

# Configure Docker to start on boot
sudo systemctl enable docker.service &&
sudo systemctl enable containerd.service

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install v16
nvm use v16
nvm ls

# Install iExec
npm i -g iexec 

# Reboot this machune
