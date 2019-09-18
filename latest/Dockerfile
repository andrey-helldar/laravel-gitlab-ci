FROM lorisleiva/laravel-docker:latest

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apk add --update redis autoconf \
	&& pecl install -o -f redis soap \
	&&  rm -rf /tmp/pear
