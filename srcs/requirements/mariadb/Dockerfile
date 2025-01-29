# Use the Debian 11 base image
FROM debian:11

# Update package lists and install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server \
    gettext \
    && rm -rf /var/lib/apt/lists/*

## Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Copy the custom entrypoint script
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy the SQL initialization file
COPY tools/initialize_wordpress.sql /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

COPY tools/my.cnf /etc/mysql/my.cnf

# TODO remove
EXPOSE 3306
