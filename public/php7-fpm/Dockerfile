FROM php:7.4-fpm

ARG ssh_prv_key
ARG ssh_pub_key

RUN mkdir -p /usr/share/man/man1
# Install the PHP extensions we need
RUN apt-get update -y --fix-missing && apt-get install -y \
    apt-utils \
    libxml2-dev \
    libxpm-dev \
    libpq-dev \
    libgmp-dev \
    libicu-dev \
    libaspell-dev \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libtidy-dev \
    libxslt-dev \
    libssh2-1-dev \
    libmcrypt-dev \
    libpspell-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libjpeg-dev \
    libpng-dev \
    libldap2-dev \
    libjsoncpp-dev \
    libyaml-dev \
    libzip-dev \
    zip \
    dialog \
    acl \
    ant \
    cron \
    curl \
    git \
    nano \
    ssh \
    unzip \
    vim \
    wget \
    zip

# Create Docker User
RUN apt-get install sudo
RUN useradd docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo
RUN echo "docker  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "%docker  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Authorize SSH Host
RUN mkdir -p /home/docker/.ssh && \
    chmod 0700 /home/docker/.ssh && \
    ssh-keyscan github.com > /home/docker/.ssh/known_hosts && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/docker/.ssh/config && \
    chmod 600 /home/docker/.ssh/config

# Add the keys and set permissions
ADD id_rsa.pub/ /home/docker/.ssh/id_rsa.pub
ADD id_rsa/ /home/docker/.ssh/id_rsa
RUN chmod 600 /home/docker/.ssh/id_rsa && \
    chmod 600 /home/docker/.ssh/id_rsa.pub

RUN chown -R docker:docker /home/docker

RUN pecl install ssh2 xdebug-2.9.5

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql && \
    docker-php-ext-install mysqli && \
    docker-php-ext-configure soap --enable-soap &&\
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    #GD must be first because of bug with jpeg
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install zip && \
    docker-php-ext-install xml && \
    docker-php-ext-install soap && \
    docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install 'git-friendly' commands
RUN curl -sS https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh | bash

# Install Open SSH Server
RUN apt-get install -y openssh-server

# Create Dir for PhpStorm
RUN mkdir -p /opt/.phpstorm_helpers && \
    chown docker:docker /opt/.phpstorm_helpers

# Add github oauth token to composer for private repositories
ARG github_oauth
RUN mkdir -p /home/docker/.composer && \
    chown docker:docker /home/docker/.composer && \
    echo "{\"github-oauth\": {\"github.com\": \"$github_oauth\"}}" > /home/docker/.composer/auth.json
