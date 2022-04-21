#!/usr/bin/env bash

function bfs {
  git clone $1 $2
  pushd $2
    docker build -t $3 .
  popd
  rm -rf $2
}

#bfs https://github.com/0x1d/dbox .tmp/dbox wirelos/dbox
bfs https://github.com/RaspAP/raspap-docker .tmp/raspap wirelos/raspap

