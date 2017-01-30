#!/bin/bash
# @app      pluie/alpine-symfony
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk -U add php7-iconv php7-intl php7-posix
curl -LsS https://symfony.com/installer -o /usr/bin/symfony
chmod +x /usr/bin/symfony
