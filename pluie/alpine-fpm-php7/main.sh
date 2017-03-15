#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/common.sh

initTitle "Starting" "Apache Daemon"
httpd -D FOREGROUND
