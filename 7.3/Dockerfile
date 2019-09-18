FROM lorisleiva/laravel-docker:7.3

# Start as root
USER root


###########################################################################
# PHP EXTENSIONS
###########################################################################

RUN apk add libxml2-dev

RUN apk add --update redis autoconf \
	&& pecl install -o -f redis \
	&& rm -rf /tmp/pear


# php-soap extension
RUN apk add --update php-soap

RUN docker-php-ext-install \
    soap
