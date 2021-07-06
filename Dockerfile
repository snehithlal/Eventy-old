FROM ruby:3.0.0-alpine
ENV BUNDLER_VERSION=2.2.3
RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      postgresql-dev \
      py-pip \
      tzdata
RUN gem install bundler -v 2.2.3
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
COPY . ./
ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]
