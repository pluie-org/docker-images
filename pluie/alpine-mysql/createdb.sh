#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

dbname=${1:-''}
dbuser=${2:-''}

echo "dbname : $dbname"
echo "dbuser : $dbuser"

tfile=`mktemp`
if [ ! -f "$tfile" ]; then
    return 1
fi

if [ ! -z "$dbname" ]; then
    cat <<EOF > $tfile
CREATE DATABASE IF NOT EXISTS \`$dbname\` CHARACTER SET utf8 COLLATE utf8_general_ci;
EOF

    if [ ! -z "$dbuser" ]; then
    cat <<EOF >> $tfile
GRANT ALL ON \`$dbname\`.* to '$dbuser'@'localhost';
GRANT ALL ON \`$dbname\`.* to '$dbuser'@'%';
EOF
    fi

    echo "FLUSH PRIVILEGES;" >> $tfile
    cat $tfile;
    mysql -uroot < $tfile
    rm -f $tfile
fi

