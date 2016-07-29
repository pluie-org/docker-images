FROM pluie/alpine

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

RUN bash /scripts/install.sh

ENV      SHENV_NAME=Apache \
        SHENV_COLOR=67 \
   HTTP_SERVER_NAME=docker-site.dev \
      FIX_OWNERSHIP=1

EXPOSE 80

VOLUME /app
