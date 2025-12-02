FROM php:8.0-fpm-alpine

# Install required packages
RUN apk add --no-cache nginx supervisor

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy app source
COPY ./src /var/www/html

# Copy Nginx config
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy Supervisor config
COPY ./supervisord.conf /etc/supervisord.conf

# Expose port for Nginx
EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
