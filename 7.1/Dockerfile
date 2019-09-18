FROM lorisleiva/laravel-docker:7.1

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apk add --update redis autoconf \
	&& pecl install -o -f redis soap \
	&&  rm -rf /tmp/pear
