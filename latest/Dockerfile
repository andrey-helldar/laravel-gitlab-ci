FROM lorisleiva/laravel-docker:latest

# Start as root
USER root


###########################################################################
# NODE JS
###########################################################################

# Add repos
RUN apk add curl \
    && curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    
# Install packages
RUN apk add nodejs yarn



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
