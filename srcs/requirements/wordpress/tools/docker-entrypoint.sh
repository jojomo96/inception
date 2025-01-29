#!/bin/bash
set -e

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
while ! mysqladmin ping -h"${WORDPRESS_DB_HOST}" --silent; do
    sleep 1
done

# Check if wp-config.php exists
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Creating wp-config.php..."
    cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wordpress/wp-config.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wordpress/wp-config.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wordpress/wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wordpress/wp-config.php
    sed -i "s/wp_/${WORDPRESS_TABLE_PREFIX}/" /var/www/html/wordpress/wp-config.php
fi

# Set correct permissions
chown -R www-data:www-data /var/www/html/wordpress

# Start Apache
exec apachectl -D FOREGROUND
