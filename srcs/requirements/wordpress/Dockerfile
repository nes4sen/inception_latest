FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-curl \
    curl \
    mariadb-client \
    php8.2-xml \
    php8.2-mbstring \
    php8.2-gd \
    php8.2-zip \
    php8.2-imagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/wp \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf \
    && echo 'clear_env = no' >> /etc/php/8.2/fpm/pool.d/www.conf

RUN mkdir -p /run/php /var/www/wordpress

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]
