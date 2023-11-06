#!/bin/bash

cd /var/www/symfony || exit

composer install

php bin/console doctrine:database:drop --if-exists --force

php bin/console doctrine:database:create

php bin/console --no-interaction --allow-no-migration doctrine:migrations:migrate
