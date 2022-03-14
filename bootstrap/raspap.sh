#!/usr/bin/env bash

# Enable SSH access
touch /boot/ssh

# Install stack and tools
apt update
apt full-upgrade -y
apt install -y git curl unzip tmux vim

# Access Point
curl -sL https://install.raspap.com | bash