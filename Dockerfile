#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

ARG FULL_PHP_VERSION=8.0-alpine

FROM php:${FULL_PHP_VERSION}

ARG FULL_PHP_VERSION=alpine
ARG MINOR_PHP_VERSION=8.0


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
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    libzip-dev

###########################################################################
# Install PECL and PEAR extensions
###########################################################################
RUN if [ $MINOR_PHP_VERSION = "8.0" ] || [ $FULL_PHP_VERSION = "alpine" ]; then \
        pecl install \
            xdebug; \
    else \
        pecl install \
            imagick \
            xdebug \
            redis \
    ;fi

###########################################################################
# Install and enable php extensions
###########################################################################
RUN if [ $MINOR_PHP_VERSION = "8.0" ] || [ $FULL_PHP_VERSION = "alpine" ]; then \
        docker-php-ext-enable \
            xdebug; \
    else \
        docker-php-ext-enable \
            imagick \
            xdebug \
            redis \
    ;fi

RUN docker-php-ext-configure zip

RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    mbstring \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    soap \
    sockets \
    tokenizer \
    xml \
    zip

#RUN if [ $MINOR_PHP_VERSION = "8.0" ] || [ $FULL_PHP_VERSION = "alpine" ]; then \
#        docker-php-ext-install \
#            json \
#    ;fi

# Install Composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
RUN composer --version

# Install Deployer
RUN curl -LO https://deployer.org/deployer.phar
RUN mv deployer.phar /usr/local/bin/dep
RUN chmod +x /usr/local/bin/dep

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Show PHP version
RUN php -v

# Setup working directory
WORKDIR /var/www
