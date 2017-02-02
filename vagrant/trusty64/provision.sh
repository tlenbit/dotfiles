#!/usr/bin/env bash

if [ -e "/etc/vagrant-provisioned" ];
then
    echo "Vagrant provisioning already completed. Skipping..."
    exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

echo "dev-vagrant" > /etc/hostname
echo "127.0.0.1 dev-vagrant" >> /etc/hosts

####### INSTALLATION ##########

# Core
apt-get update
apt-get install -y build-essential

# NodeJS
apt-get update
apt-get install -y python-software-properties python g++ make
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get update
apt-get install -y nodejs

# Git
apt-get install git

###############################


touch /etc/vagrant-provisioned
echo "<-------------------------------------------------->"
echo "Your vagrant instance is running at: 0.0.0.0"
echo "<-------------------------------------------------->"