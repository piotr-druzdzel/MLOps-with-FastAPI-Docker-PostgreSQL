#!/bin/bash

# Initialize database
./init-db.sh &

# Start FastAPI application
uvicorn app.main:app --host 0.0.0.0 --port 8000
