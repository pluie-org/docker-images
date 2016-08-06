#!/bin/bash
# @app      pluie/alpine-mysql
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/dbcommon.sh

dbname=${1:-''}
dbuser=${2:-''}
shname=$(basename $0)

echoTitle

function usage(){
    echo -e "\n ${Cusa}usage :${Coff}\n    ${Ctext}$shname \t${Copt}DBNAME ${Cspe}[${Copt}USER${Cspe}]${Coff}"
}

mktfile

if [ ! -z "$dbname" ]; then
    cat <<EOF > "$tfile"
CREATE DATABASE IF NOT EXISTS \`$dbname\` CHARACTER SET utf8 COLLATE utf8_general_ci;
EOF

    if [ ! -z "$dbuser" ]; then
    cat <<EOF >> "$tfile"
GRANT ALL ON \`$dbname\`.* to '$dbuser'@'localhost';
GRANT ALL ON \`$dbname\`.* to '$dbuser'@'%';
EOF
    fi

    echo "FLUSH PRIVILEGES;" >> "$tfile"
    echo
    cat "$tfile" | sed "s/^/    /";
    echo
    mysql -uroot < "$tfile"
    if [ $? -eq 0 ]; then
        echo -e "\n done"
    fi
    echo
    rm -f "$tfile"
else
    errEmptyDb
fi
