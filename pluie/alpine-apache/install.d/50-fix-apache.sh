#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

mkdir -p /app/www 
chown -R 1000:apache /app/www
chmod -R 755 /scripts/pre-init.d
mkdir -p /run/apache2
chown apache:apache /run/apache2
sed -i 's#^DocumentRoot ".*#DocumentRoot "/app/www"#g' /etc/apache2/httpd.conf
sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf
sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf
sed -ir 's/expose_php = On/expose_php = Off/' /etc/php5/php.ini
echo -e "\nIncludeOptional /app/vhost" >> /etc/apache2/httpd.conf
