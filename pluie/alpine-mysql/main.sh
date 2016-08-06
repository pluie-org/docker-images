#!/bin/bash
# @app      pluie/alpine-mysql
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/common.sh
exec /usr/bin/mysqld --user=mysql --console
