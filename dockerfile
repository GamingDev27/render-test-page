# Use Alpine-based PHP-FPM (lightest option)
FROM php:8.2-fpm-alpine

# Install only Nginx and essential PHP extensions
RUN apk add --no-cache \
    nginx \
    && apk add --no-cache --virtual .build-deps \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-install gd zip \
    && apk del .build-deps

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Set permissions (Alpine uses 'nobody' user)
RUN chown -R nobody:nobody /var/www/html && \
    chmod -R 755 /var/www/html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create necessary directories
RUN mkdir -p /run/nginx /var/log/nginx

# Expose port
EXPOSE 10000

# Startup script
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'set -e' >> /start.sh && \
    echo 'sed -i "s/listen 80/listen ${PORT:-10000}/g" /etc/nginx/nginx.conf' >> /start.sh && \
    echo 'php-fpm -D' >> /start.sh && \
    echo 'nginx -g "daemon off;"' >> /start.sh && \
    chmod +x /start.sh

CMD ["/start.sh"]