#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk add git vala gcc musl-dev python3 ninja \
&& pip3 install meson \
&& git clone https://github.com/pluie-org/libpluie-echo.git \
&& cd libpluie-echo/ \
&& meson --prefix=/usr ./ build \
&& ninja install -C build \
