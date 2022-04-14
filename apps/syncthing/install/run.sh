#!/usr/bin/env bash

docker run --name combox -it -d --privileged --network=host -v /sys/fs/cgroup:/sys/fs/ wirelos/combox