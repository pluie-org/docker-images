#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

. /scripts/util.sh

# execute any pre-init scripts wich is useful for images based on this image
# /scripts/pre-init.d/XX-name.sh 
# low XX are run first
preInit "/scripts/pre-init.d"
