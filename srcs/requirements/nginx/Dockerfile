# Use Debian 11 as the base image
FROM debian:11

# Install Nginx
RUN apt-get update && apt-get install -y nginx \
            openssl \
            && rm -rf /var/lib/apt/lists/*

# Copy Nginx configuration file
COPY tools/nginx.conf /etc/nginx/sites-available/default

# Copy the custom entrypoint script
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
