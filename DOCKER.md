## Docker

- [index][1]
- [pluie/alpine][2]                       ( < 10 MB ) Alpine/3.4
    - [pluie/alpine-apache][3]            ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24
    - [pluie/alpine-apache-fpm][7]        ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24 Fpm
        - [pluie/alpine-symfony][6]       ( ~ 82 MB ) Symfony2.8 or 3.1
    - [pluie/alpine-apache-php7][8]       ( ~ 50 MB ) Apache/2.4.25 Php/7.0.15
        - [pluie/alpine-symfony-php7][9]  ( ~ 82 MB ) Symfony2.8 or 3.2 Php/7.0.15
    - [pluie/alpine-mysql][4]             ( ~172 MB ) Mysql/5.5.47 ( MariaDB )
- [docker tips][5]

### Networking

#### create network
```
docker network create \
--subnet=172.22.0.0/16 \
--gateway=172.22.0.1 \
-o "com.docker.network.bridge.name"="home0" \
home0
```

#### inspect ip
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container
```

#### /etc/hosts
```
# > DOCKER - bridge home0
172.22.0.2	db.docker
172.22.0.3	gogs.docker
172.22.0.4	pma.docker
172.22.0.5	bo-payment.docker
172.22.0.6	wordpress.docker
172.22.0.7	fpm.docker
172.22.0.8	symfony.docker
# <

```

### Util

#### remove all container
```
docker rm $(docker ps -a -q)
```
rm -v to also remove volume  
rm -f to force stop running container before removing


#### remove none images
```
docker rmi $(docker images | grep "^<none>" | awk "{print \$3}")
```

#### remove all volumes
```
docker volume rm $(docker volume ls -qf dangling=true)
```

#### logs container
```
docker logs -f container
```

#### stats container
```
docker stats container
```

### Pluie container

#### map

[db.docker] (http://db.docker)  
[pma.docker] (http://pma.docker)  
[gogs.docker] (http://gogs.docker)  
[bo-payment.docker] (http://bo-payment.docker)  
[wordpress.docker] (http://wordpress.docker)  
[fpm.docker] (http://symfony.docker)  
[symfony.docker] (http://symfony.docker)  

#### Mysql
```
cd /home/dev/docker

docker run --name mysql --restart=always \
--net home0 -h db.docker --ip 172.22.0.2 \
-v $(pwd)/db/mysql:/var/lib/mysql \
-v $(pwd)/db/dump:/dump \
-e MYSQL_DATABASE=bo-payment \
-e MYSQL_USER=dev \
-e MYSQL_PASSWORD=mysql \
-d pluie/alpine-mysql
```

#### Gogs
```
cd /home/dev/docker

docker run --name gogs --restart=always \
--net home0 -h gogs.docker --ip 172.22.0.3 --link mysql:db \
-v $(pwd)/gogs:/data \
gogs/gogs
```

#### Phpmyadmin
```
docker run --name pma --restart=always \
--net home0 -h pma.docker --ip 172.22.0.4 --link mysql:db \
-d phpmyadmin/phpmyadmin
```

#### Apache
```
cd /home/dev/docker

docker run --name apache --restart=always \
--net home0 -h bo-payment.docker --ip 172.22.0.5 --link mysql:db \
-v $(pwd)/repo/bo-payment:/app \
-e HTTP_SERVER_NAME=bo-payment.docker \
-d pluie/alpine-apache
```

#### Wordpress
```
cd /home/dev/docker

docker run --name wordpress --restart=always \
--net home0 -h wordpress.docker --ip 172.22.0.6 --link mysql:db \
-v $(pwd)/repo/blog:/app \
-e HTTP_SERVER_NAME=wordpress.docker \
-d pluie/alpine-apache
```

#### ApacheFpm
```
cd /home/dev/docker

docker run --name afpm --restart=always \
--net home0 -h fpm.docker --ip 172.22.0.7 --link mysql:db \
-v $(pwd)/repo/afpm:/app \
-e HTTP_SERVER_NAME=afpm.docker \
-d pluie/alpine-apache-fpm
```

### Symfony
```
cd /home/dev/docker
docker run --name symfony --restart=always \
--net home0 -h symfony.docker --ip 172.22.0.8 --link=mysql:db \
-e HTTP_SERVER_NAME=symfony \
-e SYMFONY_VERSION=2.8 \
-v $(pwd)/repo/myapp:/app \
-d pluie/alpine-symfony
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
