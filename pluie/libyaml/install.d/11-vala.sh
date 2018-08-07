#!/bin/bash
# @app      pluie/libyaml
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk add yaml-dev libgee-dev \
&& git clone https://github.com/pluie-org/lib-yaml.git \
&& cd lib-yaml/ \
&& meson --prefix=/usr ./ build \
&& ninja install -C build \
&& ./build.sh
