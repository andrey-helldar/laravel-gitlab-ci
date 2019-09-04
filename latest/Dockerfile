FROM lorisleiva/laravel-docker:latest

# Start as root
USER root


###########################################################################
# PHP REDIS EXTENSION
###########################################################################

RUN apk add --update php-redis && 
    docker-php-ext-enable redis
