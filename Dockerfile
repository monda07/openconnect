FROM fedora

RUN dnf install -y openconnect openssh-clients
RUN ln -s /usr/sbin/openconnect /usr/local/bin/openconnect && mkdir /root/.ssh
ADD startvpn /usr/bin/startvpn
VOLUME /usr/bin/openvpn
VOLUME /root/.ssh
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["bash", "/usr/bin/startvpn"]
