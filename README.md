docker-couchpotato
================

Alpine based couchpotato.  Just couchpotato.  Under 85MB.

Complete run command with all options

    docker run -d -p 5050:5050 \
    	--restart=always
        -v /myconfgidir:/config \
        -v /mydownloaddir:/downloads \
        -v /mymoviedir:/movies \
        -v /myblackholedir:/blackhole \
        -v /etc/localtime:/etc/localtime:ro \
        -e APP_UID=500 -e APP_GID=500 \
        jbogatay/couchpotato


Change directory mappings as appropriate (myconfigdir, mydownloaddir, movies, blackhole).

APP_UID and APP_GID are optional, but will default to 500/500.   Specify the UID/GID that APPsponds to the **HOST** UID/GID you want to own the downloads, config and movies directories.