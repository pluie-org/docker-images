FROM pluie/alpine

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

RUN bash /scripts/install.sh

ENV SHENV_NAME=Mysql SHENV_COLOR=132

EXPOSE 3306

VOLUME ["/var/lib/mysql", "/dump"]
