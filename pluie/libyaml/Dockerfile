# @app      pluie/libyaml
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

FROM pluie/libecho

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV      SHENV_NAME=libyaml \
        SHENV_COLOR=36 \
                 TZ=Europe/Paris

RUN bash /scripts/install.sh
