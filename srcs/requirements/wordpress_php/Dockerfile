# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lyie <marvin@42.fr>                        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/22 11:57:25 by lyie              #+#    #+#              #
#    Updated: 2021/06/09 18:37:15 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13
MAINTAINER Laura Yie <lyie@42.student.fr>

RUN mkdir -p run/php

#downlod all required files
RUN apk update \
	&& apk add sudo \
	mariadb-client \
	curl \
	php7 php7-fpm php7-phar php7-mysqli php7-common php7-curl php7-cli php7-json php7-session php7-mbstring 


RUN adduser -S nginx && addgroup -S nginx

#install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	cp wp-cli.phar /usr/bin/wp
WORKDIR /var/www/wordpress
#COPY SOURCE FILES
COPY start.sh .
COPY wp-config.php .

#add crucial php conf file which allows configured to allow connections from Nginx container
COPY www.conf /etc/php7/php-fpm.d/www.conf
RUN wp core download
RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]
