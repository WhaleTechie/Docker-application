#!/usr/bin/bash

# alternate version
	# wp core is-installed --allow-root
	# echo "Is wp core installed: $?"
	# if ! wp core is-installed --allow-root; then
# end of alternate version

sleep 20
if [ ! -f /var/www/html/wp-config.php ]; then
	cd var/www/html/
	echo "Setting up the Wordpress in this directory: $PWD"
	echo "-> Creating wp-config.php"
	wp core config --allow-root \
		--dbhost=${MYSQL_DB_SERVERNAME} \
		--dbname=${MYSQL_NAME_DB} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PWD}
	echo "-> Installing Wordpress settings"
	wp core install --allow-root \
		--url=${WORDPRESS_URL} \
		--title=${WORDPRESS_WEBTITLE} \
		--admin_user=${WORDPRESS_USER0} \
		--admin_password=${WORDPRESS_USER0_PWD} \
		--admin_email=${WORDPRESS_USER0_EMAIL} \
		--skip-email
	echo "-> Creating the 2-nd user"
	wp user create --allow-root \
		${WORDPRESS_USER1} \
		${WORDPRESS_USER1_EMAIL} \
		--role=${WORDPRESS_USER1_ROLE} \
		--user_pass=${WORDPRESS_USER1_PWD} \
		--display_name=${WORDPRESS_USER1_DNAME}
	# manage user-list:
		# wp user delete 2 --allow-root
	echo "-> Show summary information"
	wp user list --allow-root
	wp post list --allow-root
	echo "-> Creating the new post"
	wp post create --allow-root \
		--post_type=post \
		--post_title="POST №1" \
		--post_author=${WORDPRESS_USER1} \
		--post_content="Hello from Turkey" \
		--post_status=publish \
		--post_date="2022-09-02 07:00:00"
	wp post list --allow-root
fi

exec "$@"
