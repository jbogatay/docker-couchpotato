FROM alpine:3.4
MAINTAINER "Jeff Bogatay <jeff@bogatay.com>"

VOLUME ["/config","/downloads","/movies","/blackhole"]
EXPOSE 5050
CMD ["/bin/appstart.sh"]

RUN apk add --no-cache --update \
        curl \
        openssl \
        python \
        py-openssl \
        py-cryptography \
        py-lxml \
	    py-pip \
        py-enum34 \
        py-cffi \
        git \
        unrar &&\
    rm -rf /var/cache/apk/* /tmp/*

ADD appstart.sh /bin