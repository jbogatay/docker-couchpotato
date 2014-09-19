A dockerfile for couchpotato using the latest git version.

Setup
-------
- Copy or move Makevars-TEMPLATE to Makevars

- Edit all the configuration values in Makevars

- Create the image

        make

- Run the image
 
        make run

  or, as part of the make process, start_container.sh and start_container_shell.sh are created, you can use either of those to run the container

        sudo ./start_container.sh
        sudo ./start_container_shell.sh

Other make targets
-------

|Parameter|Description|
|---------|-----------|
|configure|configure the dockerfile and scripts only|
|build|build the container only|
|run|stop and remove existing vpn container, then spool up a new one|
|stop|stop and remove any existing/running vpn containers|
|shell|start new container and all services with a shell prompt.  Container will be stopped and removed on exit|
|clean|remove image|
|startcmds|create start_container.sh and start_interactive_container.sh|