# load config from .env file
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# set USER/GROUP for docker generated data
export USER=$(shell id -u)
export GROUP=$(shell id -g)

# composer settings
export COMPOSER_CACHE_DIR=/home/t/.composer/cache

# set image tag
export PHP_IMAGE_TAG=${PHP_VERSION}
ifeq (${APP_ENV},dev)
        PHP_IMAGE_TAG="${PHP_VERSION}-dev"
endif

up:
	docker-compose \
	-f docker-compose.yml \
	-f .build/docker-compose.build.yml \
	-f .build/docker-compose.dev.yml \
	up --build -d

build-images:
	docker-compose \
	-f docker-compose.yml \
	-f .build/docker-compose.build.yml \
	build --force-rm --no-cache

composer-install:
	docker-compose \
	-f docker-compose.yml \
	-f .build/docker-compose.build.yml \
	-f .build/docker-compose.dev.yml \
	-f .build/docker-compose.tools.yml \
	run --rm composer-install

phpunit:
	docker-compose \
	-f docker-compose.yml \
	-f .build/docker-compose.build.yml \
	-f .build/docker-compose.dev.yml \
	-f .build/docker-compose.tools.yml \
	run --rm phpunit

deploy:
	docker stack deploy -c docker-compose.yml
