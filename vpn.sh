#!/bin/sh
# Launch a docker container that maps a local shell script into the contaner
# and starts an openconnect connection

SCRIPT=$(which $1)
docker run --tty --interactive --privileged --rm \
    --volume $SCRIPT:/usr/bin/openvpn \
    --volume $HOME/.ssh:/root/.ssh \
    --port 80:80 \
    --port 443:443 \
    --name openconnect_$1 \
    openconnect
