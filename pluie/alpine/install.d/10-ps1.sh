#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)
echo "ps1"
if [ ! -f /root/.bash_ps1 ]; then 
    echo "existe pas"
else
    echo "existe"
fi
if [ ! -f /root/.bash_ps1 ]; then 
    cat <<EOF >> /root/.bashrc
if [ -f ~/.bash_ps1 ]; then
    . ~/.bash_ps1
fi
EOF

    sed -n '1,22 p' /scripts/util.sh > /root/.bash_ps1
    echo "bash_prompt" >> /root/.bash_ps1
fi
