#!/usr/bin/env bash

sudo pacman -S tor python-pip python-pysocks python-cryptography \
               imagemagick python-requests \
               perl-image-exiftool python-dateutil \
               certbot flake8 bandit
sudo pip3 install pyqrcode pypng