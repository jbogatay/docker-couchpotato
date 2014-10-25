#!/bin/bash
set -e


# only run the uid/gid creation on first run
if [ ! -f /app/runonce ]; then

   echo "Performing first time setup"
   
   #sanity check uid/gid
   if [ $COUCH_UID -ne 0 -o $COUCH_UID -eq 0 2>/dev/null ]; then
      if [ $COUCH_UID -lt 100 -o $COUCH_UID -gt 65535 ]; then
         echo "[warn] COUCH_UID out of (100..65535) range, using default of 500"
         COUCH_UID=500
      fi
   else
      echo "[warn] COUCH_UID non-integer detected, using default of 500"
      COUCH_UID=500
   fi

   if [ $COUCH_GID -ne 0 -o $COUCH_GID -eq 0 2>/dev/null ]; then
      if [ $COUCH_GID -lt 100 -o $COUCH_GID -gt 65535 ]; then
         echo "[warn] COUCH_GID out of (100..65535) range, using default of 500"
         COUCH_GID=500
      fi
   else
      echo "[warn] COUCH_GID non-integer detected, using default of 500"
      COUCH_GID=500
   fi

   # add UID/GID or use existing
   groupadd --gid $COUCH_GID couchpotato || echo "Using existing group $COUCH_GID"
   useradd --gid $COUCH_GID --no-create-home --uid $COUCH_UID couchpotato
   
   # set runonce so it... runs once
   touch /app/runonce

fi

# make nzbget destination directory and take control of folders
mkdir -p /config /movies /downloads /couchpotato

if [ -d /couchpotato/.git ]; then
  cd /couchpotato && git pull
else
  git clone https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato
fi


chown -R $COUCH_UID:$COUCH_GID /config
chown -R $COUCH_UID:$COUCH_GID /downloads
chown -R $COUCH_UID:$COUCH_GID /movies
chown -R $COUCH_UID:$COUCH_GID /couchpotato


# spin it up
exec su couchpotato -c "/usr/bin/python2.7 /couchpotato/CouchPotato.py  --config_file=/config/config.ini --data_dir=/config/data"
                          