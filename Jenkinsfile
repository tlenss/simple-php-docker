# pipeline
source .env

# make build-production
docker build --target nginx-${APP_ENV} -t lenssnl/test-app-nginx -t lenssnl/test-app-www:${APP_VERSION} .build/docker/images/nginx-php
docker build --target fpm-${PHP_VERSION}-${APP_ENV} -t lenssnl/test-app-php -t lenssnl/test-app-fpm:${APP_VERSION} .build/docker/images/php-fpm

# push images to registry
docker-compose push

# make deploy-production
docker stack deploy --compose-file docker-compose.yml test-app