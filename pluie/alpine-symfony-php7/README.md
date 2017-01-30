# pluie/alpine-symfony-php7

- [index][1]
- [pluie/alpine][2]                       ( < 10 MB ) Alpine/3.4
    - [pluie/alpine-apache][3]            ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24
    - [pluie/alpine-apache-fpm][7]        ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24 Fpm
        - [pluie/alpine-symfony][6]       ( ~ 82 MB ) Symfony2.8 or 3.1
    - [pluie/alpine-apache-php7][8]       ( ~ 50 MB ) Apache/2.4.25 Php/7.0.15
        - [pluie/alpine-symfony-php7][9]  ( ~ 82 MB ) Symfony2.8 or 3.2 Php/7.0.15
    - [pluie/alpine-mysql][4]             ( ~172 MB ) Mysql/5.5.47 ( MariaDB )
- [docker tips][5]

Extend pluie/alpine-apache-php7.
  
if __/app/$WWW_DIR__ does not exits then __pluie/alpine-symfony-php7__ install  
the symfony framework with $SYMFONY_VERSION version on the /app directory

## Image Size

- image ~ 82 MB

## ENV variables

```
  SYMFONY_VERSION=3.2               # symfony version
```

### Inherit ENV variables

```
 HTTP_SERVER_NAME=symfony.docker    # apache ServerName  
          WWW_DIR=web               # DocumentRoot relative to volume  
        WWW_INDEX=app.php           # DirectoryIndex
        SHENV_CTX=LOCAL             # LOCAL|INT|PROD change context bg color
       SHENV_NAME=symfony           # container name 
      SHENV_COLOR=33                # ANSI EXTENDED COLOR CODE
    FIX_OWNERSHIP=1
               TZ=Europe/Paris      # TIMEZONE
```

## Image Volumes

- __/app__ directory is a docker volume bind to your symfony project

__/app/$WWW_DIR__ is the documentRoot.  

__/app/vhost__ is your app vhost configuration file (with a serverName directive).
by default it use the apache rewrite module to redirect all uri to entry point $WWW_INDEX 


## Image Usage

chdir to your project directory
```
$ docker run --name symfony -it --link=mysql:db -v $(pwd):/app pluie/alpine-symfony-php7
```
or
```
$ docker run --name symfony -d --link=mysql:db -e HTTP_SERVER_NAME=yourServerName -v $(pwd):/app pluie/alpine-symfony-php7
```

## Connect to container

```
$ docker exec -it symfony bash
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
