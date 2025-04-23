# Makefile for Inception project

# Variables
DOCKER_COMPOSE = sudo docker compose -f srcs/docker-compose.yml
ENV_FILE = srcs/.env
DATA_DIR = /home/jmoritz/data

# Targets
all: create-data-dir build up

create-data-dir:
	mkdir -p $(DATA_DIR)
	mkdir -p $(DATA_DIR)/wordpress
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/adminer
	mkdir -p $(DATA_DIR)/redis

build:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Error: $(ENV_FILE) not found. Please run 'make env' first."; \
		exit 1; \
	fi
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean: down
	$(DOCKER_COMPOSE) rm -f
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	rm -rf $(DATA_DIR)

re: clean all

status:
	$(DOCKER_COMPOSE) ps

clean-env:
	rm -f $(ENV_FILE)

env:
	@if [ ! -f $(ENV_FILE) ]; then \
			echo "MYSQL_ROOT_PASSWORD=REPLACE_ME" > $(ENV_FILE); \
			echo "MYSQL_DATABASE=wordpress_db" >> $(ENV_FILE); \
			echo "MYSQL_USER=wordpress_db_user" >> $(ENV_FILE); \
			echo "MYSQL_PASSWORD=REPLACE_ME" >> $(ENV_FILE); \
			echo "WORDPRESS_TABLE_PREFIX=wp_" >> $(ENV_FILE); \
			echo "WORDPRESS_SITE_URL=https://jmoritz.42.fr" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_USER=hans" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_PASSWORD=REPLACE_ME" >> $(ENV_FILE); \
			echo "WORDPRESS_ADMIN_EMAIL=hans@example.com" >> $(ENV_FILE); \
			echo "WORDPRESS_SITE_TITLE='WordPress Site'" >> $(ENV_FILE); \
			echo "WORDPRESS_DOMAIN=jmoritz.42.fr" >> $(ENV_FILE); \
			echo "WORDPRESS_USER=wordpress_user" >> $(ENV_FILE); \
			echo "WORDPRESS_USER_EMAIL=user@email.com" >> $(ENV_FILE); \
			echo "WORDPRESS_USER_PASSWORD=REPLACE_ME" >> $(ENV_FILE); \
			echo "FTP_USER=ftp_user" >> $(ENV_FILE); \
			echo "FTP_PASSWORD=REPLACE_ME" >> $(ENV_FILE); \
			echo ".env file created."; \
		else \
			echo ".env file already exists."; \
		fi

.PHONY: all build up down clean re env status create-data-dir clean-env
