FROM php:8.0-fpm-alpine

# Install required packages
RUN apk add --no-cache nginx supervisor shadow

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Create a non-root user
RUN useradd -m -s /bin/sh appuser

# Set working directory and give ownership to appuser
WORKDIR /var/www/html
COPY ./src /var/www/html
RUN chown -R appuser:appuser /var/www/html

# Copy Nginx config and Supervisor config
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

# Create directories for logs with correct permissions
RUN mkdir -p /var/log/supervisor /var/run/nginx /var/run/php-fpm \
    && chown -R appuser:appuser /var/log/supervisor /var/run/nginx /var/run/php-fpm

# Expose port 80
EXPOSE 80

# Switch to non-root user
USER appuser

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
