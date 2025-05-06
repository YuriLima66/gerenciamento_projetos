FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql pdo mysqli

RUN a2enmod rewrite

RUN chown -R www-data:www-data /var/www/html