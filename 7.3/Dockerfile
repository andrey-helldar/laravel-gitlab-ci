FROM lorisleiva/laravel-docker:7.3

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apt-get update -yqq && \
    apt-get install -yqq php-redis && \
    docker-php-ext-enable redis
