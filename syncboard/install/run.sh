#!/usr/bin/env bash

docker run --name raspap -it -d --privileged --network=host -v /sys/fs/cgroup:/sys/fs/