docker-couchpotato
================

Ubuntu:1404 based couchpotato

Complete run command with all options

    docker run -d -p 5050:5050 \
        -v /myconfgidir:/config \
        -v /mydownloaddir:/downloads \
        -v /mymoviedir:/movies \
        -v /etc/localtime:/etc/localtime:ro \
        -e COUCH_UID=500 -e COUCH_GID=500 \
        jbogatay/couchpotato


Change directory mappings as appropriate (myconfigdir, mydownloaddir, movies)

COUCH_UID and COUCH_GID are optional, but will default to 500/500.   Specify the UID/GID that corresponds to the **HOST** UID/GID you want to own the downloads, config and movies directories.