#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

. /scripts/common.sh

echo "[[ Starting Mysql Daemon ]]"
exec /usr/bin/mysqld --user=mysql --console
