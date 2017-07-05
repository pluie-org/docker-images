#!/bin/bash
tmpsed="/etc/php5/php.ini"
sed -i "s|;*date.timezone =.*|date.timezone = ${TZ}|i" $tmpsed
cat $tmpsed | grep "date.timezone"
