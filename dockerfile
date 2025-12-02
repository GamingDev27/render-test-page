FROM php:8.0-fpm-alpine

# Install common PHP extensions (optional)
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Expose PHP-FPM port
EXPOSE 9000

CMD ["php-fpm"]
