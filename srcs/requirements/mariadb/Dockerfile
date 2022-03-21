FROM debian:buster

RUN apt-get update && apt-get -y install apt-utils \
		default-mysql-server

COPY ./conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/debian.cnf		/etc/mysql/
COPY ./conf/setup_db.sh		./

RUN chmod +x				./setup_db.sh

ENTRYPOINT ["bash",			"./setup_db.sh"]

CMD ["mysqld_safe"]
# listen always all requests

# The mysqld program is the core of the MySQL database. 
# It runs as a daemon in the system and accepts connections from client programs, 
# executing queries and returning results.
# It is multithreaded, that is, it will process more than one request at a time.
