#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

ARG FULL_PHP_VERSION=8.1-alpine

FROM php:${FULL_PHP_VERSION}

ARG FULL_PHP_VERSION=alpine
ARG PHP_VERSION=8.1


###########################################################################
# Install dev dependencies
###########################################################################
RUN apk add --no-cache --virtual .build-deps \
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
    make \
    mysql-client \
    nodejs \
    yarn \
    yaml-dev \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    libzip-dev

###########################################################################
# Update PECL channel
###########################################################################
RUN pecl channel-update pecl.php.net

###########################################################################
# Install PECL and PEAR extensions
###########################################################################
RUN pecl install \
    imagick \
    xdebug \
    redis \
    yaml

###########################################################################
# Install and enable php extensions
###########################################################################
RUN if [ $PHP_VERSION != "8.2.0alpha1" && $PHP_VERSION != "8.2" ]; then \
    docker-php-ext-enable \
        xdebug \
        imagick \
        redis \
        yaml \
    ;fi

RUN docker-php-ext-configure zip

RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
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

RUN if [ $PHP_VERSION = "7.4" ]; then \
        docker-php-ext-install \
            tokenizer \
            sockets \
    ;fi

# Install Composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
RUN composer --version

# Install Composer's dependencies
RUN composer global require deployer/deployer:^7.0.0-rc.8
RUN composer global require dragon-code/codestyler:^2.2

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Show PHP version
RUN php -v

# Setup working directory
WORKDIR /var/www
