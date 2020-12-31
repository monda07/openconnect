FROM fedora

RUN dnf install -y openconnect openssh-clients bind-utils
# Some end points fail because of poor 1024 crypto keys.
# This works around that problem.
RUN dnf install -y crypto-policies-scripts && update-crypto-policies --set LEGACY
RUN ln -s /usr/sbin/openconnect /usr/local/bin/openconnect && mkdir /root/.ssh
ADD startvpn /usr/bin/startvpn
VOLUME /usr/bin/openvpn
VOLUME /root/.ssh
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["bash", "/usr/bin/startvpn"]
