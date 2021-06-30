#!/bin/sh

sleep 10
CHECK=`echo "use wordpress;show tables;" | mariadb -h${MARIADB_HOST} -D${MARIADB_DATABASE} -u${MARIADB_USER} -p${MARIADB_PASSWORD} -P${MARIADB_PORT} | wc -l` 
echo check is $CHECK !

#check if wp already loaded in db and set up if not
if [ $CHECK == 0 ]; then
	wp core install --url="$WP_SITE" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_EMAIL" --skip-email
	wp theme activate twentytwenty
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass="$WP_USER_PASSWORD"
	wp post create --post_title="HEY GUYS!" --post_content="I AM ON THE INTERNET!" --post_status=publish --post_author=2
fi

#permissions for nginx
cd ../../../.. && sudo chown -R nginx:nginx /var/www/ && chown nginx:nginx /var/www/wordpress && chmod 755 /var/www/wordpress 

#php
exec php-fpm7 -F
