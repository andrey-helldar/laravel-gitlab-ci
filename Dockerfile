ARG FULL_PHP_VERSION=8.3-alpine

FROM php:${FULL_PHP_VERSION}

LABEL maintainer="Andrey Helldar"

ARG FULL_PHP_VERSION=alpine
ARG SHORT_PHP_VERSION=8.3

ENV DEBIAN_FRONTEND noninteractive

###########################################################################
# Update timezones
###########################################################################
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

###########################################################################
# Install dev dependencies
###########################################################################
RUN apk add --update linux-headers

RUN apk update && \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
        oniguruma-dev

###########################################################################
# Install production dependencies
###########################################################################
RUN apk add --no-cache \
    autoconf \
    bash \
    curl \
    g++ \
    gcc \
    git \
    imagemagick \
    libc-dev \
    libpng-dev \
    libzip-dev \
    make \
    mysql-client \
    nodejs \
    openssh-client \
    postgresql-libs \
    rsync \
    wget \
    yaml-dev \
    yarn \
    zlib-dev

###########################################################################
# Update PECL channel
###########################################################################
RUN pecl channel-update pecl.php.net

###########################################################################
# Install PECL and PEAR extensions
###########################################################################
RUN if [[ $SHORT_PHP_VERSION = "8.3" || $FULL_PHP_VERSION = "alpine" ]]; then \
        pecl install redis && \
        docker-php-ext-enable redis \
    ;else \
        pecl install imagick redis xdebug && \
        docker-php-ext-enable imagick redis xdebug \
    ;fi

###########################################################################
# Configure
###########################################################################
RUN docker-php-ext-configure zip

RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    dom \
    exif \
    ftp \
    gd \
    mbstring \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    soap \
    xml \
    zip

###########################################################################
# Install Composer
###########################################################################
ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1

ENV PATH $HOME/.composer/vendor/bin:~/.composer/vendor/bin:./vendor/bin:/vendor/bin:/composer/vendor/bin:$HOME/.composer/vendor/bin:/var/www/vendor/bin:$HOME/.local/composer/vendor/bin:$COMPOSER_HOME/vendor/bin:$PATH

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

###########################################################################
# Install Composer & Node Dependencies
###########################################################################
RUN composer global require \
    deployer/deployer \
    dragon-code/codestyler \
    laravel/pint

RUN curl -fsSL https://bun.sh/install | bash

###########################################################################
# Show Versions
###########################################################################
RUN composer --version
RUN dep --version
RUN codestyle --version
RUN pint --version

RUN php -v
RUN node -v

###########################################################################
# Clean Up
###########################################################################
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www
