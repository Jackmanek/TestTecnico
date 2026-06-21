#!/bin/sh

echo "Esperando a MySQL..."

until nc -z db 3306
do
    sleep 2
done

echo "MySQL disponible"

composer install

if [ -z "$(php artisan key:generate --show 2>/dev/null)" ]; then
    php artisan key:generate
fi


php artisan migrate:refresh --force

php artisan test
php artisan db:seed --force


php artisan storage:link
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

php-fpm
