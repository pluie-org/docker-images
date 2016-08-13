# docker-images

various based images for Docker

## Available Images

- [index][1]
- [pluie/alpine][2]                       ( < 10 MB ) Alpine/3.4
    - [pluie/alpine-apache][3]            ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24
    - [pluie/alpine-apache-fpm][7]        ( ~ 50 MB ) Apache/2.4.23 Php/5.6.24 Fpm
        - [pluie/alpine-symfony][6]       ( ~ 82 MB ) Symfony2.8 or 3.1
    - [pluie/alpine-mysql][4]             ( ~172 MB ) MariaDb/10.1.14
- [docker tips][5]

## Base Image Structure

```
project/
   |
   |-- install.d/   # deployed in /scripts on target container
   |      |         # launch on docker image building process
   |      |         # XX-name.sh - low XX are run first
   |      |-- 00-util.sh
   |      |-- 40-fix.sh
   |
   |-- pre-init.d/  # deployed in /scripts on target container
   |      |         # launch on docker container running process
   |      |-- 50-builder.sh
   |
   |-- build        # build docker image : ./build [TAG]
   |-- common.sh    # don't modify - sourced by main.sh to execute pre-init.d scripts first
   |-- install.sh   # don't modify - execute install.d scripts on docker building process
   |-- main.sh      # source common.sh then execute entry point instruction
   |-- util.sh      # sourced by common.sh
```

## Extended Image Structure

```
project/
   |
   |-- install.d/
   |-- pre-init.d/
   |
   |-- build        # same as based image
   |-- main.sh      # source based common.sh then execute entry point instruction
```

## Extended Image Dockerfile

in any case, keep that :
```
FROM $baseImage

MAINTAINER $author $url

ADD files.tar /scripts

RUN bash /scripts/install.sh
```

then define only
__EXPOSE VOLUME__ & __ENV__ instructions

## Building Process

__build__ script archive project files in __files.tar__ then execute the __Docker build__ command.
```
./build [optionalTag]
```

no need to worry about pwd, docker repository and image name depends on directory structure.
you can keep same __build__ script in any project

 [1]: https://github.com/pluie-org/docker-images
 [2]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine
 [3]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache
 [4]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-mysql
 [7]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-apache-fpm
 [5]: https://github.com/pluie-org/docker-images/blob/master/DOCKER.md
 [6]: https://github.com/pluie-org/docker-images/tree/master/pluie/alpine-symfony
