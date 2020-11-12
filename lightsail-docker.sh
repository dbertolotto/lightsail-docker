#!/bin/bash

COMPOSE_VER=1.27.4

# Install necessary packages
apt-get update && apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add Docker officiall GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add stable repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io

# Make it so you don't need to sudo to run docker commands
usermod -aG docker ubuntu

# Make sure that Docker starts on boot
systemctl enable docker

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Prepare a folder to deploy the composer file
# If you change this, change the systemd service file to match WorkingDirectory=[whatever you have below]
mkdir /docker
#curl -o /docker/docker-compose.yml https://raw.githubusercontent.com/dbertolotto/lightsail-docker/master/docker-compose.yml

# Copy in systemd unit file and register it in order to run the composer file on system restart
curl -o /etc/systemd/system/docker-compose-app.service https://raw.githubusercontent.com/dbertolotto/lightsail-docker/master/docker-compose-app.service
systemctl enable docker-compose-app

# start up the application via docker-compose
docker-compose -f /docker/docker-compose.yml up -d

