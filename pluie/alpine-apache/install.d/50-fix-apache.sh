#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

mkdir -p /app/www 
chown -R 1000:apache /app/www
chmod -R 755 /scripts/pre-init.d
sed -i 's#^DocumentRoot ".*#DocumentRoot "/app/www"#g' /etc/apache2/httpd.conf
sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf
sed -ir 's/expose_php = On/expose_php = Off/' /etc/php/php.ini
echo -e "\nIncludeOptional /app/vhost" >> /etc/apache2/httpd.conf
