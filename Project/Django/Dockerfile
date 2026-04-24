# Use official lightweight Python image
FROM python:3.11-slim

# Disable .pyc files and enable logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside container
WORKDIR /app

# Install system dependencies required for PostgreSQL packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy dependencies file and install Python packages
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Django project files into the container
COPY app/ .

# Expose application port
EXPOSE 8000

# Run Django application using Gunicorn
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]