FROM ruby:2.6.5-alpine3.10 as build

RUN apk add --update --no-cache build-base

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM ruby:2.6.5-alpine3.10

RUN apk add --update --no-cache dumb-init
COPY --from=build /usr/local/bundle /usr/local/bundle

ENV DOCS=/docs
WORKDIR $DOCS

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bundle", "exec", "jekyll", "serve", "--incremental", \
     "--host", "0.0.0.0", "--destination", "/site"]
