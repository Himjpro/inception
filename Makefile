name = inception

all: build up

up:
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build

build-no-cache:
	@printf "Building configuration ${name}...\n"
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build --no-cache

down:
	@printf "Stopping configuration ${name}...\n"
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

re: down all

clean: down
	@sudo docker system prune -a

fclean: clean
	@sudo docker system prune --all --force --volumes
	@sudo docker network prune --force
	@sudo docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all down re clean fclean
