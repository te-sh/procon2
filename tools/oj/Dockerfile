FROM python:3.6.5-alpine3.7

ENV APP=/app
ENV WORK=/work

ENV DOCKER_CLIENT_VERSION=18.03.1-ce

RUN mkdir $WORK
WORKDIR $WORK

RUN apk add --update --no-cache build-base libxml2-dev libxslt-dev curl \
 && pip3 install online-judge-tools \
 && curl -SLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
 && tar xvf docker-${DOCKER_CLIENT_VERSION}.tgz \
 && mv docker/* /usr/local/bin \
 && apk del build-base curl \
 && rm docker-${DOCKER_CLIENT_VERSION}.tgz \
 && rmdir docker
