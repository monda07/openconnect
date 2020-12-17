#!/bin/sh
# This is really just a sample script to demonstrate how to use the openconnect container to ssh to a remote host

docker exec -ti $1 ssh -o KexAlgorithms=diffie-hellman-group-exchange-sha1 monda07@isengard.actian.com
