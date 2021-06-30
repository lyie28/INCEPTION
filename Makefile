# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/19 17:35:01 by user42            #+#    #+#              #
#    Updated: 2021/06/11 12:19:31 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: start stop

reboot:
	make stop && make stop_vols && sudo mkdir -p ~/data/wp_volume && sudo mkdir -p ~/data/db_volume && make start
start:
	cd srcs && sudo docker-compose up -d && cd ..

stop:
	cd srcs && sudo docker-compose stop && cd ..

stop_vols:
	cd srcs && sudo docker-compose down & cd ..
	sudo docker system prune --volumes --all --force
	sudo rm -rf ~/data
