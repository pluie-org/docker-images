#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk --update add apache2 apache2-proxy \
php7-apache2 php7-mbstring php7-session php7-phar php7-zlib php7-zip php7-ctype \
php7-mysqli php7-xml php7-pdo_mysql php7-opcache php7-pdo php7-json php7-curl \
php7-gd php7-mcrypt php7-openssl php7-\dom  \
# php-pdo_odbc php-soap php-pgsql
