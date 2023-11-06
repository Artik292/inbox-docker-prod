#!/bin/bash

# Переходим в каталог проекта
cd /var/www/symfony || exit

# Установка зависимостей через Composer
composer install

# Удаление базы данных, если она существует
php bin/console doctrine:database:drop --if-exists --force

# Создание базы данных
php bin/console doctrine:database:create

# Выполнение миграций
php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate

# Следующая команда (или команды), которые должны быть выполнены
# ...

exec "$@"
