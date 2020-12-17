# Docker Container for VPN

Rather than running an entire Windows (bloated) virtual machine for accessing VPN endpoints via the "openconnect" tool, here is a Docker container that encapsulates the VPN system as a container.  The objective is to allow you to have a second VPN up while your real machine has a main VPN established. 

Currently it is unknown how to tunnel HTTP*

The basic purpose of this repository is the Dockerfile to build a "universal" container.  The container provides for several external bind mounts.  One is to inject your own openconnect command to establish the tunnel and the other is to inject an RSA key for use by any ssh commands.  There is a sample shell script on launching an SSH proxied by the tunnel