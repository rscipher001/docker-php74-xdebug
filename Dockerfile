# Base PHP image, php:7.4 or php:7.4-fpm can also be used
FROM php:7.4-cli

# Working directory, this location will be required with xdebug for debuggin
WORKDIR /var/www

# Copy composer from the composer docker image
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    unzip && \
    pecl install xdebug-3.1.5 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql xdebug

# Configure Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/

# Copies the current code to the container
COPY . .

# Fix permissions for Laravel project
RUN chown -R 1000:1000 /var/www && \
    chmod -R 775 /var/www/storage

# Only required for `php artisan tinker` in Laravel
# Create a home directory for user 1000
RUN mkdir -p /home/app && chown 1000:1000 /home/app
ENV HOME=/home/app

# Required in Linux. Without it a lot of things will be owned by root
# and cause permission denied issues
# Should match the output of `echo $UID:$GID` 
USER 1000:1000

# Port on which the app will run
# Feel free to change it.
EXPOSE 8002

# Which command should run when project starts.
CMD ["bash", "./docker-entrypoint.sh"]
