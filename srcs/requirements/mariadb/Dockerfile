# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lyie <marvin@42.fr>                        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/22 11:57:25 by lyie              #+#    #+#              #
#    Updated: 2021/06/10 19:26:27 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13
MAINTAINER Laura Yie <lyie@42.student.fr>
RUN apk update \
	&& apk add mariadb \
	mariadb-client 

RUN mkdir -p /var/run/mysqld \ 
	&& mkdir -p /var/lib/mysql \
	&& mkdir -p /var/log/mysql \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chown -R mysql:mysql /var/log/mysql

RUN mariadb-install-db --user=mysql --datadir='/var/lib/mysql'

#crucial to include this file else will get database connection error
COPY mariadb-server.cnf /etc/my.cnf.d/
RUN chown -R mysql:mysql /etc/mysql
COPY start.sh .
RUN chmod +x start.sh
RUN mkdir /data
RUN chown -R mysql:mysql /data
USER mysql:mysql
ENTRYPOINT ["sh", "start.sh"]
