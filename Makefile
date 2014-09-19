include Makevars

RUNARGS := -p ${COUCH_PORT}:5050 -v ${COUCH_PATH}:/config -v ${DL_PATH}:/downloads -v ${MOVIE_PATH}:/movies -v /etc/localtime:/etc/localtime:ro
ifneq ($(strip $(NZBGET_LINK)),)
	RUNARGS += --link ${NZBGET_LINK}:nzbget
endif

all:	configure build startcmds

build:	configure
	sudo ${DOCKER} build -t ${IMAGE} .

startcmds:
	echo "#!/bin/bash" > start_container.sh
	echo "${DOCKER} run -d --restart=always --name ${CONTAINER} ${RUNARGS} ${IMAGE}" >> start_container.sh
	chmod +x start_container.sh
	echo "#!/bin/bash" > start_container_shell.sh
	echo "${DOCKER} run --rm --name ${CONTAINER} -t -i ${RUNARGS} ${IMAGE} /sbin/my_init -- bash -l" >> start_container_shell.sh
	chmod +x start_container_shell.sh


configure:
	sed -i 's#--gid\s\+[0-9]\+\s#--gid ${COUCH_GID} #' Dockerfile
	sed -i 's#--uid\s\+[0-9]\+\s#--uid ${COUCH_UID} #' Dockerfile


run:	stop
	sudo ${DOCKER} run -d --restart=always --name ${CONTAINER} ${RUNARGS} ${IMAGE}
#	sudo ${DOCKER} logs -f ${CONTAINER}
stop:
	sudo ${DOCKER} kill ${CONTAINER} || true
	sudo ${DOCKER} rm -v ${CONTAINER} || true

shell:
	sudo ${DOCKER} run --rm --name ${CONTAINER} -t -i ${RUNARGS} ${IMAGE} /sbin/my_init -- bash -l


clean:
	sudo ${DOCKER} rmi ${IMAGE}
