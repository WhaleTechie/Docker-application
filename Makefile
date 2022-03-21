# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lkrinova <lkrinova@student.21-school.ru    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/09 19:21:02 by lkrinova          #+#    #+#              #
#    Updated: 2022/02/09 19:21:46 by lkrinova         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DC	=						docker-compose -f
SRC	=						srcs/docker-compose.yml

.PHONY:	all clean fclean re hosts_check stop state

all: hosts_check
	mkdir -p				~/data/dbdata
	mkdir -p				~/data/wordpress
	$(DC) $(SRC)			up --build -d

hosts_check:
	@echo "Attention: make sure that the line '127.0.0.1 lkrinova.42.fr' is present in /etc/hosts\n"

clean:
	$(DC) $(SRC)			down --remove-orphans

fclean: clean
	-docker rmi -f			$$(docker images -qa) 2>/dev/null
	-docker volume rm		$$(docker volume ls -q) 2>/dev/null
	-docker system prune	-a --volumes
	-docker network prune
	-sudo chown -R			lkrinova:lkrinova ~/data/*
	-sudo rm -rf			~/data/*

re: fclean
	mkdir -p				~/data/dbdata
	mkdir -p				~/data/wordpress
	$(DC) $(SRC)			up --build

stop:
	docker stop $$(docker ps -qa) 2>/dev/null

state:
	@echo "List of containers:"	&& $(DC) $(SRC) ps
	@echo "\nList of images:"	&& docker images
	@echo "\nList of volumes:"	&& docker volume ls
	@echo "\nNetwork list:"		&& docker network ls

# pre_testme:
# docker stop $(docker ps -qa);
# docker rm $(docker ps -qa);
# docker rmi -f $(docker images -qa);
# docker volume rm $(docker volume ls -q);
# docker network rm $(docker network ls -q) 2>/dev/null
