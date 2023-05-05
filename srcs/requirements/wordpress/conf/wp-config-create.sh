#!/bin/sh

sleep 2

# Download and install WP-CLI
wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp

# Check if WordPress is installed
if [ ! -f "wp-config-sample.php" ]; then
	echo DOWNLOAD
	wp core download --allow-root
fi
echo  DOWNLOAD END

# Check if Wordpress is configured
if [ ! -f "wp-config.php" ]; then
	echo CONFIG
  # Install WordPress using WP-CLI
  wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_HOST} --allow-root
  wp core install --url=${DB_URL} --title=${DB_TITLE} --admin_user=${DB_USER} --admin_password=${DB_PASS} --admin_email=${DB_ADMIN_MAIL} --allow-root
  wp user create ${DB_NUSER} ${DB_NUSER_MAIL} \
				   --user_pass=${DB_NUSER_PASS} \
				   --allow-root
fi
echo END CONFIG

/usr/sbin/php-fpm8 -F -R
