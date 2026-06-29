FROM php:8.2-fpm

# Устанавливаем зависимости системы
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev

# Устанавливаем PHP-расширения
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Копируем все файлы проекта
COPY . .

# Создаём файл базы данных SQLite, если его нет
RUN touch database/database.sqlite

# Явно устанавливаем переменные окружения для Laravel
ENV DB_CONNECTION=sqlite
ENV APP_ENV=production
ENV APP_DEBUG=false

# Устанавливаем зависимости Composer
RUN composer install --no-dev --optimize-autoloader

# Очищаем старый кэш конфигурации (на случай, если он остался от предыдущих билдов)
RUN php artisan config:clear

# Выполняем миграции с выводом подробных ошибок
RUN php artisan migrate --force --verbose

# Кэшируем конфигурацию (можно закомментировать, если мешает)
# RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Даём права на запись для storage, bootstrap/cache и database
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000
