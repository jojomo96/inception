FROM debian:11

RUN apt-get update && apt-get install -y \
    php7.4-mysqli \
    php7.4-fpm \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]