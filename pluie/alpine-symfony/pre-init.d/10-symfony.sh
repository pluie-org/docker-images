#!/bin/bash
# @app      pluie/alpine-symfony
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

ln -s /usr/bin/php7 /usr/bin/php
if [ ! -d /app/$WWW_DIR ]; then
    cd /tmp
    mkdir $WWW_DIR
    symfony new app $SYMFONY_VERSION
    mv app/* /app/
    chown -R 1000:apache /app/
    chown -R 1000:nogroup /app/var
    chmod -R g+w /app
fi
