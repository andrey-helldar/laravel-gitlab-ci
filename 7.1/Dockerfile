FROM lorisleiva/laravel-docker:7.1

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apt-get update -yqq && \
    apt-get install -yqq php-redis && \
    docker-php-ext-enable redis
