FROM lsiobase/mono

ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 apt-get update && \
 apt-get install -y \
	samba attr \
	smbldap-tools \
	attr acl smbclient ldap-utils winbind libnss-winbind libpam-winbind krb5-config krb5-user krb5-kdc \
	winbind libpam-winbind libnss-winbind libpam-krb5 libbsd-dev iproute2 bind9 dnsutils \
	libnss-ldap && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

COPY entrypoint.sh /entrypoint.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
