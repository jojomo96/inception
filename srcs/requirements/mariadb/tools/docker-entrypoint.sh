#!/bin/bash
set -e

# Ensure the MySQL data directory exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB service in the background
echo "Starting MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking & pid="$!"

# Wait for MariaDB to be available
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping --silent; do
    sleep 1
done

# Run initialization SQL if this is the first run
if [ ! -f "/var/lib/mysql/.mariadb_initialized" ]; then
	echo "Setting up initial database..."
	mysql -u root <<-EOSQL
		CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
		FLUSH PRIVILEGES;
	EOSQL
touch /var/lib/mysql/.mariadb_initialized
fi

# Stop the temporary MariaDB instance
mysqladmin shutdown

# Run MariaDB in foreground
exec mariadbd --user=mysql --datadir=/var/lib/mysql
