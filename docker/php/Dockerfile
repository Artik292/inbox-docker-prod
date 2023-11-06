# Использование debian:slim как базового образа
FROM debian:bullseye-slim

# Аргумент для установки временной зоны
ARG TIMEZONE

RUN apt-get update && apt-get install -y libredis-perl

# Установка необходимых зависимостей
RUN apt-get update && apt-get install -y \
        autoconf \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkg-config \
        re2c \
        curl \
        libxml2-dev \
        libsqlite3-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libzip-dev \
        libicu-dev \
        git \
        unzip \
        procps \
        openssl \
        zlib1g-dev \
        libxslt1-dev \
        mariadb-client \
        libcurl4-openssl-dev \
        libssl-dev \
        php-pear \
        php-dev

RUN apt-get update && apt-get install -y libmysqlclient-dev

# Скачивание и установка PHP
ENV PHP_VERSION 8.1.0
RUN curl -SL "https://www.php.net/distributions/php-${PHP_VERSION}.tar.xz" -o php.tar.xz \
    && mkdir -p /usr/src/php \
    && tar -Jxf php.tar.xz -C /usr/src/php --strip-components=1 \
    && cd /usr/src/php \
    && ./buildconf --force \
    && ./configure --with-config-file-path=/usr/local/etc/php \
        --with-config-file-scan-dir=/usr/local/etc/php/conf.d \
        --enable-fpm \
        --with-openssl \
        --with-curl \
        --with-pdo-mysql \
    && make -j "$(nproc)" \
    && make install \
    && make clean

RUN pecl install redis && mkdir /usr/local/etc/php && echo "extension=redis.so" > /usr/local/etc/php/php.ini # docker-php-ext-enable redis

# Копирование конфигурации PHP-FPM по умолчанию
COPY ./php-fpm.conf /usr/local/etc/

CMD ["php-fpm"]

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Установка временной зоны
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Копирование исходного кода приложения
WORKDIR /var/www/symfony
COPY ../../ /var/www/symfony

# Копирование и настройка точки входа
COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Очистка и минимизация размера образа
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
