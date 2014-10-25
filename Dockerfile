FROM ubuntu:14.04
MAINTAINER "Jeff Bogatay <jeff@bogatay.com>"

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/config","/downloads","/movies"]
EXPOSE 5050
CMD ["/app/start.sh"]

RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends &&\
    echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends &&\
    apt-get update &&\
    apt-get install -qy python2.7 git-core ca-certificates &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD app/ /app/
