# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.3.6
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Установка базовых пакетов
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    nodejs \
    yarn \
    build-essential \
    git \
    libpq-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Установка переменных окружения для разработки
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production" \
    WEBPACKER_DEV_SERVER_HOST="0.0.0.0"

# Установка зависимостей
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Копируем код приложения
COPY . .

# Настройка прав доступа
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/*

# Expose port for development server
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
