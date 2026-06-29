FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

# ОТЛАДКА: покажем содержимое корня
RUN ls -la

# Попробуем установить с подробным выводом
RUN composer install --no-dev --optimize-autoloader --verbose

# Если дойдёт до миграций — позже
# RUN php artisan migrate --force --verbose

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000
