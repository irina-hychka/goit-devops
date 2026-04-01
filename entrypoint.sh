#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "Waiting for PostgreSQL..."

while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 1
done

echo "PostgreSQL is up."

# Apply database migrations before starting the app
python manage.py migrate --noinput

# Start Django with Gunicorn
exec gunicorn core.wsgi:application --bind 0.0.0.0:8000
