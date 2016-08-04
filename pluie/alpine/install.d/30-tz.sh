#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

if [ ! -z "$TZ" ] && [ -f "/usr/share/zoneinfo/$TZ" ]; then
    echo "$TZ" > /etc/TZ
    cp "/usr/share/zoneinfo/$TZ" "/etc/localtime"
    apk del tzdata
    if [ ! "${TZ///*/}" = "$TZ" ]; then
        mkdir -p "/usr/share/zoneinfo/${TZ///*/}"
    fi
    cp /etc/localtime "/usr/share/zoneinfo/$TZ"
    echo -e "\033[1;38;5;203mTIMEZONE : $TZ"
    date
    echo -en "\033[m"
else
    echo -e "\033[1;38;5;203mNO DEFINED TIMEZONE"
fi
