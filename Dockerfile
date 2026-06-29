FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    libpq-dev nodejs npm sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

# Устанавливаем зависимости (без --no-dev)
RUN composer install --optimize-autoloader

# Генерация Ziggy (если есть)
RUN php artisan ziggy:generate || echo "Ziggy generation skipped"

# Сборка фронтенда (если есть)
RUN npm install && npm run build || echo "Frontend build skipped"

# Права на запись
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public/build /var/www/html/database
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public/build /var/www/html/database

EXPOSE 8000

# Запуск сервера (без миграций)
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000
