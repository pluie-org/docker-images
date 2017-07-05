#!/usr/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ ! -d /app/$WWW_DIR ]; then
    CREATE_WWW_DIR=1
    mkdir -p /app/$WWW_DIR
fi
if [ ! -f /app/$WWW_DIR/$WWW_INDEX ]; then
    echo "<?php phpinfo();" >  /app/$WWW_DIR/$WWW_INDEX
fi
tmpsed=/etc/apache2/httpd.conf
sed -i 's#^DocumentRoot ".*#DocumentRoot "/app/'$WWW_DIR'"#g' "$tmpsed"
sed -i 's#AllowOverride none#AllowOverride All#' "$tmpsed"

if [ ! -z "$FIX_OWNERSHIP" ] && [ "$FIX_OWNERSHIP" -eq 1 ] && [ -d /app/$WWW_DIR ]; then
    chown -R 1000:apache /app/$WWW_DIR
fi

touch /var/log/apache2/error.log

tail -F /var/log/apache2/error.log &
