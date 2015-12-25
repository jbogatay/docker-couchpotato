FROM jbogatay/baseimage-python
MAINTAINER "Jeff Bogatay <jeff@bogatay.com>"

VOLUME ["/config","/downloads","/movies","/blackhole"]
EXPOSE 5050
CMD ["/app/start.sh"]

ADD app/ /app/