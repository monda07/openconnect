# Docker Container for VPN

Rather than running an entire Windows (bloated) virtual machine for accessing VPN endpoints, here is a Docker container that encapsulates the VPN openconnect tool as a container.  The objective is to allow you to have a second VPN up while your real machine has a main VPN established. It also allows for multiple VPN endpoints to be in use simultaneously, which can be quite handy in customer support.

There is a built container image on hub.docker.com at `darylmonge/openconnect`

## Building

You can build your own container image with a normal, simple docker build command or equivalent.

`docker build --tag openconnect .`

## Running

The container provides for several external bind mounts.  One is to inject your own openconnect command to establish the tunnel and the other is to inject an RSA key for use by any ssh commands if needed.  There is a sample shell script template for launching an SSH proxied by the tunnel.

## Futures

Currently it is unknown how to tunnel HTTP* and it is desireable to have an HTTP and/or HTTPS tunnel ability.

The container is currently build on Fedora.  This is a fairly heavy-weight OS for just running openconnect.  Alpine or BusyBox should be investigated for a lighter weight container

