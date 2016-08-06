#!/bin/bash
# @app      pluie/alpine-mysql
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

. /scripts/util.sh

function mysql.secure(){
    chown mysql:mysql $1
    sleep 5
    initTitle "SECURING" "DATABASE"
    echo "please wait."
    sleep 5
    rm -f $1
    echo "done"
}

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then

    initTitle "Initialize" "DATABASE"
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql --verbose=1 --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

    if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
        MYSQL_ROOT_PASSWORD=`pwgen -y -s 18 1`
    fi

    MYSQL_DATABASE=${MYSQL_DATABASE:-""}
        MYSQL_USER=${MYSQL_USER:-""}
    MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat <<-EOF > $tfile
UPDATE mysql.user SET password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE user='root';
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1', '$(hostname)');
DELETE FROM mysql.user WHERE user='';
DELETE FROM mysql.db WHERE db='test' OR db='test\_%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE mysql.user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

    if [ ! -z "$MYSQL_DATABASE" ]; then
        echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
    fi
    if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_USER" != 'root' ]; then
        echo "
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        if [ ! -z "$MYSQL_DATABASE" ]; then
            echo "
GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        fi
    fi
    echo "FLUSH PRIVILEGES;" >> $tfile

    mysql.secure $tfile &

    initTitle "Starting" "Mysql Daemon"
    exec /usr/bin/mysqld --user=mysql --console --init-file="$tfile"

else
    initTitle "Skipping" "DB init"
    initTitle "Starting" "Mysql Daemon"
fi
