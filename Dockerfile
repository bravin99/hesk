# Use PHP 8.3 with Apache for modern performance and compatibility
FROM php:8.3-apache

# Install system dependencies for GD (required by Hesk for anti-spam images)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli

# Enable Apache mod_rewrite for Hesk "Security" and "SEO" features
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy your local Hesk files into the container
COPY . /var/www/html/

# Fix permissions: Hesk needs these folders to be writable by the web server (www-data)
RUN chown -R www-data:www-data /var/www/html/attachments /var/www/html/cache /var/www/html/inc

# Expose port 80
EXPOSE 80

# The base image already includes the CMD to start Apache
