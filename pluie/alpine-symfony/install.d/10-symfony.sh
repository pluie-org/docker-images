#!/bin/bash
# @app      pluie/alpine-symfony
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk -U add php5-iconv php5-intl php5-posix
curl -LsS https://symfony.com/installer -o /usr/bin/symfony
chmod +x /usr/bin/symfony
