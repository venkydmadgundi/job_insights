# ./base/Dockerfile
FROM ruby:3.2.2-alpine AS base

RUN apk add --no-cache \
    bash \
    vim \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs \
    yarn

WORKDIR /app
COPY Gemfile* ./
RUN bundle config set force_ruby_platform true
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh
RUN bundle install --jobs=4 --retry=3

COPY . .

# All microservices inherit from this
