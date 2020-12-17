FROM fedora

RUN dnf install -y openconnect openssh-clients
ADD openvpn /usr/bin/openvpn
VOLUME /usr/bin/openvpn

ENTRYPOINT ["bash", "/usr/bin/openvpn"]
