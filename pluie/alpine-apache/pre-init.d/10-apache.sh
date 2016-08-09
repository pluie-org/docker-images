#!/usr/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ ! -z "$FIX_OWNERSHIP" ] && [ "$FIX_OWNERSHIP" -eq 1 ] && [ -d /app/$WWW_DIR ]; then
    chown -R 1000:apache /app/$WWW_DIR
fi

touch /var/log/apache2/error.log

tail -F /var/log/apache2/error.log &
