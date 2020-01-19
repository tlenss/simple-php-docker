cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

export USER=$(shell id -u)
export GROUP=$(shell id -g)

up:
	docker-compose \
	-f docker-compose.yml \
	-f .build/docker-compose.build.yml \
	-f .build/docker-compose.dev.yml \
	up -d

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
