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
        -e PUID=500 -e PGID=500 \
        jbogatay/couchpotato


Change directory mappings as appropriate (myconfigdir, mydownloaddir, movies, blackhole).

APP_UID and APP_GID are optional, but will default to 911/911.   Specify the UID/GID that APPsponds to the **HOST** UID/GID you want to own the downloads, config and movies directories.