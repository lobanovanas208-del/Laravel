FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    libpq-dev nodejs npm sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

# Установка зависимостей (включая dev-пакеты, чтобы не было ошибок)
RUN composer install --optimize-autoloader

# Генерация Ziggy (если нужно)
RUN php artisan ziggy:generate || true

# Сборка фронтенда (если есть)
RUN npm install && npm run build || true

# Права на запись для storage и database
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build

# Создаём пустой файл базы, если его нет
RUN touch /var/www/html/database/database.sqlite

EXPOSE 8000

# Запуск сервера БЕЗ миграций
CMD php artisan serve --host=0.0.0.0 --port=8000
