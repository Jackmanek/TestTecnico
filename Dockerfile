FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    netcat-openbsd \
    && docker-php-ext-install pdo pdo_mysql
RUN apt-get update && \
    apt-get install -y nodejs npm
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

ARG REPO_URL
RUN git clone $REPO_URL /var/www/html

WORKDIR /var/www/html

COPY .env /var/www/html/.env

RUN composer install --no-interaction --no-dev --optimize-autoloader

RUN npm install
RUN npm run build

RUN chown -R www-data:www-data /var/www/html/ /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/ /var/www/html/bootstrap/cache

RUN php artisan key:generate

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
