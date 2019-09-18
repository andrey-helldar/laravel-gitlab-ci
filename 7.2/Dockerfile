FROM lorisleiva/laravel-docker:7.2

# Start as root
USER root


###########################################################################
# PHP EXTENSIONS
###########################################################################

RUN apk add --update redis autoconf \
	&& pecl install -o -f redis \
	&& rm -rf /tmp/pear

RUN apt-get install php-soap
