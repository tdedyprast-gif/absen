#!/bin/bash
set -e

echo "Fixing permissions..."
chown -R www-data:www-data storage bootstrap/cache || true
chmod -R 775 storage bootstrap/cache || true

echo "Installing dependencies (if missing)..."
if [ ! -d "vendor" ]; then
  composer install --no-interaction --prefer-dist --optimize-autoloader
fi

echo "Ensuring app key..."
if ! grep -q "^APP_KEY=base64" .env; then
  php artisan key:generate --force
fi

# Run Laravel setup in background
(
  echo "Waiting for DB..."
  until php artisan migrate:status > /dev/null 2>&1; do
    sleep 2
  done

  echo "Running migrations..."
  php artisan migrate --force || true

  echo "Clearing cache..."
  php artisan config:clear || true
) &

echo "Starting PHP-FPM..."
exec php-fpm -F