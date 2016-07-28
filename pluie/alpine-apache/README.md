# pluie/alpine-apache

This Image extend pluie/alpine with apache2 2.4.16

- error log are attached to stdout
- no need port redirection
- you can use env var at container creation : __HTTP_SERVER_NAME__ (default : docker-site.dev ortherwise edit app/vhost later)
- you can still use ever your local http & sql server while your container(s) are running


## Docker image size

- image ~ 37 MB


## Docker image volumes

__/app__ directory is a docker volume bind to your app project (silex/symfony etc)  

__/app/www/__ is the documentRoot.  
put only your entry point and static files to the documentRoot directory, no your app sources
(__/app__ directory is design for this).

__/app/vhost__ is your app vhost configuration file (with a serverName directive).
by default it use the apache rewrite module to redirect all uri to the unique entry point index.php 

```
/app/            # your application directory
  |
  |---- www/     # documentRoot
  |
  |---- vhost    # apache app vhost
```


## Docker image usage

chdir to your project directory
```
$ docker run --name apache -it --link=db1:mysql -v $(pwd):/app pluie/apache
```
or
```
$ docker run --name srv -it --link=db1:mysql -e HTTP_SERVER_NAME=yourServerName -v $(pwd):/app pluie/apache
```


## Controling http server

```
$ docker exec -it apache "httpd -k restart"
```
for more commands :
```
$ docker exec -it apache "httpd -h"
```