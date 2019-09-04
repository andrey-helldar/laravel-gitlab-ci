FROM lorisleiva/laravel-docker:latest

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apt-get update -yqq && \
    apt-get install -yqq php-redis && \
    docker-php-ext-enable redis
