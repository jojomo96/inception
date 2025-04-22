# Makefile for Inception project

# Variables
DOCKER_COMPOSE = docker compose -f srcs/requirements/docker-compose.yml
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
			echo "MYSQL_DATABASE=wordpress_db" >> $(ENV_FILE); \
			echo "MYSQL_USER=wordpress_db_user" >> $(ENV_FILE); \
			echo "MYSQL_PASSWORD=wordpress_db_pass" >> $(ENV_FILE); \
			echo "WORDPRESS_TABLE_PREFIX=wp_" >> $(ENV_FILE); \
			echo "WORDPRESS_SITE_URL=http://localhost:8080" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_USER=hans" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_PASSWORD=hans_password" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_EMAIL=hans@example.com" >> $(ENV_FILE); \
			echo "WORDPRESS_SITE_TITLE='WordPress Site'" >> $(ENV_FILE); \
			echo "WORDPRESS_DOMAIN=localhost" >> $(ENV_FILE); \
			echo "WORDPRESS_USER=wordpress_user" >> $(ENV_FILE); \
			echo "WORDPRESS_USER_EMAIL=user@email.com" >> $(ENV_FILE); \
			echo "WORDPRESS_USER_PASSWORD=wordpress_pass" >> $(ENV_FILE); \
			echo "FTP_USER=ftp_user" >> $(ENV_FILE); \
			echo "FTP_PASSWORD=ftp_pass" >> $(ENV_FILE); \
			echo ".env file created."; \
		else \
			echo ".env file already exists."; \
		fi

.PHONY: all build up down clean re env status
