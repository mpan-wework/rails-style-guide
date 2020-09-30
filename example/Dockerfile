FROM ruby:2.6.6-alpine3.12
RUN apk --update add build-base nodejs tzdata git \
    postgresql-dev libxslt-dev libxml2-dev \
    yarn libcurl \
    && rm -rf /var/cache/apk/*
RUN gem install bundler
WORKDIR /var/www/server
COPY Gemfile* ./
RUN bundle install
