NAME        = inception
SRCS_DIR    = ./srcs
COMPOSE     = docker compose -f $(SRCS_DIR)/docker-compose.yml

DATA_PATH   = /home/$(USER)/data
DB_DATA     = $(DATA_PATH)/mariadb
WP_DATA     = $(DATA_PATH)/wordpress

.PHONY: prepare  down start stop restart logs ps


all: prepare up

prepare:
	@mkdir -p $(DB_DATA)
	@mkdir -p $(WP_DATA)


build: prepare
	$(COMPOSE) build

up: prepare
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean: down
	@echo "Stopping containers and removing networks..."

fclean: down
	@echo "Performing deep cleanup..."
	@docker system prune -a --volumes -f
	@sudo rm -rf $(DATA_PATH)

re: fclean all
