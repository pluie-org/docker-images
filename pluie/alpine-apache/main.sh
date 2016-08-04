#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

. /scripts/common.sh

initTitle "Starting" "Apache Daemon"
httpd -D FOREGROUND
