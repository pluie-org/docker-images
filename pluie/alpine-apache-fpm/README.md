# pluie/alpine-apache

- [index][1]
- [pluie/alpine][2]                       ( ~  9 MB ) Alpine/3.5
    - [pluie/alpine-apache][3]            ( ~ 50 MB ) Apache/2.4.25 Php/5.6.30
    - [pluie/alpine-apache-fpm][7]        ( ~ 51 MB ) Apache/2.4.25 Php/5.6.30 Fpm
        - [pluie/alpine-symfony][6]       ( ~ 83 MB ) Symfony2.8 or 3.2
    - [pluie/alpine-apache-php7][8]       ( ~ 45 MB ) Apache/2.4.25 Php/7.0.16
        - [pluie/alpine-symfony-php7][9]  ( ~ 77 MB ) Symfony2.8 or 3.2 Php/7.0.16
    - [pluie/alpine-mysql][4]             ( ~181 MB ) Mysql/5.6 ( MariaDB )
    - [pluie/libecho][10]                 ( ~288 MB ) Vala 0.34.2 pluie-echo-0.2
- [pluie/ubuntu][12]                      ( ~141 MB ) Ubuntu 18.04
    - [pluie/libyaml][11]                 ( ~538 MB ) Vala 0.40.4 pluie-yaml-0.4
- [docker tips][5]

Extend pluie/alpine with __apache 2.4.25__ and __php 5.6.30__ with FPM

- you can use env var at container creation : __HTTP_SERVER_NAME__ (default : fpm.docker ortherwise edit app/vhost later)


## Image Size

- image ~ 51 MB

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
 [8]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache-php7
 [9]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-symfony-php7
 [10]: https://github.com/pluie-org/docker-images/tree/master/pluie/libecho
 [11]: https://github.com/pluie-org/docker-images/tree/master/pluie/libyaml
 [12]: https://github.com/pluie-org/docker-images/tree/master/pluie/ubuntu
