#!/bin/bash

composer install --no-interaction -d ./www
composer install --no-interaction -d ./yii-advanced
composer dump-autoload -d ./www
composer dump-autoload -d ./yii-advanced
#php ./yii-advanced migrate --interactive=0
