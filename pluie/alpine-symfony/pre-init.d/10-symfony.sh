#!/bin/bash
# @app      pluie/alpine-symfony
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ -z "$CREATE_WWW_DIR" ]; then
    cd /tmp
    ls -la /tmp
    mkdir $WWW_DIR
    symfony new app $SYMFONY_VERSION
    mv app/* /app/
    chown -R 1000:apache /app/
    mkdir -p /app/var/logs
    chown -R 1000:apache /app/var
    chmod -R g+w /app/
fi
