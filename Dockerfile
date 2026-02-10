FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) gd mysqli

# Enable Apache rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application code ONLY (no config)
COPY . /var/www/html/

# Permissions for runtime-mounted files
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

