# Use Debian 11 as the base
FROM debian:11

# ---- 2. Install dependencies ----
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php \
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

# ---- 3. Set ServerName to suppress the warning ----
RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
    && a2enconf servername

# (Optional) Enable Apache modules you might need (e.g., php, rewrite).
RUN a2enmod php7.4
RUN a2enmod rewrite

# ---- 4. Download and setup WordPress ----
RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /tmp/ \
    && rm /tmp/wordpress.tar.gz \
    && mv /tmp/wordpress/* /var/www/html \
    && rm -rf /tmp/wordpress \
    && chown -R www-data:www-data /var/www/html

# ---- 5. Remove default index.html ----
RUN rm /var/www/html/index.html

# ---- 6. Expose port 80 for Apache ----
EXPOSE 80

# ---- 7. Copy and set up entrypoint script ----
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]