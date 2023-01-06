#!/bin/bash

if [ -s /home/vagrant/.ssh/authorized_keys ]; then
	echo "File exists!"  
else
   echo "Creating new authorized_keys file"	  
   cd /home/vagrant/.ssh
   touch authorized_keys
   chown vagrant:vagrant authorized_keys 
   chmod 0600 authorized_keys
   cat /vagrant/vagrantkeys/vagrant_rsa.pub >> authorized_keys
   echo "File created"
fi
