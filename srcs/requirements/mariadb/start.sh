#!/bin/sh
mysqld &
sleep 5

CHECK=`echo "show schemas;" | mariadb | grep 'wordpress' | wc -l`
echo check is $CHECK
if [ $CHECK == 0 ]
then
  echo "CREATE USER '${MARIADB_USER}'@'${MARIADB_HOST}' IDENTIFIED BY '${MARIADB_PASSWORD}';" | mariadb
  echo "CREATE DATABASE ${MARIADB_DATABASE};" | mariadb
  echo "USE ${MARIADB_DATABASE};" | mariadb
  echo "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'${MARIADB_HOST}' WITH GRANT OPTION;" | mariadb
  echo "FLUSH PRIVILEGES;" | mariadb
fi
pkill mariadb
pkill mysqld
exec mysqld && mariadb

