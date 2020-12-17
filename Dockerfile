FROM fedora

RUN dnf install -y openconnect openssh-clients
RUN ln -s /usr/sbin/openconnect /usr/local/bin/openconnect && \
    mkdir /root/.ssh
# ADD openvpn /usr/bin/openvpn
VOLUME /usr/bin/openvpn
VOLUME /root/.ssh/id_rsa

ENTRYPOINT ["bash", "/usr/bin/openvpn"]
