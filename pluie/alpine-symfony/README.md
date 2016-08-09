# pluie/alpine-symfony

- [index][1]
- [image pluie/alpine][2]
- [image pluie/alpine-mysql][3]
- [image pluie/alpine-apache][4]
- [image pluie/alpine-symfony][6]
- [docker tips][5]

Extend pluie/alpine-apache.  
if __/app/$WWW_DIR__ does not exits then __pluie/alpine-symfony__ install  
the symfony framework with $SYMFONY_VERSION version on the /app directory

## Image Size

- image ~ 81 MB

## ENV variables

```
  SYMFONY_VERSION=3.1             # symfony version
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

__/app__ directory is a docker volume bind to your symfony project


## Image Usage

chdir to your project directory
```
$ docker run --name symfony -it --link=mysql:db1 -v $(pwd):/app pluie/alpine-symfony
```
or
```
$ docker run --name symfony -it --link=mysql:db1 -e HTTP_SERVER_NAME=yourServerName -v $(pwd):/app pluie/alpine-symfony
```

## Connect to container

```
$ docker exec -it symfony bash
```

## Controling http server

```
$ docker exec -it apache "httpd -k restart"
```
for more commands :
```
$ docker exec -it apache "httpd -h"
```

 [1]: https://github.com/pluie-org/docker-images
 [2]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine
 [3]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-mysql
 [4]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache
 [5]: https://github.com/pluie-org/docker-images/blob/master/DOCKER.md
 [6]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-symfony
