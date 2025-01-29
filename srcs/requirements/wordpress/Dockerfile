# Use Debian 11 as base
FROM debian:11

# Set environment variables
ENV WORDPRESS_DB_HOST=mariadb
ENV WORDPRESS_DB_USER=${MYSQL_USER}
ENV WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}
ENV WORDPRESS_DB_NAME=${MYSQL_DATABASE}
ENV WORDPRESS_TABLE_PREFIX=wp_

# Install dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    php-intl \
    php-zip \
    curl \
    wget \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Download and setup WordPress
RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html/ && \
    rm /tmp/wordpress.tar.gz && \
    chown -R www-data:www-data /var/www/html/wordpress

# Expose Apache port
EXPOSE 80

# Copy the entrypoint script
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]
