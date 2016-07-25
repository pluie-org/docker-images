#!/usr/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

if [ ! -z "$FIX_OWNERSHIP" ] && [ "$FIX_OWNERSHIP" -eq 1 ]; then
    chown -R 1000:apache /app/www
fi

touch /var/log/apache2/error.log

tail -F /var/log/apache2/error.log &
