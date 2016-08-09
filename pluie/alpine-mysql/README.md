# pluie/alpine-mysql

- [index][1]
- [image pluie/alpine][2]
- [image pluie/alpine-apache][4]
- [image pluie/alpine-symfony][6]
- [docker tips][5]

Extend pluie/alpine with mysql (mariadb) 5.5.47  
Project comes with various scripts to execute basic tasks such as :  
- dbcreate
- dbdump
- dbload

If database directory is empty a root user is created at startup.  
Root access to database is only permit on localhost   

## Image Size

- image ~ 172 MB

## Image Volumes

```
/var/lib/mysql          # mysql database directory  
/dump                   # directory to store various mysql scripts  
```

## ENV variables

```
     MYSQL_DATABASE     # create specified database at startup  
         MYSQL_USER     # create specified user at startup (and grant all rights to MYSQL_DATABASE)  
     MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD     # don't really need it. a random root password is generated if none  
```

### Inherit ENV variables

```
   SHENV_CTX=LOCAL      # LOCAL|INT|PROD change context bg color
  SHENV_NAME=Mysql      # container name 
 SHENV_COLOR=97         # ANSI EXTENDED COLOR CODE
```

## Image Usage

for example to start a new project :
```
$ cd /home/docker;
$ mkdir -p db/{mysql,dump}

$ docker run --name mysql \
-v $(pwd)/db/mysql:/var/lib/mysql \
-v $(pwd)/db/dump:/dump \
-e MYSQL_DATABASE=mybase \
-e MYSQL_USER=dev \
-e MYSQL_PASSWORD=mysql \
-it pluie/alpine-mysql
```
you don't need to expose your localhost mysql port.
for example :

```
$ docker run --name pma -p 8080:80 --link mysql:db -d phpmyadmin/phpmyadmin
```

and phpmyadmin is accessible via http://localhost:8080/ and linked to your mysql container


### Existing Scripts

create a new database with full rights to a user  :
```
$ docker exec -it mysql /dbcreate mydbname myuser
```
load an export file in particular database :
```
$ docker exec -it mysql /dbload mydbname /dump/mydbname.init.sql
```
dump a database :
```
$ docker exec -it mysql /dbdump mydbname
```

### More specific actions as user

to connect to the mysql server as user from host :
```
mysql -h ipmysqlcontainer -udev -pmysql
```
to retriew container ip you can run first :
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql
```
to connect to the mysql server as user from container :
```
$ docker exec -it mysql "mysql -udev -pmysql"
```

### More specific actions as root

to connect to the mysql server as root :
```
$ docker exec -it mysql "mysql -uroot"
```
to connect to the mysql container as root :  
```
docker exec -it mysql bash
```
then  
```
$ mysql -uroot mybase < /dump/init.mybase.sql
$ mysqldump -uroot mybase > /dump/last.mybase.dump.sql
```
etc.


## Link Container

to link this container to another, use the default docker behavior 
(as the example provide with phpmyadmin) :
```
docker run --name mycontainer --link mysql:db ...
```


 [1]: https://github.com/pluie-org/docker-images
 [2]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine
 [3]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-mysql
 [4]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache
 [5]: https://github.com/pluie-org/docker-images/blob/master/DOCKER.md
 [6]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-symfony
