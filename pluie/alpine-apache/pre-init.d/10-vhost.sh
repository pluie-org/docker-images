#!/usr/bin/bash
# pluie/docker-images - a-Sansara (https://github.com/a-sansara)

if [ ! -z "/app/vhost" ]; then
    cat <<EOF > "/app/vhost"
<VirtualHost *:80>
    ServerName $HTTP_SERVER_NAME
    <Directory /app/www>
        AllowOverride None
        Allow from all
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
