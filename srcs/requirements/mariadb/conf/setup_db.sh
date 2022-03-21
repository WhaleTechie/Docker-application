#!/usr/bin/bash

if [ ! -d /var/lib/mysql/main_database ]
then
	echo "-> first launch of DB: setup"
	service mysql start
	sleep 10
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME_DB"
	mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PWD'"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_NAME_DB.* TO '$MYSQL_USER'@'%'"
	mysql -u root -e "FLUSH PRIVILEGES"
	mysqladmin -u root password $MYSQL_ROOT_NEWPWD
	service mysql status
	service mysql stop
fi

exec "$@"
