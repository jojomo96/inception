FROM debian:11

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download Adminer
RUN mkdir -p /var/www/html && \
    wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php

# Start PHP built-in server
CMD ["php", "-S", "0.0.0.0:9080", "-t", "/var/www/html"]