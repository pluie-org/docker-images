#!/bin/bash

if [ "$TZ" != "Europe/Paris" ]; then
    apk -U add tzdata
    . /scripts/install.d/30-tz.sh
    . /scripts/install.d/40-fix.sh
fi
