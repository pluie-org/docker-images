#!/bin/bash
# @app      pluie/libyaml
# @author   a-Sansara https://git.pluie.org/pluie/docker-images
export DEBCONF_NONINTERACTIVE_SEEN=true 
export DEBIAN_FRONTEND=noninteractive
echo "Updating system..."
apt install -y glib-2.0-dev libgee-0.8-dev libyaml-dev git gcc valac meson
mkdir /home/repo; cd $_;
echo "Installing pluie-echo dependency"
git clone https://git.pluie.org/pluie/libpluie-echo.git
cd libpluie-echo
meson --prefix=/usr ./ build
ninja install -C build
pkg-config --libs pluie-echo-0.2
