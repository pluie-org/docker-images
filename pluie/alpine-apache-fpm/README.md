# pluie/alpine-apache

- [index][1]
- [pluie/alpine][2]                       ( < 10 MB ) Alpine/3.4
    - [pluie/alpine-apache][3]            ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24
    - [pluie/alpine-apache-fpm][7]        ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24 Fpm
        - [pluie/alpine-symfony][6]       ( ~ 82 MB ) Symfony2.8 or 3.1
    - [pluie/alpine-apache-php7][8]       ( ~ 50 MB ) Apache/2.4.25 Php/7.0.15
    - [pluie/alpine-mysql][4]             ( ~172 MB ) MariaDb/10.1.14
- [docker tips][5]

Extend pluie/alpine with __apache 2.4.23__ and __php 5.6.24__ with FPM

- you can use env var at container creation : __HTTP_SERVER_NAME__ (default : fpm.docker ortherwise edit app/vhost later)


## Image Size

- image ~ 50 MB

## ENV variables

```
 HTTP_SERVER_NAME=fpm.docker    # apache ServerName  
          WWW_DIR=www           # DocumentRoot relative to volume  
        WWW_INDEX=index.php     # DirectoryIndex
    FIX_OWNERSHIP=1             # 
```

### Inherit ENV variables

```
        SHENV_CTX=LOCAL         # LOCAL|INT|PROD change context bg color
       SHENV_NAME=ApacheFpm     # container name 
      SHENV_COLOR=67            # ANSI EXTENDED COLOR CODE
               TZ=Europe/Paris  # TIMEZONE
```

## Image Volumes

pluie/alpine-apache-fpm has to volumes :

- __/app__ to bind to your app project (silex/symfony etc)  
- __/etc/php5/fpm.d/__ to customize fpm 

### note

__/app/$WWW_DIR__ is the documentRoot.  
put only your entry point and static files to the documentRoot directory, no your app sources
(__/app__ directory is design for this).

__/app/vhost__ is your app vhost configuration file (with a serverName directive).
by default it use the apache rewrite module to redirect all uri to entry point $WWW_INDEX 



```
/app/              # your application directory
  |
  |---- $WWW_DIR/  # documentRoot
  |
  |---- vhost      # apache app vhost
```


## Image Usage

chdir to your project directory
```
$ docker run --name afpm -it --link=mysql:db -v $(pwd):/app pluie/alpine-apache-fpm
```
or
```
$ docker run --name afpm -d --link=mysql:db -e HTTP_SERVER_NAME=yourServerName -v $(pwd):/app pluie/alpine-apache-fpm
```


## Controling http server

```
# reload
$ docker exec -it afpm "httpd -k graceful"
# restart
$ docker exec -it afpm "httpd -k restart"
```
for more commands :
```
$ docker exec -it afpm "httpd -h"
```

 [1]: https://github.com/pluie-org/docker-images
 [2]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine
 [3]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache
 [4]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-mysql
 [7]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache-fpm
 [5]: https://github.com/pluie-org/docker-images/blob/master/DOCKER.md
 [6]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-symfony
 [8]: https://github.com/pluie-org/docker-images/tree/master/pluie/7alpine-php
