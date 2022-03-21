FROM debian:buster

RUN apt-get update && apt-get -y install apt-utils \
		nginx \
		openssl && \
	openssl req -x509 -nodes \
		-days 365 \
		-subj	"/C=RU/ST=Moscow/L=Moscow/O=42school/OU=21schoolMoscow/CN=lkrinova.42.fr" \
		-newkey	rsa:2048 \
		-keyout	/etc/nginx/nginx.key \
		-out	/etc/nginx/nginx.crt && \
	chmod 600 /etc/nginx/nginx.key /etc/nginx/nginx.crt && \
	echo "daemon off;" >> /etc/nginx/nginx.conf

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

CMD ["nginx"]
