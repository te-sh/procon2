FROM ruby:2.6.0-alpine3.8 as build

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN apk add --update --no-cache build-base
RUN bundle install

FROM ruby:2.6.0-alpine3.8

COPY --from=build /usr/local/bundle /usr/local/bundle

ENV DOCS=/docs
WORKDIR $DOCS

ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--destination", "/site"]
