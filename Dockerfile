#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

ARG FULL_PHP_VERSION=8.2-alpine

FROM php:${FULL_PHP_VERSION}

ARG FULL_PHP_VERSION=alpine
ARG SHORT_PHP_VERSION=8.2

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
    make \
    mysql-client \
    nodejs \
    yarn \
    yaml-dev \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    libzip-dev \
    wget

###########################################################################
# Update PECL channel
###########################################################################
RUN pecl channel-update pecl.php.net

###########################################################################
# Install PECL and PEAR extensions
###########################################################################
RUN pecl install \
    imagick \
    redis \
    xdebug

###########################################################################
# Install and enable php extensions
###########################################################################
RUN docker-php-ext-enable \
    imagick \
    redis \
    xdebug

###########################################################################
# Configure
###########################################################################

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

# Install Composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/vendor/bin:/composer/vendor/bin:~/.composer/vendor/bin:/var/www/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
RUN composer --version

# Install deployer
RUN curl https://github.com/deployphp/deployer/releases/latest/download/deployer.phar -s \
    --output /usr/bin/dep
RUN chmod +x /usr/bin/dep
RUN dep --version

# Install The Dragon Code Styler
RUN curl https://github.com/TheDragonCode/codestyler/releases/latest/download/codestyle.phar -s \
    --output /usr/bin/codestyle
RUN chmod +x /usr/bin/codestyle
RUN codestyle --version

# Install Laravel Pint
RUN curl https://github.com/laravel/pint/releases/latest/download/pint.phar -s \
    --output /usr/bin/pint
RUN chmod +x /usr/bin/pint
RUN pint --version

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Show PHP version
RUN php -v

# Setup working directory
WORKDIR /var/www
