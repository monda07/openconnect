# Docker Container for VPN

Rather than running an entire Windows (bloated) virtual machine for accessing VPN endpoints via the "openconnect" tool, here is a Docker container that encapsulates the VPN system as a container.  The objective is to allow you to have a second VPN up while your real machine has a main VPN established. 

Currently it is unknown how to tunnel HTTP*

I think this is rather clever if I may say so 🤓

Dockerfile:

```
`FROM **fedora**`
`RUN dnf install -y openconnect openssh-clients`
`ADD openvpn /usr/bin/openvpn`
`ENTRYPOINT ["bash", "/usr/bin/openvpn”]
```

The script “openvpn” (redacted)

You of course could allow the script to prompt you, but why?  😉

```
*#!/bin/sh*`

`*# set -x*`
`endpoint=[gatekeeper-usau.actian.com](http://gatekeeper-usau.actian.com/)`

`[ "$1" = "-p" ] && endpoint=[gatekeeper-uspa.actian.com](http://gatekeeper-uspa.actian.com/)`

`[ "$1" = "-i" ] && endpoint=52.129.114.4`



`(echo ‘YourDomainPassword';**echo** 2) | openconnect --timestamp --[user=daryl.monge@actian.com](mailto:user=daryl.monge@actian.com) --servercert 'pin-sha256:Khbv7Jx8nBTJC0RS0cJvJTygFy1/iG45Kg+kKuJBBDY=' --authgroup=ACTIAN-CORP $endpoint --passwd-on-stdin`

`while **true**`

`do`

​    `sleep 86400`

`done
```

Building the container image is as simple as “docker build .”

Launching the container:

Ignore the errors for now, it still actually works.  I love (sarcasm) stuff like that….

04:57 PM 🏠 monda07@enterprise:~/Documents/Experiments/openconnect

▶ docker run -ti --rm --privileged --name=openconnect openconnect

[2020-12-10 22:58:47] POST https://gatekeeper-usau.actian.com/

[2020-12-10 22:58:47] Connected to 52.129.114.4:443

[2020-12-10 22:58:47] SSL negotiation with [gatekeeper-usau.actian.com](http://gatekeeper-usau.actian.com/)

[2020-12-10 22:58:47] Server certificate verify failed: signer not found

[2020-12-10 22:58:47] Connected to HTTPS on [gatekeeper-usau.actian.com](http://gatekeeper-usau.actian.com/) with ciphersuite (TLS1.2)-(RSA)-(AES-256-CBC)-(SHA1)

[2020-12-10 22:58:47] XML POST enabled

Please enter your username and password.

[2020-12-10 22:58:47] POST https://gatekeeper-usau.actian.com/

[2020-12-10 22:58:47] XML POST enabled

Please enter your username and password.

[2020-12-10 22:58:47] POST https://gatekeeper-usau.actian.com/

Please select your second authentication method [num]:

1 - Okta Verify.

2 - Okta Verify Push.

Enter '0' to abort.

Response:

[2020-12-10 22:58:49] POST https://gatekeeper-usau.actian.com/

[2020-12-10 22:58:59] Got CONNECT response: HTTP/1.1 200 OK

[2020-12-10 22:58:59] CSTP connected. DPD 30, Keepalive 20

[2020-12-10 22:58:59] Connected as 10.5.248.124, using SSL, with DTLS in progress

[2020-12-10 22:58:59] Established DTLS connection (using GnuTLS). Ciphersuite (DTLS0.9)-(RSA)-(AES-128-CBC)-(SHA1).

[2020-12-10 22:58:59] Failed to read from SSL socket: The transmitted packet is too large (EMSGSIZE).

[2020-12-10 22:58:59] Failed to recv DPD request (-5)

Error: any valid prefix is expected rather than "local/32".

Login to Isengard 

yes, Isengard is now so out of date that ssh no longer recognizes the encryption keys by default

05:00 PM 🏠 monda07@enterprise:~

▶ docker exec -ti openconnect ssh -o KexAlgorithms=diffie-hellman-group-exchange-sha1 [monda07@isengard.actian.com](mailto:monda07@isengard.actian.com)

The authenticity of host '[isengard.actian.com](http://isengard.actian.com/) (10.5.216.5)' can't be established.

RSA key fingerprint is SHA256:gty2g6ieblTRuEICC94LeZlkwthAg8vTCnp3exhbOHY.

Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '[isengard.actian.com](http://isengard.actian.com/),10.5.216.5' (RSA) to the list of known hosts.

[monda07@isengard.actian.com](mailto:monda07@isengard.actian.com)'s password:

Last login: Thu Dec 10 17:55:28 2020 from 10.5.248.221

​     Version           InstId Comments

loadE0  II 11.0.0 (a64.lnx/100) 15146  E0 Ingres 11 Actian X test install

loadUW  II 9.1.0 (a64.lnx/123)NPTL	 UW Another US install??

loadUS	 II 9.2.3 (a64.lnx/101) NPTL	 US UW mmind installation

loadU1	 II 9.1.2 (a64.lnx/100) NPTL	 U1 Another 9.1.2 installation

loadLP  II 9.2.0 (a64.lnx/118) NPTL   LP PPG installation

loadL2  II 9.2.0 (a64.lnx/143) NPTL   L2 p13627 SC930 Test

loadB1  II 9.3.1 (a64.lnx/106) NPTL	 B1 64-bit

loadB2  II 9.3.0 (int.lnx/151) NPTL	 B2 32-bit Community Build

loadTN  II 10.0.0 (a64.lnx/109)NPTL   TN

loadAA  II 10.0.0 (a64.lnx/132)NPTL   AA For HVR multiway replication

loadBB  II 10.0.0 (a64.lnx/132)NPTL   BB For HVR multiway replication

loadCC  II 10.0.0 (a64.lnx/132)NPTL   CC For HVR multiway replication

loadVW	 II 1.0.0 (a64.lnx/114) NPTL	 VW Ingres Vectorwise

loadV1	 II 1.0.0 (a64.lnx/11405) NPTL	 V1 Ingres Vectorwise - Simon

loadGW					 GW Ingres EA for Oracle 11

hvra   HVR installation a hvr_port 50000 4.3.8/1 (lina24)

[monda07@isengard ~]$