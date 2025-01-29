#!/bin/bash
set -e

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
while ! mysqladmin ping -h"${WORDPRESS_DB_HOST}" --silent; do
    sleep 1
done


# Check if wp-config.php exists
if [ ! -f /var/www/html/wp-config.php ]; then
	cd /var/www/html
	wp core download \
	--allow-root


    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --dbprefix="${WORDPRESS_TABLE_PREFIX}" \
        --allow-root

    if ! wp core is-installed --allow-root; then
        wp core install \
            --url="${WORDPRESS_DOMAIN}" \
            --title="${WORDPRESS_TITLE}" \
            --admin_user="${WORDPRESS_ADMIN_USER}" \
            --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
            --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
            --allow-root
    else
        echo "WordPress is already installed. Skipping core installation."
    fi

    if ! wp user get "${WORDPRESS_USER}" --field=ID --allow-root > /dev/null 2>&1; then
        wp user create \
            "${WORDPRESS_USER}" \
            "${WORDPRESS_USER_EMAIL}" \
            --user_pass="${WORDPRESS_USER_PASSWORD}" \
            --allow-root
    else
        echo "User ${WORDPRESS_USER} already exists. Skipping user creation."
    fi


	echo "WordPress configuration complete."
fi

# Set correct permissions
chown -R www-data:www-data /var/www/html/

echo "WordPress is ready."

php-fpm7.4 -F