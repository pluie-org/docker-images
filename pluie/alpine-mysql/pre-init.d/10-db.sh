#!/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[[ Initialize DB ]]"
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql > /dev/null

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

    cat << EOF > $tfile
USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

    if [ ! -z "$MYSQL_DATABASE" ]; then
        echo "[[ CREATE DATABASE $MYSQL_DATABASE ]]";
        echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
    fi
    if [ "$MYSQL_USER" != "" ] && [ "$MYSQL_USER" != 'root' ]; then
        echo "[[ CREATE USER $MYSQL_USER ]]";
        echo "
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        if [ ! -z "$MYSQL_DATABASE" ]; then
            echo "
GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        fi
    fi
    /usr/bin/mysqld --user=mysql --bootstrap --skip-grant-tables=0 --verbose=0 < $tfile
    rm -f $tfile
fi
