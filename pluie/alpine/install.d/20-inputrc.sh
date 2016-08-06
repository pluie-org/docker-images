#!/bin/bash
# @app      pluie/alpine
# @author   a-Sansara https://git.pluie.org/pluie/docker-images
#
# Keyboard shortcut : Ctrl+x followed by desired key 
# refresh without bash logout : bind -f ~/.inputrc

cat <<EOF > /etc/inputrc
"\e[1;5C": forward-word             # ctrl + right
"\e[1;5D": backward-word            # ctrl + left
"\e[1~": beginning-of-line          # home
"\e[3~": delete-char                # delete
"\e[4~": end-of-line                # end
"\e[5~": history-search-backward    # page-up
"\e[6~": history-search-forward     # page-down
EOF
