FROM lsiobase/mono

ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 apt-get update && \
 apt-get install -y \
	samba \
	smbldap-tools \
    libnss-ldap && \
 auth-client-config -t nss -p lac_ldap && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# /etc/samba/smb.conf
# /etc/libnss-ldap.conf

COPY entrypoint.sh /entrypoint.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]