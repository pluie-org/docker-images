FROM alpine:3.4

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

RUN apk --update add bash && bash /scripts/install.sh

ENV     TERM=xterm \
   SHENV_CTX=LOCAL \
  SHENV_NAME=Alpine \
 SHENV_COLOR=97

ENTRYPOINT ["/scripts/main.sh"]
