FROM php:8.2.13-fpm

RUN apt update && apt install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev \
    libicu-dev

RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip intl

# Configure PHP-FPM to listen on port 9000
RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /usr/local/etc/php-fpm.d/www.conf

COPY joyous_internship_front /var/www/html/joyous_internship_front

WORKDIR /var/www/html/joyous_internship_front

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN composer install --no-scripts --no-interaction --prefer-dist

## Set permissions for Laravel
#RUN chmod -R 777 bootstrap
#RUN chown -R www-data:www-data storage
#RUN chown -R www-data:www-data bootstrap

CMD ["php-fpm"]
