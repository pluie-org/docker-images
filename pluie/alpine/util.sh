#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

function bash_prompt() {
     local Cenvcode="243"
    if [ "$SHENV_CTX" = "INT" ]; then
     local Cenvcode="202"
    elif [ "$SHENV_CTX" = "PROD" ]; then
     local Cenvcode="160"
    fi
    local Cdate="\[\033[1;33m\]"
     local Cctx="\[\033[1;48;5;${Cenvcode}m\]"
    local Cname="\[\033[1;48;5;${SHENV_COLOR}m\]"
    local Cpath="\[\033[1;38;5;36m\]"
   local Cwhite="\[\033[1;38;5;15m\]"
    local Chost="\[\033[1;38;5;15m\]"
  local Csymbol="\[\033[1;38;5;15m\]"
    local Cuser="\[\033[1;38;5;203m\]"
     local Coff="\[\033[m\]"

    export PS1="${Cdate}\t ${Cwhite}${Cctx} DOCKER ${SHENV_CTX} ${Cname} ${SHENV_NAME} ${Coff} ${Cuser}\u${Chost}@\h ${Cpath}\w ${Csymbol}\$ ${Coff}"
}

function preInit(){
    for i in ls $1/*.sh
    do
        if [ -e "${i}" ]; then
            echo "[[ Processing $i ]]"
            . "${i}"
        fi
    done
}
