FROM ruby:2.5.1-alpine3.7

ENV DOCS=/docs

WORKDIR $DOCS

COPY Gemfile Gemfile.lock ./

RUN apk add --update --no-cache build-base \
 && bundle install \
 && apk del build-base

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
