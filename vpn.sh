#!/bin/sh
# Launch a docker container that maps a local shell script into the contaner
# and starts an openconnect connection

SCRIPT=$(which $1)
NAME=$(basename $SCRIPT)
shift
docker run --tty --interactive --privileged --rm \
    --volume $SCRIPT:/usr/bin/openvpn \
    --volume $HOME/.ssh:/root/.ssh \
    --publish 80:80 \
    --publish 443:443 \
    --name openconnect_$NAME \
    $* \
    openconnect
