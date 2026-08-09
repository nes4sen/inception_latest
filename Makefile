# Name / Paths
NAME        = inception
SRCS_DIR    = ./srcs
COMPOSE     = docker compose -f $(SRCS_DIR)/docker-compose.yml

# Host data storage paths
DATA_PATH   = /home/$(USER)/data
DB_DATA     = $(DATA_PATH)/mariadb
WP_DATA     = $(DATA_PATH)/wordpress

.PHONY: all prepare build up down start stop restart clean fclean re logs ps

# Default rule: Prepare host directories and start the infrastructure
all: prepare up

# Create local data directories on host machine if they don't exist
prepare:
	@mkdir -p $(DB_DATA)
	@mkdir -p $(WP_DATA)

# Build or rebuild images defined in docker-compose.yml
build: prepare
	$(COMPOSE) build

# Create and start all containers in detached mode
up: prepare
	$(COMPOSE) up -d --build

# Stop and remove containers and networks created by 'up'
down:
	$(COMPOSE) down

# Start existing containers
start:
	$(COMPOSE) start

# Stop running containers without removing them
stop:
	$(COMPOSE) stop

# Restart all containers
restart:
	$(COMPOSE) restart

# View logs of running containers
logs:
	$(COMPOSE) logs -f

# List running containers
ps:
	$(COMPOSE) ps

# Stop containers and remove volumes created by Docker
clean: down
	@echo "Stopping containers and removing networks..."

# Full cleanup: Stop containers, remove volumes, images, and local data directories
fclean: down
	@echo "Performing deep cleanup..."
	@docker system prune -a --volumes -f
	@sudo rm -rf $(DATA_PATH)

# Rebuild everything from scratch
re: fclean all
