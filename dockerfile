# ----------------------
# Stage 1: Build / PHP extensions
# ----------------------
FROM php:8.0-fpm-alpine AS builder

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# ----------------------
# Stage 2: Final image
# ----------------------
FROM php:8.0-fpm-alpine

# Install runtime packages only (nginx, supervisor, shadow)
RUN apk add --no-cache nginx supervisor shadow

# Create non-root user
RUN adduser -D appuser

# Set working directory
WORKDIR /var/www/html

# Copy built PHP extensions from builder
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /usr/local/etc/php /usr/local/etc/php

# Copy application source
COPY ./src /var/www/html
RUN chown -R appuser:appuser /var/www/html

# Copy Nginx and Supervisor configs
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

# Create directories for logs and PID files
RUN mkdir -p /var/log/supervisor /var/run/nginx /var/run/php-fpm \
    && chown -R appuser:appuser /var/log/supervisor /var/run/php-fpm \
    && chown -R root:root /var/run/nginx

# Expose port 80
EXPOSE 80

# Use root to allow Nginx to bind port 80
USER root

# Start Supervisor to run both Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
