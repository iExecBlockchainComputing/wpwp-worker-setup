#!/bin/bash
# Tested on: Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-09-12

# Function that prints messages
function message() {
  echo "[$1] $2"
  if [ "$1" == "ERROR" ]; then
    # read -p "Press [Enter] to exit..."
    exit 1
  fi
}

# Function which checks exit status and stops execution
function checkExitStatus() {
  if [ $1 -eq 0 ]; then
    message "OK" ""
  else
    message "ERROR" "$2"
  fi
}

# Source .env and read env variables from it
echo "Reading .env "
set -a
source .env
set +a

echo "                                                                "
echo "________________________________________________________________"
echo "## Start Setup script ##                                        "
echo "                                                                "

sudo apt-get update -y &&
sudo apt-get -y install git-all &&

echo "                                                                "
echo "________________________________________________________________"
echo "## Installing docker  ##                                        "
echo "                                                                "

# Install docker

sudo apt-get -y install docker.io &&
sudo service docker start &&
# Allow running docker without sudo 
# Reboot instance or logout and login again
sudo usermod -a -G docker $USER &&

echo "                                                                "
echo "________________________________________________________________"
echo "## Installing docker compose ##                                 "
echo "                                                                "

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&

# Configure Docker to start on boot
sudo systemctl enable docker.service &&
sudo systemctl enable containerd.service


echo "                                                                "
echo "________________________________________________________________"
echo "## Installing nvm  ##                                           "
echo "                                                                "

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install v16
nvm use v16
nvm ls

echo "                                                                "
echo "________________________________________________________________"
echo "## Installing iexec  ##                                         "
echo "                                                                "

npm i -g iexec &&

# Set Worker Availiable CPU
WORKER_DEFAULT_CPU=1

TOTAL_AVAILABLE_CPUS=$(nproc --all) 
WORKER_AVAILABLE_CPU=$(expr  $TOTAL_AVAILABLE_CPUS - 1)

if [ "$WORKER_AVAILABLE_CPU" == 0 ]; then
	WORKER_AVAILABLE_CPU=$WORKER_DEFAULT_CPU
	echo " Number of CPUs for your worker = $WORKER_AVAILABLE_CPU out of ($TOTAL_AVAILABLE_CPUS)"
    echo " ( Stting up default CPUs for worker to $WORKER_DEFAULT_CPU )"    
fi

# if there is a FORCE_WORKER_AVAILABLE_CPU replace this variable with the one forced by the user
WORKER_AVAILABLE_CPU=${FORCE_WORKER_AVAILABLE_CPU:-$WORKER_AVAILABLE_CPU}

echo "                                                                "
echo "________________________________________________________________"
echo "## Preparing the worker ##                                      "
echo "                                                                "

# Clone docker Scripts
git clone https://github.com/jjanczur/workerpool-docker-setup.git
checkExitStatus $?  "Can't pull https://github.com/jjanczur/workerpool-docker-setup.git"

cd workerpool-docker-setup
checkExitStatus $?  "Can't cd to non existing location workerpool-docker-setup"

PROD_WALLET_PASSWORD=${PROD_WALLET_PASSWORD:-mySecretPassword}
# Create wallet
iexec wallet import $PRIVATE_KEY --password $PROD_WALLET_PASSWORD --keystoredir .
checkExitStatus $?  "Can't import the wallet"

mv UTC--* worker_wallet.json &&

echo "                                                                "
echo "________________________________________________________________"
echo "## Starting the worker ##                                       "

# Start Worker

FILE=../.env
if [ -f "$FILE" ]; then
    cat ../.env >> .env
else
    echo "PROD_CORE_HOST=$PROD_CORE_HOST" >> .env
    echo "PROD_WALLET_PASSWORD=$PROD_WALLET_PASSWORD" >> .env
fi

echo "WORKER_AVAILABLE_CPU=$WORKER_AVAILABLE_CPU" >> .env

newgrp docker << END
docker-compose up -d
END