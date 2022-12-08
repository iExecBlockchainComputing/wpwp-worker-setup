#!/bin/bash

# Function which checks exit status and stops execution
function checkExitStatus() {
  if [ $1 -eq 0 ]; then
    echo OK
  else
    echo $2
    read -p "Press [Enter] to exit..."
    exit 1
  fi
}

# Updating scripts
if [ -f "/home/vagrant/worker-pool-scripts/launch-worker.sh" ] && [ -f "/home/vagrant/worker-pool-scripts/stop-worker.sh" ]; then
   cd /home/vagrant/worker-pool-scripts/
   git pull
else
   rm -rf /home/vagrant/worker-pool-scripts/
   mkdir /home/vagrant/worker-pool-scripts
   git clone https://github.com/jjanczur/worker-pool-scripts.git /home/vagrant/worker-pool-scripts/
fi
checkExitStatus $? "Failed to download scripts. Check your internet connection..."

sudo chown -Rf vagrant:vagrant  /home/vagrant/worker-pool-scripts

# Launching script with vagrant user
#sudo su - vagrant /home/vagrant/worker-pool-scripts/launch-worker.sh

# Launching script with root user
/bin/bash  /home/vagrant/worker-pool-scripts/launch-worker.sh
