FROM php:8.2-fpm

ENV APP_URL=https://laravel-site-natf.onrender.com
ENV ASSET_URL=https://laravel-site-natf.onrender.com

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    libpq-dev nodejs npm sqlite3 libsqlite3-dev

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --optimize-autoloader

# Создаём файл Home.vue, если его нет
RUN mkdir -p resources/js/Pages && \
    if [ ! -f resources/js/Pages/Home.vue ]; then \
        echo '<template><div><h1>Добро пожаловать!</h1><p>Сайт работает</p></div></template>' > resources/js/Pages/Home.vue; \
    fi

RUN php artisan ziggy:generate || true

RUN npm install && npm run build || true

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database /var/www/html/public/build

RUN touch /var/www/html/database/database.sqlite

EXPOSE 8000

CMD php artisan migrate --force || true && php artisan serve --host=0.0.0.0 --port=8000
