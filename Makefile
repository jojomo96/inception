# Makefile for Inception project

# Variables
DOCKER_COMPOSE = docker-compose -f srcs/requirements/docker-compose.yml
ENV_FILE = srcs/.env

# Targets
all: build up

build:
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean: down
	$(DOCKER_COMPOSE) rm -f
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

re: clean all

status:
	$(DOCKER_COMPOSE) ps

env:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "MYSQL_ROOT_PASSWORD=example" > $(ENV_FILE); \
		echo "MYSQL_DATABASE=my_database" >> $(ENV_FILE); \
		echo "MYSQL_USER=my_user" >> $(ENV_FILE); \
		echo "MYSQL_PASSWORD=my_password" >> $(ENV_FILE); \
		echo ".env file created."; \
	else \
		echo ".env file already exists."; \
	fi

.PHONY: all build up down clean re env status