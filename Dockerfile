#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

ARG FULL_PHP_VERSION=8.2-alpine

FROM php:${FULL_PHP_VERSION}

ARG FULL_PHP_VERSION=alpine
ARG SHORT_PHP_VERSION=8.2


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
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer \
    | php -- --install-dir=/usr/local/bin/ --filename=composer --quiet \
RUN a+x /usr/local/bin/composer
RUN composer --version

# Install Composer's dependencies
RUN composer global require \
    deployer/deployer \
    dragon-code/codestyler \
    laravel/pint

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Show PHP version
RUN php -v

# Setup working directory
WORKDIR /var/www
