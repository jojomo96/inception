# Use the Debian 11 base image
FROM debian:11

# Set environment variables for MariaDB configuration
# These are used during initialization by the MariaDB server
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Update package lists and install MariaDB server
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

## Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Copy the custom entrypoint script
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set entrypoint to the script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Optional: Copy a custom MariaDB configuration file (if needed)
COPY tools/my.cnf /etc/mysql/my.cnf

# Expose MariaDB's default port
EXPOSE 3306

# Command to start the MariaDB server
CMD ["mariadbd"]
