cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

export USER=$(shell id -u)
export GROUP=$(shell id -g)

setup: cp .env.dist .env

build:
	docker-compose -f docker-compose.yml -f .build/docker-compose.dev.yml build --force-rm --no-cache

start:
	docker-compose -f docker-compose.yml -f .build/docker-compose.dev.yml up -d

stop:
	docker-compose -f docker-compose.yml -f .build/docker-compose.dev.yml down

logs:
	docker-compose -f docker-compose.yml -f .build/docker-compose.dev.yml logs -f

composer-install:
	docker run -ti --rm \
	--user $(USER):$(GROUP) \
	--volume $SSH_AUTH_SOCK:/ssh-auth.sock \
	--env SSH_AUTH_SOCK=/ssh-auth.sock \
	--env COMPOSER_HOME \
	--env COMPOSER_CACHE_DIR \
	--volume ${PWD}:/app \
	--volume ${COMPOSER_HOME:-$HOME/.config/composer}:$COMPOSER_HOME \
	--volume ${COMPOSER_CACHE_DIR:-$HOME/.cache/composer}:$COMPOSER_CACHE_DIR \
	composer:latest \
	install