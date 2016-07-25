FROM gliderlabs/alpine:3.2

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

RUN apk --update add bash && bash /scripts/install.sh

ENV TERM=xterm HTTP_SERVER_NAME=docker-site.dev FIX_OWNERSHIP=1

ENTRYPOINT ["/scripts/main.sh"]
