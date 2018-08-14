#!/bin/bash
# @app      pluie/alpine
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ ! -f /root/.bash_ps1 ]; then 
    cat <<EOF >> /root/.bashrc
if [ -f ~/.bash_ps1 ]; then
    . ~/.bash_ps1
fi
EOF
    sed -n '1,22 p' /scripts/util.sh > /root/.bash_ps1
    echo "bash_prompt" >> /root/.bash_ps1
fi
