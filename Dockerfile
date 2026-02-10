FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli

RUN a2enmod rewrite
WORKDIR /var/www/html
COPY . /var/www/html/

# --- FIX: Ensure the settings file exists so the installer doesn't crash ---
RUN touch /var/www/html/hesk_settings.inc.php

# Fix permissions for the installer to write the real config later
RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80
