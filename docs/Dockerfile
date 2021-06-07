FROM ruby:2.7.3-alpine3.13 as build

RUN apk add --update --no-cache build-base

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN bundle update --bundler && bundle install

FROM ruby:2.7.3-alpine3.13

RUN apk add --update --no-cache dumb-init
COPY --from=build /usr/local/bundle /usr/local/bundle

ENV DOCS=/docs
WORKDIR $DOCS

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bundle", "exec", "jekyll", "serve", "--incremental", \
     "--host", "0.0.0.0", "--destination", "/site"]
