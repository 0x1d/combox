#!/bin/bash

# Enable SSH access
touch /boot/ssh

# Enable cgroup
echo -e "cgroup_memory=1 cgroup_enable=memory $(cat /boot/cmdline.txt)" > /boot/cmdline.txt

# install stuff
apt update
apt full-upgrade -y
apt install -y git curl
