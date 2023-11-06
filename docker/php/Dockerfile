FROM php:8.1-fpm-buster
ARG TIMEZONE

RUN apt-get update && apt-get install -y \
    gnupg \
    g++ \
    procps \
    openssl \
    git \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev  \
    libonig-dev \
    libxslt1-dev \
    acl \
    mariadb-client \
    && echo 'alias sf="php bin/console"' >> ~/.bashrc

RUN docker-php-ext-configure gd --with-jpeg --with-freetype

RUN docker-php-ext-install \
    pdo pdo_mysql zip xsl gd intl opcache exif mbstring

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
    && printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
    && "date"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install -o -f redis && rm -rf /tmp/pear && docker-php-ext-enable redis

WORKDIR /var/www/symfony

COPY ../../ /var/www/symfony

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm"]

#CMD bash -c "cd /var/www/symfony && composer install"
#
#CMD bash -c "cd /var/www/symfony && php bin/console doctrine:database:drop --if-exists --force"
#CMD bash -c "cd /var/www/symfony && php bin/console doctrine:database:create"
#CMD bash -c "cd /var/www/symfony && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate"

#CMD bash -c "cd /var/www/symfony && composer install; doctrine:migrations:migrate ;  php-fpm"

#ARG APP_ENV=prod
#ENV APP_ENV=${APP_ENV}

#CMD bash -c "rm -rf /var/www/symfony/migrate.sh && echo 'cd /var/www/symfony && php bin/console doctrine:database:drop --if-exists --force && cd /var/www/symfony && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate' >> /var/www/symfony/migrate.sh && chmod +x /var/www/symfony/migrate.sh"

#CMD bash -c "cd /var/www/symfony && composer install && /var/www/symfony/migrate.sh"

#CMD bash -c "/var/www/symfony/migrate.sh"



#CMD bash -c  "sleep 30 && cd /var/www/symfony && php bin/console doctrine:database:drop --force && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate"

#CMD bash -c  "cd /var/www/symfony && php bin/console doctrine:database:drop --force"
#
#CMD bash -c "cd /var/www/symfony && php bin/console doctrine:database:create"
#
#CMD bash -c "cd /var/www/symfony && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate"

#ENTRYPOINT "sleep 30 && cd /var/www/symfony && php bin/console doctrine:database:drop --force && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate"
#ENTRYPOINT ["cd /var/www/symfony && php bin/console doctrine:database:drop --force && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate"]
#cd /var/www/symfony php bin/console doctrine:database:drop --force
#CMD bash -c "rm -rf /var/www/symfony/migrate.sh && echo 'cd /var/www/symfony && php bin/console doctrine:database:drop --force && cd /var/www/symfony && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate' >> /var/www/symfony/migrate.sh && chmod +x /var/www/symfony/migrate.sh"

#rm -rf /var/www/symfony/migrate.sh && echo 'cd /var/www/symfony php bin/console doctrine:database:drop --force && cd /var/www/symfony && php bin/console doctrine:database:create && php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate' >> /var/www/symfony/migrate.sh && chmod +x /var/www/symfony/migrate.sh

#ENTRYPOINT ["/bin/bash /var/www/symfony/migrate.sh"]