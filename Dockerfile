FROM jbogatay/baseimage-alpine:3.5

RUN apk add --no-cache openssl python py-openssl py-cryptography py-lxml \
        py-pip py-enum34 py-cffi git unrar &&\
    rm -rf /var/cache/apk/* /tmp/*

COPY root/ /

VOLUME ["/config","/downloads","/movies","/blackhole"]
EXPOSE 5050