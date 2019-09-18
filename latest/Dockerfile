FROM lorisleiva/laravel-docker:latest

# Start as root
USER root


###########################################################################
# PHP EXTENSIONS
###########################################################################

RUN apk add --update redis autoconf \
	&& pecl install -o -f redis \
	&&  rm -rf /tmp/pear


# php-soap extension
RUN apk add --update php-soap

RUN docker-php-ext-install \
    soap
