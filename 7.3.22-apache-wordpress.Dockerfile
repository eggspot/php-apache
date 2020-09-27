FROM php:7.3.22-apache

# Install Extensions
RUN apt-get update \
    && apt-get install -y \
    libpcre3-dev \
    zlib1g-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \    
    git \
    zip \
    unzip \
    rsync \
    default-mysql-client \
    && apt-get -y autoremove \
    && apt-get -y clean

RUN docker-php-ext-install mysqli pdo_mysql gd imagick mcrypt exif zip bz2

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "copy('https://composer.github.io/installer.sig', 'composer-setup.sig');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('composer-setup.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.10.13
RUN php -r "unlink('composer-setup.php');"
RUN php -r "unlink('composer-setup.sig');"