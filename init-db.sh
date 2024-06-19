#!/bin/bash

# Wait for PostgreSQL to be ready
until pg_isready -h db -U user; do
  echo "Waiting for PostgreSQL to start..."
  sleep 2
done

# Apply migrations or other database setup if necessary (e.g., using alembic)
# Example:
# alembic upgrade head

# Start the FastAPI application
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
