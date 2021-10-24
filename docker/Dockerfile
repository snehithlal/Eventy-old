FROM ruby:3.0.0-alpine

ENV BUNDLE_VERSION 2.2.25
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV RAILS_PORT 3000

RUN apk add --update --virtual \
  runtime-deps \
  build-base \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  postgresql-dev \
  libc-dev \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /app

COPY ./docker/development/start.sh /usr/local/bin/dev-entrypoint.sh
COPY ./docker/test/start.sh /usr/local/bin/test-entrypoint.sh
RUN chmod +x /usr/local/bin/test-entrypoint.sh \
  && chmod +x /usr/local/bin/dev-entrypoint.sh

RUN gem install bundler -v=$BUNDLE_VERSION \
  && rm -rf $GEM_HOME/cache/*

WORKDIR /app

EXPOSE $RAILS_PORT

ENTRYPOINT ['bundle', 'exec']
