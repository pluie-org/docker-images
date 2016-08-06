#!/bin/bash
# @app      pluie/alpine-mysql
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

Ctitle="\033[1;48;5;30;1;38;5;15m"
 Ctext="\033[1;38;5;30m"
  Copt="\033[1;38;5;72m"
  Cspe="\033[1;38;5;30m"
  Cerr="\033[1;38;5;196m"
  Cusa="\033[1;38;5;214m"
  Coff="\033[m"

function echoTitle(){
    echo -e "\n ${Ctitle}  $shname  ${Coff}"
}

function mktfile(){
    tfile="$(mktemp)"
    if [ ! -f "$tfile" ]; then
        echoErr "can't make temp file" 1
        exit 1
    fi
}

function errEmptyDb(){
    echoErr "database can't be empty"
}

function echoErr(){
    echo -e "\n${Cerr} error : $1${Coff}"
    if [ -z "$2" ]; then
        usage
    fi
    echo
    exit 1
}
