FROM composer:1.10.13

# Install PHP extensions
RUN apk update && apk add --no-cache \
    ca-certificates \
    git \
    htop \
    wget \
    dos2unix \
    curl \
    sudo \
    libmcrypt-dev \
    libxml2-dev \
    libzip-dev \
    libpng-dev \
    imagemagick \
    graphicsmagick \
    libwebp-dev \
    libxpm-dev \
    unzip \
    nano \
    zip \
    && rm -rf /var/cache/apk/*

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap && \
    docker-php-ext-enable imap 

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/lib --with-png-dir=/usr/lib --with-jpeg-dir=/usr/lib \
    && docker-php-ext-install  gd \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install intl mbstring mysqli curl pdo_mysql zip opcache bcmath gd \
    && docker-php-ext-enable intl mbstring mysqli curl pdo_mysql zip opcache bcmath gd