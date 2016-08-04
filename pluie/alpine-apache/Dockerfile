FROM pluie/alpine

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV      SHENV_NAME=Apache \
        SHENV_COLOR=67 \
   HTTP_SERVER_NAME=docker-site.dev \
      FIX_OWNERSHIP=1 \
      TZ=Europe/Paris

EXPOSE 80

RUN bash /scripts/install.sh
