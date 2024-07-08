#!/bin/bash

# Wait for PostgreSQL to be ready
until pg_isready -h db -U user; do
  echo "Waiting for PostgreSQL to start..."
  sleep 2
done

# Create database and apply migrations if needed
echo "Creating database and applying migrations..."
psql -h db -U user -d postgres -c "CREATE DATABASE arxiv;"
# Example: Run database migrations with alembic
# alembic upgrade head

echo "Database initialization complete."
