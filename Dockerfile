FROM phusion/baseimage:0.9.11
MAINTAINER Jeff Bogatay <jeff@bogatay.com>
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# setup locale
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    echo 'LANGUAGE="en_US:en"' >> /etc/default/locale && \
    locale-gen en_US.UTF-8 &&\
    update-locale en_US.UTF-8

# add a service user change 500/500 to match whatever host uid/gid you want
RUN groupadd --gid 500 couchpotato  &&\
    useradd --gid 500 --no-create-home --shell /usr/sbin/nologin --uid 500 couchpotato

# update and install
RUN apt-get update -qy && apt-get upgrade -qy && \
    apt-get install -qy python2.7 git-core

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Disable Phusion SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Couchpotato

RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato && \
    chown -R couchpotato:couchpotato /couchpotato

# shared volumes
VOLUME /config
VOLUME /downloads
VOLUME /movies

EXPOSE 5050

# Add services
ADD scripts/service/ /etc/service/