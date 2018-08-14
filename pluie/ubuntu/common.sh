#!/bin/bash
# @app      pluie/ubuntu
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/util.sh

# execute any pre-init scripts wich is useful for images based on this image
# /scripts/pre-init.d/XX-name.sh 
# low XX are run first
preInit "/scripts/pre-init.d"
