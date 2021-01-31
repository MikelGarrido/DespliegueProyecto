FROM php:8.0-fpm

COPY composer.lock composer.json /var/www/

COPY database /var/www/database

WORKDIR /var/www

RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY . /var/www

RUN chown -R www-data:www-data \
    /var/www/storage \
    /var/www/bootstrap/cache

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN php artisan cache:clear


RUN php artisan optimize


RUN apt-get install -y libmcrypt-dev


RUN php artisan optimize

#CMD ["php artisan migrate:fresh"]

#RUN php artisan schedule:work
