#!/usr/bin/env bash

me=$(basename $BASH_SOURCE) 

function ctl_info  {
    echo "${me}"
}

function install {
    git clone https://gitlab.com/bashrc2/epicyon /opt/epicyon
}

function upgrade {
    cd /opt/epicyon
    git pull
}

function ctl_loop {
    ctl_info
    read -p '> ';
    bash $me ${REPLY}
    ctl_loop
}

${@:-ctl_loop}
