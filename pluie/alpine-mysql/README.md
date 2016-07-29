# pluie/alpine-mysql

Extend pluie/alpine with mysql (mariadb) 5.5.47


## Image Size

- image ~ 160 MB

## Image Volumes

__/var/lib/mysql__ : mysql database directory  
__/dump__         : directory to store various mysql scripts  

## ENV variables

__MYSQL_DATABASE__      : create specified database at startup  
__MYSQL_USER__          : create specified user at startup (and grant all rights to __MYSQL_DATABASE__)  
__MYSQL_PASSWORD__  
__MYSQL_ROOT_PASSWORD__ : don't really need it. a random root password is generated if none  


## Image Usage

```
$ docker run --name mysql -p 3306 -v /home/docker/db/mysql:/var/lib/mysql -v /home/docker/db/dump:/dump -e MYSQL_DATABASE=mybase -e MYSQL_USER=dev -e MYSQL_PASSWORD=mysql -it pluie/alpine-mysql
```

### Root Usage

a root user is created at startup (if database directory is empty)  
root login is permit only on localhost   
to do things without files you can run :
```
$ docker exec -it mysql "mysql -uroot"
```
to do things with files you can log in to container :  
```
docker exec -it mysql bash
```
then  
```
$ mysql -uroot mybase < /dump/mydump.sql
```
etc.  


### User usage

locally (on host) you can run (with appropriate user : pass) :  
```
mysql -h ipmysqlcontainer -udev -pmysql
```
or if you want use the mysql client of the container :
```
docker exec -it mysql "mysql -h ipmysqlcontainer -udev -pmysql"
```

## Link Container

to link this container to another, use the default docker behavior :
```
docker run --name mycontainer --link mysql:db ...
```
