#!/usr/bin/env bash

me=$(basename $BASH_SOURCE) 
INSTALL_TARGET=/opt/combox
GIT_SOURCE=https://github.com/0x1d/combox
IMAGE_TAG=wirelos/combox 

function ctl_info  {
    echo "${me}"
}

function install {
    gcdb $GIT_SOURCE $INSTALL_TARGET $IMAGE_TAG
}

function upgrade {
    git pull
}

function ctl_loop {
    ctl_info
    read -p '> ';
    bash $me ${REPLY}
    ctl_loop
}

## gcdb      git clone docker build
function gcdb {
  git clone $1 $2
  pushd $2
    docker build -t $3 .
  popd
  #rm -rf $2
}

${@:-ctl_loop}
