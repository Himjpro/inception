name = inception

all:
	@printf "Launch configuration ${name}...\n"
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@sudo docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@sudo docker system prune -a

fclean: clean
	@printf "Total clean of all configurations docker\n"
	@sudo docker system prune --all --force --volumes
	@sudo docker network prune --force
	@sudo docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
