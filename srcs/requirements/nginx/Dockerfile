# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/20 11:34:27 by user42            #+#    #+#              #
#    Updated: 2021/06/09 14:43:10 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13
MAINTAINER Laura Yie <lyie@42.student.fr>

ENV WP_ROOT="/var/www/wordpress"

RUN apk update \ 
	&& apk add openssl \
	&& apk add nginx

RUN chown -R nginx:nginx /var/www \ 
	&& chmod 755 /var/www \
	&& chown -R nginx:nginx /etc/nginx \
	&& mkdir /etc/nginx/ssl \
	&& mkdir -p run/nginx/ \
	&& chown -R nginx:nginx run/nginx

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.crt -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=IleDeFrance/L=Paris/O=42/OU=Student/CN=127.0.0.1"

COPY nginx.conf ./etc/nginx/conf.d/default.conf
EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
