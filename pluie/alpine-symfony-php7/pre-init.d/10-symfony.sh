#!/bin/bash
# @app      pluie/alpine-symfony
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ ! -z "$CREATE_WWW_DIR" ]; then
    cd /tmp
    symfony new app $SYMFONY_VERSION
    rm -rf /app/web
    mv -f app/* /app/
    chown -R 1000:apache /app/
    chown -R 774:apache /app/var
    chmod -R g+w /app
    CTN_IP=$(ip route | cut -d ' ' -f3 | head -n1)
    sed -i "/::1/s//::1', '$CTN_IP/" /app/web/app_dev.php
fi
