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

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# (Optional) Enable Apache modules you might need (e.g., php, rewrite).
RUN a2enmod php7.4
RUN a2enmod rewrite

# ---- 5. Remove default index.html ----
RUN rm /var/www/html/index.html

# ---- 6. Expose port 80 for Apache ----
EXPOSE 80

# ---- 7. Copy and set up entrypoint script ----
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]