#!/bin/sh
# Launch a docker container that maps a local shell script into the contaner
# and starts an openconnect connection

docker run  --privileged --rm \
    --volume $HOME/Documents/bin/$1:/usr/bin/openvpn \
    --volume $HOME/.ssh:/root/.ssh \
    --name openconnect_$1 \
    darylmonge/openconnect