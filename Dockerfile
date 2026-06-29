FROM php:8.2-fpm

# Установка системных зависимостей (включая Node.js)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    nodejs \
    npm

# Установка расширений PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_sqlite

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Копируем все файлы проекта
COPY . .

# Устанавливаем Node-зависимости и собираем фронтенд
RUN npm install && npm run build

# Создаём файл SQLite
RUN touch database/database.sqlite

# Устанавливаем переменные окружения для Laravel
ENV DB_CONNECTION=sqlite
ENV APP_ENV=production
ENV APP_DEBUG=false

# Устанавливаем зависимости Composer
RUN composer install --no-dev --optimize-autoloader

# Выполняем миграции (если они есть)
RUN php artisan migrate --force --verbose

# Кэшируем конфиги (пока закомментируем для отладки)
# RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Права на запись для всех нужных папок
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000
