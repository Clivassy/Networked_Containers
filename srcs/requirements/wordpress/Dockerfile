FROM alpine:3.16

ARG PHP_VERSION=8 \
    DB_NAME \
    DB_USER \
    DB_PASS

# Rendre PHP-FPM accessible a partir des Conteneurs Docker externes
# listen : IP et ports sur lesquels PHP-FPM attend les connexions
# Listen.owner && listen.group : PHP-FPM peut s'executer avec les autorisations
# appropriees

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    mysql-client \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www

COPY ./requirements/wordpress/conf/wp-config-create.sh /tmp/wp-config-create.sh

RUN chmod -R 755 /var/www/
RUN chown -R nobody /var/www/
RUN chmod -R 777 /tmp/wp-config-create.sh

CMD ["/tmp/wp-config-create.sh"]
