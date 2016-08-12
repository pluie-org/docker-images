#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

function a2setModule(){
    local enable=${1:-''}
    local   path=${3:-'/etc/apache2/httpd.conf'}
    local   scom=''
    local   rcom='\#'
    if [ ! -z $1 ] && [ ! -z "$2" ]; then
        if [ "$enable" = 1 ]; then
            scom='\#'
            rcom=''
        fi
        echo "$2"
        sed -i "s#${scom}LoadModule $2_module modules/mod_$2.so#${rcom}LoadModule $2_module modules/mod_$2.so#" "$path"
    fi
}

if [ ! -f /usr/lib/libxml2.so ]; then
    ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
fi
if [ ! -d /app/$WWW_DIR ]; then
    mkdir -p /app/$WWW_DIR
fi
if [ ! -d /run/apache2 ]; then
    mkdir /run/apache2
fi
chown -R 1000:apache /app/$WWW_DIR
chmod -R 755 /scripts/pre-init.d
mkdir -p /run/apache2
chown apache:apache /run/apache2
tmpsed='s#^DocumentRoot ".*#DocumentRoot "/app/'$WWW_DIR'"#g'
sed -i "$tmpsed" /etc/apache2/httpd.conf
sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf
initTitle "Apache" "Loading Modules"
a2setModule 1 "rewrite"
a2setModule 1 "mpm_event"
a2setModule 1 "slotmem_shm"
a2setModule 1 "heartmonitor"
a2setModule 1 "watchdog"
initTitle "Apache" "Removing Modules"
a2setModule 0 "mpm_prefork"
a2setModule 0 "proxy_fdpass" /etc/apache2/conf.d/proxy.conf
echo
tmpsed="/etc/php5/php.ini"
sed -ir 's/expose_php = On/expose_php = Off/' $tmpsed
sed -i "s|;*date.timezone =.*|date.timezone = ${TZ}|i" $tmpsed
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/php.ini
tmpsed="/etc/php5/php-fpm.conf"
sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" $tmpsed
sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" $tmpsed
sed -i "s|;*listen\s*=\s*/||g" $tmpsed
sed -i "s|pm = dynamic|pm = ondemand|g" $tmpsed
echo -e "\nIncludeOptional /app/vhost" >> /etc/apache2/httpd.conf
unset tmpsed
