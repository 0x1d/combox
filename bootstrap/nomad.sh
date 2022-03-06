#!/usr/bin/env bash

# Enable SSH access
touch /boot/ssh

# Install stack and tools
apt update
apt full-upgrade -y
apt install -y git curl unzip tmux vim docker.io docker-compose 

# Nomad
wget https://releases.hashicorp.com/nomad/1.2.6/nomad_1.2.6_linux_arm.zip
unzip nomad_1.2.6_linux_arm.zip
mv nomad /usr/local/bin && rm nomad_1.2.6_linux_arm.zip
