#!/usr/bin/env bash

# Enable SSH access
touch /boot/ssh

# Enable cgroup
echo -e "cgroup_memory=1 cgroup_enable=memory $(cat /boot/cmdline.txt)" > /boot/cmdline.txt

# Install stack and tools
apt update
apt full-upgrade -y
apt install -y git curl unzip tmux vim docker.io docker-compose 

# Nomad
wget https://releases.hashicorp.com/nomad/1.2.6/nomad_1.2.6_linux_${ARCH}.zip
unzip nomad_1.2.6_linux_${ARCH}.zip
mv nomad /usr/local/bin && rm nomad_1.2.6_linux_${ARCH}.zip

wget https://releases.hashicorp.com/consul/1.11.4/consul_1.11.4_linux_${ARCH}.zip
unzip consul_1.11.4_linux_${ARCH}.zip
mv consul /usr/local/bin && rm consul_1.11.4_linux_${ARCH}.zip