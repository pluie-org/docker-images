#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

. /scripts/dbcommon.sh

dbname=${1:-''}
shname=$(basename $0)

echoTitle

function usage(){
    echo -e "\n ${Cusa}usage :${Coff}\n    ${Ctext}$shname \t${Copt}DBNAME USER${Coff}"
}

if [ ! -z "$1" ]; then
    mysqldump -uroot "$dbname" > "/dump/"$(date +"%y%m%d-%H%I")".$dbname.sql"
    if [ $? -eq 0 ]; then
        echo -e "\n done"
    fi
    echo
else
    errEmptyDb
fi
