#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/common.sh

sleep 3 && \
initTitle "Starting" "Apache Daemon" && \
httpd
initTitle "Starting" "PHP-FPM"
/usr/bin/php-fpm &
tail -F /var/log/apache2/error.log
