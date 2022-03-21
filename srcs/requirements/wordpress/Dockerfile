FROM debian:buster

RUN apt-get update && apt-get -y install apt-utils \
		php-fpm php-mysql mariadb-client wget

# additional usefull packets:
	# php-zip php-gd php-mbstring php-xml

RUN	mkdir -p			/run/php
COPY ./conf/www.conf	/etc/php/7.3/fpm/pool.d/www.conf
	
RUN	mkdir -p			/var/www/html/ && \
	chown -R			www-data:www-data /var/www/* && \
	chmod -R 755		/var/www/*

RUN	wget http://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x			./wp-cli.phar && \
	mv wp-cli.phar		/usr/local/bin/wp && \
	wp core download 	--path=/var/www/html/ --locale=ru_RU --allow-root

COPY ./conf/setup_wp.sh	/var/www/html/

RUN chmod +x			/var/www/html/setup_wp.sh

ENTRYPOINT	[ "bash",	"/var/www/html/setup_wp.sh" ]

CMD			[ "php-fpm7.3", "--nodaemonize" ]
