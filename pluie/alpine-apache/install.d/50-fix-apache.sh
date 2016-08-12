#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

mkdir -p /app/$WWW_DIR 
chown -R 1000:apache /app/$WWW_DIR
chmod -R 755 /scripts/pre-init.d
mkdir -p /run/apache2
chown apache:apache /run/apache2
tmpsed='s#^DocumentRoot ".*#DocumentRoot "/app/'$WWW_DIR'"#g'
sed -i "$tmpsed" /etc/apache2/httpd.conf
sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf
sed -i 's#LoadModule mpm_prefork_module modules/mod_mpm_prefork.so#\#LoadModule mpm_prefork_module modules/mod_mpm_prefork.so#' /etc/apache2/httpd.conf
sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf
sed -i 's#\#LoadModule mpm_event_module modules/mod_mpm_event.so#LoadModule mpm_event_module modules/mod_mpm_event.so#' /etc/apache2/httpd.conf
sed -i 's#\#LoadModule slotmem_shm_module modules/mod_slotmem_shm.so#LoadModule slotmem_shm_module modules/mod_slotmem_shm.so#' /etc/apache2/httpd.conf
sed -ir 's/expose_php = On/expose_php = Off/' /etc/php5/php.ini
echo -e "\nIncludeOptional /app/vhost" >> /etc/apache2/httpd.conf
unset tmpsed
