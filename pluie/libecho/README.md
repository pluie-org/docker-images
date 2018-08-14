# pluie/libecho

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

demo image demonstrating libpluie-echo, a small vala shared library managing tracing, display formatting and ansi-extended colors on stdout & stderror.

you can run a container with :

```
docker run --rm -it pluie/libecho
```

## repository

https://github.com/pluie-org/libpluie-echo

## samples

![Sample 1 code](https://www.meta-tech.academy/img/libpluie-echo_sample_code1.png?tmp=1)
![Sample 1 output](https://www.meta-tech.academy/img/libpluie-echo_sample1.png)
![Sample 2 code](https://www.meta-tech.academy/img/libpluie-echo_sample_code2.png?tmp=1)
![Sample 2 output](https://www.meta-tech.academy/img/libpluie-echo_sample2.png)


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
