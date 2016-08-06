#!/usr/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

if [ ! -z "/app/vhost" ]; then
    cat <<EOF > "/app/vhost"
<VirtualHost *:80>
    ServerName $HTTP_SERVER_NAME
    <Directory /app/www>
        AllowOverride None
        Require all granted
        DirectoryIndex index.php
        <IfModule mod_rewrite.c>
            Options -MultiViews +FollowSymlinks
            RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteRule ^ index.php [QSA,L]
        </IfModule>
    </Directory>
</VirtualHost>
# IncludeOptional /app/vhost2
EOF
fi
