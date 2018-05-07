FROM ruby:2.5.1-alpine3.7

ENV APP=/app
ENV CODES=/codes
ENV WORK=/work

ENV DOCKER_CLIENT_VERSION=18.03.1-ce

RUN mkdir $APP $CODES $WORK
WORKDIR $APP

COPY Gemfile Gemfile.lock ./

RUN apk add --update --no-cache build-base curl \
 && bundle install \
 && curl -SLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
 && tar xvf docker-${DOCKER_CLIENT_VERSION}.tgz \
 && mv docker/* /usr/local/bin \
 && apk del build-base curl \
 && rm docker-${DOCKER_CLIENT_VERSION}.tgz \
 && rmdir docker

ENTRYPOINT ["ruby", "monitor.rb"]
