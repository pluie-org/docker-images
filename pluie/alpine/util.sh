#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

function preInit(){
    for i in ls $1/*.sh
    do
        if [ -e "${i}" ]; then
            echo "[[ Processing $i ]]"
            . "${i}"
        fi
    done
}
