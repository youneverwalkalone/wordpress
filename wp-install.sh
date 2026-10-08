#!/bin/sh
set -e

until [ -f /var/www/html/wp-load.php ]; do
  echo "Waiting for WordPress core files..."
  sleep 2
done

if wp core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
  echo "WordPress already installed, skipping."
else
  echo "Installing WordPress..."
  until wp core install \
    --path=/var/www/html \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email \
    --allow-root; do
    echo "Install attempt failed, retrying in 5s..."
    sleep 5
  done
  echo "WordPress installed successfully."
fi
