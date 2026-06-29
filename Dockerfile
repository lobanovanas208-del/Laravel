FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    libpq-dev nodejs npm sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

# Устанавливаем зависимости
RUN composer install --optimize-autoloader

# Сборка фронтенда (если есть) - пропускаем, если не нужно
RUN npm install --legacy-peer-deps && npm run build || echo "Frontend build skipped"

# Права на запись
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

EXPOSE 8000

# Запуск с миграциями (выполняются при старте)
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000
